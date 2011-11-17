Page      = require 'dom/Page'
type      = require 'lang/type'

{EventEmitter} = require 'events2'
{tryThrow, tryCatch} = require 'util/try'

bridges = []

#
# Provides communication between XUL and HTML documents. Create a
# +Bridge+ by initializing one with an +HTMLDocument+ and then calling
# the +connect+ method:
#
#   bridge = new Bridge browser.contentDocument
#   bridge.connect()
#
# To evaluate some code over the bridge, use the +evaluate+ function:
#
#   bridge.evaluate "3+4", (result) -> alert "result=#{result}"
#
# You can also pass a function instead of a string, but be aware that
# the function's scope won't be included when it's run:
#
#   bridge.evaluate ->
#     # run on the HTML side
#     jQuery("*").click (event) ->
#       callback jQuery(event.target).attr("id")
#
#   , (data) ->
#     # run on the XUL side
#     if data
#       id = data[0]
#       logger.info "id of clicked element was ", id
#
class Bridge extends EventEmitter
  constructor: (@document, @callback) ->
    @document = Page.wrap(@document)
    @requests = {}
    @messageid = 1
    @connect @callback if @callback

  @forDocument: (doc) ->
    for {bridge, document} in bridges
      return bridge if doc is document

    bridge = new @ doc
    bridges.push {bridge, document}
    return bridge


  connect: (fn) ->
    @document.inject "(#{bootstrap})()"
    setTimeout (=> @attach fn), 10

  attach: (fn) ->
    element = @getBridgeElement()

    element.addEventListener "xulRespond", ((event) =>
      response = JSON.parse element.firstChild.nodeValue
      @dispatch response
    ), true

    fn?.call?(this, this)

  getBridgeElement: ->
    @document.byId("_xulBridge")

  evaluate: (script, fn) ->
    tryThrow 'Bridge.evaluate', =>
      script = "(#{script.toSource()})()" if type.isFunction(script)
      @request 'evaluate', script, fn

  request: (methodName, data, fn) ->
    element = @getBridgeElement()
    request =
      id: @messageid++
      data: data
      method: methodName
      connected: false
      callback: fn

    @requests[request.id] = request

    event = document.createEvent("Events")
    event.initEvent("xulDispatch", true, false)

    element.setAttribute "request", JSON.stringify(request)
    element.dispatchEvent event

  dispatch: (response) ->
    if response.id
      request = @requests[response.id]

      try
        request.callback?.call response, response.data
      catch e
        logger.error 'Bridge XUL callback function threw an error with response: ', response
        logger.error e
    else
      logger.warn 'bridge response did not contain an id'

    @emit 'response', response

#
# This function only exists so that the string inside it can be
# +eval+'ed inside an HTML document that we want to communicate with.
#
# Therefore we don't have access to any of the cool stuff available
# to the rest of the appliation, including logging, utility functions, etc.
#
bootstrap = `function() {
  function _xulBridge() {
    /**
     * Returns the element that we use to communicate with the XUL side.
     *
     * @private
     */
    this.getBridgeElement = function() {
      var element = document.getElementById("_xulBridge");
      if (!element) {
        element = document.createElement("div");
        element.setAttribute("id", "_xulBridge");
        element.setAttribute("style", "display:none");

        var self = this;
        element.addEventListener("xulDispatch", function(event) {
          var element  = event.target;
          var request  = JSON.parse(element.getAttribute("request"));
          self.dispatch(request);
        }, true);

        document.documentElement.appendChild(element);
      }
      return element;
    };

    /**
     * Dispatches a request sent by the XUL side and returns a response.
     *
     * @param request
     *   * +id:+ the id of the message sent from the XUL side.
     *   * +method:+ the method to call on the HTML side of the bridge.
     *   * +data:+ the data sent by the XUL side.
     *
     * @private
     */
    this.dispatch = function(request) {
      var response;

      try {
        response = this[request.method].call(this, request);
      } catch(e) {
        response = e;
        response.source = request.data;
      }
      this.notifyXul(request.id, response);
    };

    /**
     * Evaluates some JavaScript and provides a +callback+ function useful for
     * sending multiple responses back to the XUL side.
     *
     * @param request
     *   * +id:+ the id of the message sent from the XUL side.
     *   * +method:+ the method to call on the HTML side of the bridge.
     *   * +data:+ the data sent by the XUL side.
     *
     * @private
     */
    this.evaluate = function(request) {
      var fn = new Function('__scope__',
        'return eval("with(__scope__){'+request.data.replace(/"/g, '\\"')+'}")');
      var self = this, scope = {callback: function() {
        self.notifyXul(request.id, Array.prototype.slice.call(arguments));
      }};
      return fn.call(this, scope);
    };

    /**
     * Notifies the XUL side by id with the given data.
     *
     * @param id [Number]
     *   The number sent by the XUL side used for calling the right callback.
     * @param data
     *   The data to send back to the XUL side.
     *
     * @private
     */
    this.notifyXul = function(id, data) {
      var element = this.getBridgeElement();

      var event = document.createEvent("Events");
      event.initEvent("xulRespond", true, false);

      element.innerHTML = ""; // clear all children
      element.appendChild(document.createTextNode(JSON.stringify({id: id, data: data})));
      element.dispatchEvent(event);
    };

    this.getBridgeElement();
  };

  window._xulBridge = new _xulBridge();
}`.toSource()


module.exports = Bridge

wesabe.download.Player.register({
  fid: 'uk.co.hsbc',
  org: 'HSBC Bank (UK)',
  
  loginFields: [
    {'label': 'Internet Banking user ID', 'type': 'text', 'key': 'username'},
    {'label': 'Your Date of Birth (ddmmyy)', 'type': 'password', 'key': 'memorable'},
    {'label': 'Security Number', 'type': 'password', 'key': 'password'}
  ],

  dispatchFrames: false,
  afterDownload: 'nextAccount',

  actions: {
    main: function() {
      browser.go("http://www.hsbc.co.uk/1/2/HSBCINTEGRATION");
    },
  },

  includes: [
    'fi-scripts.uk.co.hsbc.login',
    'fi-scripts.uk.co.hsbc.accounts',
  ],
});

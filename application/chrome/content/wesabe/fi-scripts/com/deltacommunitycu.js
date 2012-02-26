// player for debugging purposes
wesabe.download.OFXPlayer.register({
  fid: 'com.deltacommunitycu',
  org: 'Delta Community Credit Union (Snap)',
  
  loginFields: [
    {'label': 'Account Number', 'type': 'text', 'key': 'username'},
    {'label': 'Access Code', 'type': 'password', 'key': 'password'}
  ],

  start: function() {
    wesabe.logger.level = 'radioactive';
    wesabe.download.OFXPlayer.prototype.start.apply(this, arguments); // super
  }
});

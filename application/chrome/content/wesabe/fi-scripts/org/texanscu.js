wesabe.download.Player.register({
  fid: 'org.texanscu',
  org: 'Texans Credit Union',
  
  loginFields: [
    {'label': 'User ID', 'type': 'text', 'key': 'username'},
    {'label': 'Password', 'type': 'password', 'key': 'password'}
  ],

  dispatchFrames: false,
  afterDownload: 'nextAccount',

  includes: [
    'fi-scripts.org.texanscu.login',
    'fi-scripts.org.texanscu.accounts',
  ],
});

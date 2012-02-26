wesabe.download.Player.register({
  fid: 'org.starone',
  org: 'Star One FCU',
  
  loginFields: [
    {'label': 'Member ID', 'type': 'text', 'key': 'username'},
    {'label': 'Password', 'type': 'password', 'key': 'password'}
  ],

  dispatchFrames: true,
  // afterDownload: uses custom onDownloadSuccessful

  includes: [
    'fi-scripts.org.starone.promos',
    'fi-scripts.org.starone.accounts',
  ],
});

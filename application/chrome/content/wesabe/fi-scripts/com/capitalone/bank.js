wesabe.download.OFXPlayer.register({
  fid: 'com.capitalone.bank',
  org: 'CapitalOne Bank',
  
  loginFields: [
    {'label': 'User ID', 'type': 'text', 'key': 'username'},
    {'label': 'Password', 'type': 'password', 'key': 'password'}
  ],

  DAYS_OF_HISTORY: 59
});

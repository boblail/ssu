wesabe.download.OFXPlayer.register({
  fid: 'com.addisonavenue',
  org: 'Addison Avenue Federal Credit Union',
  
  loginFields: [
    {'label': 'Account Number', 'type': 'text', 'key': 'username'},
    {'label': 'Pin', 'type': 'password', 'key': 'password'}
  ],

  DAYS_OF_HISTORY: 90,
});

wesabe.download.Player.register({
  fid: 'com.usbank',
  org: 'US Bank',
  
  loginFields: [
    {'label': 'User ID', 'type': 'text', 'key': 'username'},
    {'label': 'Password', 'type': 'password', 'key': 'password'}
  ],

  afterDownload: 'nextAccount',

  actions: {
    main: function() {
      // https://www4.usbank.com/internetBanking/RequestRouter?requestCmdId=DisplayLoginPage
      browser.go("http://www.usbank.com/");
    },
  },

  includes: [
    'fi-scripts.com.usbank.security',
    'fi-scripts.com.usbank.login',
    'fi-scripts.com.usbank.accounts',
  ],
});

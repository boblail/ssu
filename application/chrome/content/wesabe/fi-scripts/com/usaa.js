wesabe.download.OFXPlayer.register({
  fid: 'com.usaa',
  org: 'USAA Federal Savings Bank',
  
  loginFields: [
    {'label': 'Log-in ID', 'type': 'text', 'key': 'username'},
    {'label': 'Password', 'type': 'password', 'key': 'password'}
  ],

  fi: {
    ofxFid: "24591",
    ofxOrg: "USAA",
    ofxUrl: "https://service2.usaa.com/ofx/OFXServlet",
  },
});

wesabe.download.OFXPlayer.register({
  fid: 'com.psecu',
  org: 'PSECU',
  
  loginFields: [
    {'label': 'Member Number', 'type': 'text', 'key': 'username'},
    {'label': 'PIN', 'type': 'password', 'key': 'pin'},
    {'label': 'Password', 'type': 'password', 'key': 'password'}
  ],

  get creds() {
    return this.__creds__;
  },

  set creds(creds) {
    // the actual password is PIN + Password
    if (creds.pin) {
      creds.password = creds.pin + creds.password;
    }

    return this.__creds__ = creds
  }
});

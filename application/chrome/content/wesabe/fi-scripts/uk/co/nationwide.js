wesabe.download.OFXPlayer.register({
  fid: 'uk.co.nationwide',
  org: 'Nationwide (UK)',
  
  loginFields: [
    {'label': 'Customer Number', 'type': 'text', 'key': 'username'},
    {'label': 'Passnumber', 'type': 'password', 'key': 'password'},
    {'label': 'Memorable Data', 'type': 'password', 'key': 'memorable'}
  ],

  get creds() {
    return this.__creds__;
  },

  set creds(creds) {
    // pad the username with leading zeros so that it's 10 digits
    if (creds.username) {
      while (creds.username.length < 10)
        creds.username = '0' + creds.username;
    }

    // the actual password is Memorable Data + Passnumber
    if (creds.memorable) {
      creds.password = creds.memorable + creds.password;
    }

    return this.__creds__ = creds
  }
});

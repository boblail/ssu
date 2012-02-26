wesabe.download.Player.register
  fid: 'com.bankofamerica'
  org: 'Bank of America'
  
  loginFields: [
    {'label': 'Online ID', 'type': 'text', 'key': 'username'}
    {'label': 'Passcode', 'type': 'password', 'key': 'password'}
    {'label': 'State', 'type': 'state', 'key': 'state'}
  ]

  dispatchFrames: false
  afterDownload: 'nextAccount'

  includes: [
    'fi-scripts.com.bankofamerica.global'
    'fi-scripts.com.bankofamerica.mobile'
    'fi-scripts.com.bankofamerica.promos'
    'fi-scripts.com.bankofamerica.loans'
    'fi-scripts.com.bankofamerica.investing'
    'fi-scripts.com.bankofamerica.login'
    'fi-scripts.com.bankofamerica.accounts'
    'fi-scripts.com.bankofamerica.northwest'
    'fi-scripts.com.bankofamerica.passwordStrengthNotice'
  ]

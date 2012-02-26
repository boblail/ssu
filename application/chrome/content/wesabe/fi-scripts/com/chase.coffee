wesabe.download.CompoundPlayer.register
  fid: 'com.chase'
  org: 'Chase'
  
  loginFields: [
    {'label': 'User ID', 'type': 'text', 'key': 'username'}
    {'label': 'Password', 'type': 'password', 'key': 'password'}
  ]

  players: [
    wesabe.download.OFXPlayer.create
      fid: 'com.chase'
      org: 'Chase'

      fi:
        ofxUrl: "https://ofx.chase.com"
        ofxOrg: "B1"
        ofxFid: "10898"

    wesabe.download.Player.create
      fid: 'com.chase'
      org: 'Chase'

      dispatchFrames: false
      afterDownload: 'nextAccount'
      afterLastGoal: 'logoff'

      includes: [
        'fi-scripts.com.chase.promos'
        'fi-scripts.com.chase.login'
        'fi-scripts.com.chase.identification'
        'fi-scripts.com.chase.ofx'
        'fi-scripts.com.chase.transfers'
        'fi-scripts.com.chase.errors'
      ]
  ]

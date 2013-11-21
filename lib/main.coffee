self = require('sdk/self')
widgets = require('sdk/widget')
panels = require('sdk/panel')
tabs = require('sdk/tabs')
Request = require('sdk/request').Request
ss = require("sdk/simple-storage")
S = require('./libs/string.min.js')
helpers = require('./helpers.js')


main_panel = panels.Panel({
  width: 300,
  height: 400,
  contentURL: self.data.url("templates/main_page.html")
  contentScriptFile: self.data.url("main_panel.js")
})

widget = widgets.Widget({
  id: "foxo",
  label: "foxo helper",
  contentURL: self.data.url("assets/img/weibo_ico_48x48.png"),
  panel: main_panel
})

main_panel.port.on('click_m_btn', () ->
  tabs.open({
    url: """https://api.weibo.com/oauth2/authorize?
            client_id=1416063824&
            redirect_uri=https://api.weibo.com/oauth2/default.html&
            response_type=code""",
    onReady: (tab) ->
      if S(tab.url).include('default.html?code=')
        [n, code] = tab.url.split('=')
        Request({
          url: """https://api.weibo.com/oauth2/access_token?
                  client_id=1416063824&
                  client_secret=40d9b5dbe0b1c62172d341333be7832b&
                  grant_type=authorization_code&
                  redirect_uri=https://api.weibo.com/oauth2/default.html&
                  code=#{code}""",
          onComplete: (res) ->
            res = JSON.parse(res.text)
            ss.storage.token = res.access_token
            ss.storage.token_remind_in = res.token_remind_in
        }).post()
        tab.close()
      return
  })
  return
)

#tabs.on('ready', (tab) ->
#  helpers.auth_code(S, ss)
#  if S(tab.url).startsWith("http://127")
#    [n, code] = tab.url.split('=')
#    tab.close()
#  return
#)
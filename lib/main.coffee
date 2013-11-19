self = require('sdk/self')
widgets = require('sdk/widget')
panels = require('sdk/panel')
tabs = require('sdk/tabs')
ss = require("sdk/simple-storage")
S = require('./libs/string.min.js')
helpers = require('./helpers.js')

ss.storage.wb_token = 'something'

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
  tabs.open('https://api.weibo.com/oauth2/authorize?client_id=1416063824&redirect_uri=http://127.0.01:5000/response&response_type=code')
  return
)

tabs.on('ready', (tab) ->
  helpers.auth_code(S, ss)
  if S(tab.url).startsWith("http://127")
    [n, code] = tab.url.split('=')
    tab.close()
  return
)
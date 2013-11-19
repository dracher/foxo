main_btn = document.getElementById('main_btn')

main_btn.addEventListener('click', () ->
  self.port.emit('click_m_btn')
  return
)
exports.auth_code = (x, y) ->
  S = x
  ss = y
  if S(ss.storage.wb_token).isEmpty()
    console.log("No token found")
    return false
  else
    console.log("Token is there")
    console.log(ss.storage.wb_token)
    return true
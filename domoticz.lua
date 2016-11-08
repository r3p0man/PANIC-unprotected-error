
function domoticz()
  local uri = "http://"..def.DOMOTICZIP..':'..def.DOMOTICZPORT..def.DOMOTICZURL
  uri=string.gsub(uri, '@@VAR2', var.watysuma)
  uri=string.gsub(uri, '@@VAR1', var.watysrednia)
 http.request(uri, "HEAD", def.DOMOTICZHEADER, "", function(code, data)
    if (code < 0) then
      print("DOMOTICZ request failed")
      print(" http://" .. wifi.sta.getip()..  " i skoncz konfigurowac diwajs!!")
     else
      print( 'http code:', code )
      print( 'http data:', data )
    end
  end)
  uri = nil
  collectgarbage()
end


if def.configured==0 then
		    print("Idz pan tutaj: http://" .. wifi.sta.getip()..  " i skoncz konfigurowac diwajs")
else
node.task.post(1, domoticz)
end
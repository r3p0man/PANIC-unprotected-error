network = {}

local function init(fifi)
  wifi.setmode(fifi.mode)
  print('set (mode='..wifi.getmode()..')')
  print('Client MAC: ',wifi.sta.getmac())
  wifi.sta.config(fifi.ssid, fifi.pass,1)
end

local function szowip()
  if def.configured==0 then
    print("Idz pan tutaj: http://" .. wifi.sta.getip()..  " i skoncz konfigurowac diwajs")
  else
    print("znaleziono konfiguracje, webserwer: http://" .. wifi.sta.getip() )
  end
end


function network.Connect(fifi,callback)
  init(fifi)
  tmr.alarm(0, 5000, tmr.ALARM_AUTO, function()
    local ip = wifi.sta.getip()
    if ip ~= nil then    -- polaczono
      szowip()
      callback()
      ip = nil
      collectgarbage()
      tmr.stop(0)
      tmr.unregister(0)
    else
      print('blad polaczenia wifi..')
    end -- end if ip
  end) -- end timer
end -- function

return network





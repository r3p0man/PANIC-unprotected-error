network = {}

function network.init(fifi)
	wifi.setmode(fifi.mode)
	print('set (mode='..wifi.getmode()..')')
	print('Client MAC: ',wifi.sta.getmac())
	wifi.sta.config(fifi.ssid, fifi.pass,1)
end


function network.Connect(fifi,callback)
	network.init(fifi)
	tmr.alarm(0, 5000, tmr.ALARM_AUTO, function()
		local ip = wifi.sta.getip()
		if ip ~= nil then    -- polaczono
			print('IP: ',ip)
			callback()
			ip = nil
			collectgarbage()
			tmr.stop(0)
			tmr.unregister(0)
		end -- end if ip
	end) -- end timer
end -- function

return network



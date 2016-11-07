
--[[function domoticz()

  conn = net.createConnection(net.TCP, 0)
  conn:connect(def.DOMOTICZPORT,def.DOMOTICZIP)
  conn:on("disconnection",
    function(conn, payload)
      collectgarbage()
    end)
  conn:on("connection",
    function(conn, payload)
      conn:send()
    end)  

  conn:on("sent", function()
    conn:close()
    end)  
  end]]

function domoticz()
  local uri = "http://"..def.DOMOTICZIP..':'..def.DOMOTICZPORT..def.DOMOTICZURL
  uri=string.gsub(uri, '@@VAR1', var.kwatts)
  uri=string.gsub(uri, '@@VAR2', var.watts)
 --http.request(url, method, headers, body, callback)
 http.request(uri, "HEAD", def.DOMOTICZHEADER, "", function(code, data)
 -- http.get(uri, header, function(code, data)
    if (code < 0) then
      print("HTTP request failed:")
    end
  end)
  uri = nil
  collectgarbage()
end


node.task.post(1, domoticz)
local function sendAttr(connection, attr, val)
  connection:send("<li><b>".. attr .. ":</b> " .. val .. "<br></li>\n")
end
return function (connection, req, args)
  dofile("httpserver-header.lc")(connection, 200, 'html')
  connection:send('<!DOCTYPE html><html lang="en"><head><meta http-equiv="refresh" content="15"><title>Info mocy :)</title> </head><body>')
  connection:send('<h3>Power info</h3><ul>')
  sendAttr(connection, "Status konfiguracji"      , tostring(def.configured))
  sendAttr(connection, "Wh sumarycznie"      , tostring(var.watysuma))
  sendAttr(connection, "Waty teraz (srednia z 5 minut)"   , tostring(var.watysrednia))
  sendAttr(connection, "Aktywna minuta"           , 'm-'..tostring(minuta))
  sendAttr(connection, "Waty m-1"               , tostring(a[1]*60 ))
  sendAttr(connection, "Waty m-2"               , tostring(a[2]*60 ))
  sendAttr(connection, "Waty m-3"               , tostring(a[3]*60 ))
  sendAttr(connection, "Waty m-4"               , tostring(a[4]*60 ))
  sendAttr(connection, "Waty m-5"               , tostring(a[5]*60 ))

  connection:send('</ul></body></html>')
end

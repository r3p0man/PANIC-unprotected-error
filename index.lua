local function sendAttr(connection, attr, val)
   connection:send("<li><b>".. attr .. ":</b> " .. val .. "<br></li>\n")
end 


 local function getinfo(connection)
 connection:send('<h3>Node info</h3><ul>')
   majorVer, minorVer, devVer, chipid, flashid, flashsize, flashmode, flashspeed = node.info();
   sendAttr(connection, "NodeMCU version"       , majorVer.."."..minorVer.."."..devVer)
   sendAttr(connection, "chipid"                , chipid)
   sendAttr(connection, "flashid"               , flashid)
   sendAttr(connection, "flashsize"             , flashsize)
   sendAttr(connection, "flashmode"             , flashmode)
   sendAttr(connection, "flashspeed"            , flashspeed)
   sendAttr(connection, "node.heap()"           , node.heap())
   sendAttr(connection, 'Memory in use (KB)'    , collectgarbage("count"))
   sendAttr(connection, 'IP address'            , wifi.sta.getip())
   sendAttr(connection, 'MAC address'           , wifi.sta.getmac())
   connection:send('</ul>')
   end

local function wattinfo(connection)
   connection:send('<h3>WAT info</h3><ul>')
   sendAttr(connection, "Waty sumarycznie"      , tostring(var.kwatts))
   sendAttr(connection, "Waty teraz (5 minut)"   , tostring(var.watts))
   sendAttr(connection, "Waty teraz (1 minuta)"   , tostring(a[minuta]*10/15))
   sendAttr(connection, "Impulsy"               , tostring(var.counter))  
   
   connection:send('</ul>')
   end


return function (connection, req, args)
	local buf = nil
	dofile("httpserver-header.lc")(connection, 200, 'html')

	if req.method == "POST" then
		def = req.getRequestData()
		ok,  buf = pcall(cjson.encode, def)
		if ok then   -- jak poprawne dane
			filesave("configfile.txt",buf)
		else          --jak nie to odtwarzamy z pliku
			buf=fileread("configfile.txt")
			if buf ~= false then
				def = cjson.decode(buf)
			end
		end
	end
	-- to sie wyswietla zawsze
	buf = fileread("index.web")
	for  i,v in pairs(def) do
		buf=(string.gsub(buf, '@@'..tostring(i), v))
		--print(i..' '..v)
	end



	connection:send(buf)	
	wattinfo(connection)
	getinfo(connection)
	connection:send('</body></html>')

	buf=nil
	i=nil
	v=nil
	collectgarbage();

end

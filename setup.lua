local function sendpage(connection,line)
  for  i,v in pairs(def) do
    if  string.find(line, '@@'..tostring(i)) then
      line=(string.gsub(line, '@@'..tostring(i), v))
    end
  end
  connection:send(tostring(line))
  line,i,v=nil
  collectgarbage();
end


return function (connection, req, args)
  local buf = nil
  dofile("httpserver-header.lc")(connection, 200, 'html')

  if req.method == "POST" then
    def = req.getRequestData()
    if def.taryfikator ~= '0'  then
      var.watysuma = def.taryfikator
      def.taryfikator = 0
    end


    ok,  buf = pcall(cjson.encode, def)
    if ok then   -- jak poprawne dane
      def.configured= 1
      filesave("zapisanyconfig.txt",buf)
      print('skonfigurowano!')
    else          --jak nie to odtwarzamy z pliku
      buf=fileread("zapisanyconfig.txt")
      if buf ~= false then
        def = cjson.decode(buf)
      end
    end
  end  -- end post

  -- to sie wyswietla zawsze
  buf = ''
  if file.exists("index.web") then
    file.open("index.web")
    while buf ~= nil
    do
      sendpage(connection,buf)
      buf = file.readline()
    end
    file.close()
  end

  connection:send('</body></html>')

  buf=nil
  i = nil
  v = nil

  collectgarbage();

end

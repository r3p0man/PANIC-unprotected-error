

function fileread(filename)
   if file.exists(filename)then
      file.open(filename)
        line = file.read()
        if (line ~= nil) then return line 
        else return false end
    else
      return false -- plik  nie istnieje 
    end
end

function filesave(filename,buf)
    file.open(filename, "w+")
    file.write(buf)
    file.close()
    filename=nil
    buf=nil
    collectgarbage()
end

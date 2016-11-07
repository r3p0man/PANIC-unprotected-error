

function fileread(filename)
   if file.exists(filename)then
      file.open(filename)
      while true
      do
        line = file.read()
        if (line == nil) then
          file.close()
          break
        end
      return line
      end
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

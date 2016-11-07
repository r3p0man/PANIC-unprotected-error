






local compileAndRemoveIfNeeded = function(f)
    if file.open(f) then
    file.close()
        print('Compiling:', f)
        node.compile(f)
        file.remove(f)
        collectgarbage()
    end
end

-- czyscimy z niepotrzebnych plikow
local serverFiles = {
    'config.lua',
    'domoticz.lua',
    'network.lua',
    'pincheck.lua',
    'filerw.lua',
    'httpserver.lua',
    'httpserver-b64decode.lua',
    'httpserver-basicauth.lua',
    'httpserver-conf.lua',
    'httpserver-connection.lua',
    'httpserver-error.lua',
    'httpserver-header.lua',
    'httpserver-request.lua',
    'httpserver-static.lua',
}

for i, f in ipairs(serverFiles) do compileAndRemoveIfNeeded(f) end

compileAndRemoveIfNeeded = nil
serverFiles = nil
collectgarbage()

require 'filerw'
dofile('config.lc')

local function var_to_file()  -- save default values
   local tmp = nil
  ok, tmp = pcall(cjson.encode, def)
    if ok then 
        file.remove("configfile.txt")
        filesave("configfile.txt",tmp) end
    tmp = nil
    collectgarbage()
end

local function var_from_file()
if file.exists("configfile.txt") then
    local tmp=fileread("configfile.txt")
    def = cjson.decode(tmp)
    for  i,v in pairs(def) do 
        if v == nil then 
          file.remove("configfile.txt")
          node.restart()
          end 
     end
else

   var_to_file()
end
tmp =nil
collectgarbage()
end

var_from_file()
print('chip: ',node.chipid())
print('heap: ',node.heap())

local network = require 'network'
network.Connect(fifi, function()
    dofile("httpserver.lc")(80)
end)


network=nil
fifi=nil
collectgarbage()
dofile("pincheck.lc") -- sprawdzaj stan













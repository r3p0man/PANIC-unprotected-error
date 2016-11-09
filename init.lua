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
  'update.lua',
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
  'wget.lua',
}

for i, f in ipairs(serverFiles) do compileAndRemoveIfNeeded(f) end

compileAndRemoveIfNeeded = nil
serverFiles = nil
collectgarbage()


dofile('config.lc')


print('chip: ',node.chipid())
print('heap: ',node.heap())


local network = require 'network'

network.Connect(fifi, function()
  dofile("httpserver.lc")(80)
end)

dofile("pincheck.lc") -- sprawdzaj stan


network=nil
fifi=nil
collectgarbage()

























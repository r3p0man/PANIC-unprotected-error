require 'filerw'

fifi={}
fifi.ssid='Rithien-n'
fifi.pass='haslohaslo'
fifi.mode=wifi.STATIONAP

-- default values  - don't edit
def = {}
def.configured=0
def.ledcheck = 15
def.gpio = 1
def.DOMOTICZPORT = "2222"
def.DOMOTICZIP = 'domoticz host'
def.DOMOTICZURL = '/json.htm?param=udevice&type=command&idx=43&nvalue=0&svalue=@@VAR1;@@VAR2'
def.DOMOTICZHEADER = "Connection: close\r\nUser-Agent: Hujoza/5.0"

var = {}
var.counter=0   -- licznik impulsow
var.watysuma=0    -- licznik kwatów sumaryczny
var.watysrednia=0     -- waty z 5 minut minut
last=0          -- last led state



local function var_to_file()  -- save default values
  local tmp = nil
  ok, tmp = pcall(cjson.encode, def)
  if ok then
    file.remove("zapisanyconfig.txt")
    filesave("zapisanyconfig.txt",tmp) end
  tmp = nil
  collectgarbage()
end


node.setcpufreq(160)
if file.exists("zapisanyconfig.txt") then
  def = cjson.decode(fileread("zapisanyconfig.txt"))
else -- utworz defaultowy config
  var_to_file()
end

tmp = nil
var_to_file = nil
collectgarbage()







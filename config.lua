
fifi={}
fifi.ssid='Rithien-n'
fifi.pass='haslowifi'
fifi.mode=wifi.STATIONAP

-- default values  - don't edit
def = {}
def.ledcheck = 15
def.gpio = 1
def.taryfikator = 1500
def.DOMOTICZPORT = "2222"
def.DOMOTICZIP = 'domoticz host'
def.DOMOTICZURL = '/json.htm?param=udevice&type=command&idx=43&nvalue=0&svalue=@@VAR1;@@VAR2'
def.DOMOTICZHEADER = "Connection: close\r\nUser-Agent: Hujoza/5.0"

var = {}
var.counter=0   -- licznik impulsow
var.kwatts=0    -- licznik kwatów sumaryczny
var.watts=0     -- waty z 5 minut minut
last=0          -- last led state

node.setcpufreq(160)

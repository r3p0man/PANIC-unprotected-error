-- ********zliczamy impulsy********
function pincheckPik()
 -- var.counter = var.counter + 1
  a[minuta]=a[minuta]+1
  --if var.counter ==  3 then  stary mariusza 1500/1kWh
   -- var.counter = 0
    var.watysuma = var.watysuma+1
  end
end


-- ********opcja timera********
function pincheckTimecheck()
  local teraz
  teraz = gpio.read(def.gpio)
  if teraz < last then          -- jak "down"
    --if teraz > last then      -- jak "up"
    --if teraz ~= last then     -- jak "both"
    --se odkomentuj zaleznie czy down czy up czy both
    node.task.post(2,pincheckPik)
    --pincheckPik()
  end
  last = teraz
end



--******** opcja przerwan -nieuzywane tutaj - nie skonczone********
function pincheckInterruptcheck()
  gpio.trig(czujnikled , "down", function()
    pincheckPik()
    -- se uzyj debounce czy cus
  end)
end

-- ********funkce wykonywane cyklicznie********
function pincheckCyklicznie()
  local m = 0
  print("\r\n")
  print('k-waty sumarycznie ' ..var.watysuma..' kW' )
  --print('counter ' ,var.counter )

  var.watysrednia = 0
  for m=1, 5 do
    var.watysrednia=var.watysrednia+( a[m]*60 )
    print('impulsy minuta nr:'..m.. ' = '..a[m])
  end

  var.watysrednia=var.watysrednia/5
  print('waty teraz (srednia z 5 minut) :' ..var.watysrednia..'W')
  print('heap :', node.heap())

  if minuta >= 5 then
    minuta = 1
  else
    minuta = minuta+1
  end
  a[minuta]=0

  ok, json = pcall(cjson.encode, var)
  if ok then
    filesave("temp.txt",json)
  end
  --wysylamy do domoticza
  if  wifi.sta.getip() ~= nil  then dofile('domoticz.lc')   end

  m = nil
  collectgarbage()
end

--********inicjujemy zmienne********
local function init()

  local tmp=fileread("temp.txt")
  if tmp ~= false then
    var =cjson.decode(tmp)
  end

  if type(var.counter)  ~= 'number' then var.counter = 0 end
  if type(var.watysuma) ~= 'number' then var.watysuma = 0 end
  if type(var.watysrednia) ~= 'number' then var.watysrednia = 0 end

  tmp =nil
  collectgarbage()
end

--[[

****************************************************************

-- jak ledcheck - 0 to tryb przerwan

-- jak ustawiona wartosc to timer mode]]

a={0,0,0,0,0}
minuta = 1

if def.ledcheck == 0 then
  gpio.mode(def.gpio, gpio.INT,gpio.PULLUP) --interrupt
  pincheckInterruptcheck()
else
  gpio.mode(def.gpio, gpio.INPUT,gpio.PULLUP) -- timer
  tmr.register(2, def.ledcheck, tmr.ALARM_AUTO, pincheckTimecheck)
  tmr.start(2)
end

--zmienne pobieramy z pliku - jednorazowo
init()
init=nil
collectgarbage()

tmr.alarm(4, 60000, tmr.ALARM_AUTO, function()
  node.task.post(0,pincheckCyklicznie)
end  )







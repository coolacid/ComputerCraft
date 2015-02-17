-- By @Coolacid
-- Detect players and display their name in a Glass Hud
-- Multiple Sensors using modems and network cable
-- Place a modem on the Advanced Computer, then apply network cable to your locations
-- Place a new Sensor on top of the cable, and attach a modem
-- Click on the modem to activate it on the network

glass = peripheral.wrap("right") -- Where the Glasses Controller is
glass.clear()

local radars = {}
local lines = {}

glasstime = glass.addText(5,2,"Time: ", 0xFF0000)

for _, name in pairs(peripheral.getNames()) do
  if peripheral.getType(name) == "openperipheral_sensor" then
    print ("Found: " .. name)
    table.insert(radars, peripheral.wrap(name))
  end
end

-- Ripped from http://stackoverflow.com/a/1283608
function tableMerge(t1, t2)
    for k,v in pairs(t2) do
    	if type(v) == "table" then
    		if type(t1[k] or false) == "table" then
    			tableMerge(t1[k] or {}, t2[k] or {})
    		else
    			t1[k] = v
    		end
    	else
    		t1[k] = v
    	end
    end
    return t1
end

function timeDis()
  time = textutils.formatTime(os.time(), false)
  glasstime.setText("Time: " .. time)
end

function ClearLines()
  for k,v in pairs(lines) do
    lines[k].setText("")
  end
end

function deDupe(items)
  flags = {}
  res = {}
  for _,item in pairs(items) do
   if not flags[item.name] then
      table.insert(res, item)
      flags[item.name] = true
   end
  end
  return res
end

function getTargets()
  players = {}
  i=10
  for _, radar in pairs (radars) do
    for _, player in pairs (radar.getPlayers()) do
      table.insert(players,player)
    end
  end
  newplayers = deDupe(players)
  ClearLines()
  for k,v in pairs(newplayers) do
    if lines[i] == nil then
      lines[i] = glass.addText(5,i,"Player Detected: " .. v.name, 0xFF0000)
    else
      lines[i].setText("Player Detected: " .. v.name)
    end
    i=i+10
  end
end

function start()
  while true do
    getTargets()
    timeDis()
    sleep(0.1)
    glass.sync()
  end
end

start()
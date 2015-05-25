-- Written By CoolAcid
-- https://github.com/coolacid/ComputerCraft

-- label set SomeKindOfNameHere
-- pastebin get WdiT6sR5 bootstrap
-- bootstrap
-- github get coolacid/ComputerCraft/master/MCStatus/light.lua startup
-- startup

-- The proxy URL to use
serverid = "http://localhost:8001/jason"

-- SleepTime is how often to grab new data. Set here to one minute.
-- Set it too fast and twitch will flag you for spam
-- and stop giving you data
SleepTime = 60

-- Side to set the redstone signal on
SignalSide = "top"

-- Check to see if the JSON api exists. Otherwise, download it. 
if not fs.exists('json') then
	print("JSON API not found - Downloading")
	shell.run("pastebin get 4nRg9CHU json")
end

os.loadAPI("json")

function getCount()
  str = http.get(serverid).readAll()
  print(str)
  obj = json.decode(str)
  if obj.online == nil then
    return nil
  else
    return obj.online
  end
end

while true do
  local status, count = pcall(getCount)
  if status and count > 0 then
    redstone.setOutput(SignalSide, true)
  else
    redstone.setOutput(SignalSide, false)
  end
  sleep(SleepTime)
end

-- Written By CoolAcid
-- https://github.com/coolacid/ComputerCraft

-- label set SomeKindOfNameHere
-- pastebin get WdiT6sR5 bootstrap
-- bootstrap
-- github get coolacid/ComputerCraft/master/TwitchSub/subdisplay.lua startup
-- startup

-- Twitch Name of the Streamer
proxyurl = "http://localhost:1337/waffle"

-- SleepTime is how often to grab new data. Set here to one minute.
-- Set it too fast and twitch will flag you for spam
-- and stop giving you data
SleepTime = 60

-- Check to see if the JSON api exists. Otherwise, download it. 
if not fs.exists('json') then
	print("JSON API not found - Downloading")
	shell.run("pastebin get 4nRg9CHU json")
end

os.loadAPI("json")
local m = peripheral.find("monitor")

m.setTextColor(colors.blue)
m.setTextScale(1)
m.setBackgroundColor(colors.white)

function getSubs()
  str = http.get(proxyurl).readAll()
  obj = json.decode(str)
  lastsub = json.encodePretty(obj.subscriptions[1].user.display_name)
  lastsub = lastsub:gsub('"', '')
  return lastsub
end

while true do
  local status, lastsub = pcall(getSubs)

  m.clear()
  m.setCursorPos(1,1)
  if status then 
    m.write("Last Sub: " .. lastsub)
  else
    m.write("Last Sub: ERROR")
  end

  sleep(SleepTime)
end

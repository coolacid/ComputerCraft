-- Written By CoolAcid
-- https://github.com/coolacid/ComputerCraft

-- label set SomeKindOfNameHere
-- pastebin get WdiT6sR5 bootstrap
-- bootstrap
-- github get coolacid/ComputerCraft/master/TwitchSub/submulti.lua startup
-- startup

-- Twitch Name of the Streamer
proxyurl = "http://localhost:1337/waffle"

-- Center Display
center = true

-- SleepTime is how often to grab new data. Set here to one minute.
-- Set it too fast and twitch will flag you for spam
-- and stop giving you data
SleepTime = 60

-- Check to see if the JSON api exists. Otherwise, download it. 
if not fs.exists('json') then
	print("JSON API not found - Downloading")
	shell.run("pastebin get 4nRg9CHU json")
end

if not fs.exists('functions') then
	print("functions not found - Downloading")
	shell.run("github get coolacid/ComputerCraft/master/functions.lua functions")
end

os.loadAPI("json")
os.loadAPI("functions")

local m = peripheral.find("monitor")

m.setTextColor(colors.blue)
m.setTextScale(1)
m.setBackgroundColor(colors.white)

function getSubs()
  str = http.get(proxyurl).readAll()
  obj = json.decode(str)
  local subs = {}
  for _,k in pairs(obj.subscriptions) do
     local sub = json.encodePretty(k.user.display_name)
     table.insert(subs, sub:gsub('"', '')
  end
  return subs
end

while true do
  local status, subs = pcall(getSubs)

  m.clear()

  if status then 
    for _,k in pairs (subs) do
      text = "Last Sub: " .. sub
      if center then
        functions.centerText(m,text,y)
      else 
        m.setCursorPos(1,y)
      end
    m.write(text)
    end
  else
    m.setCursorPos(1,1)
    text = "Last Sub: ERROR"
  end


  sleep(SleepTime)
end

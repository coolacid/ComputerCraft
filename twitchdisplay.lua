-- Written By CoolAcid
-- https://github.com/coolacid/ComputerCraft

-- Based on the original work by bacon_donut
-- http://pastebin.com/vhn1z23v
-- http://twitch.tv/bacon_donut

-- This is formatted to fit on a 1x3 wall of Advanced Monitors with an Advanced Computer connected to a side
-- To get this to work you need to edit the streamid variable then run these four commands:

-- label set SomeKindOfNameHere
-- pastebin get WdiT6sR5 bootstrap
-- github get coolacid/ComputerCraft/master/twitchdisplay.lua startup
-- startup

-- Twitch Name of the Streamer
streamid = "Bacon_Donut"

-- SleepTime is how often to grab new data. Set here to one minute.
-- Set it too fast and twitch will flag you for spam
-- and stop giving you data
SleepTime = 60

-- Check to see if the JSON api exists. Otherwise, download it. 
if not fs.exists('json') then
	write("JSON API not found - Downloading")
	shell.run("pastebin get 4nRg9CHU json")
end

os.loadAPI("json")
local m = peripheral.find("monitor")
m.setCursorPos(1,1)

function getFollowers()
  str = http.get("https://api.twitch.tv/kraken/channels/" .. streamid .. "/follows?limit=1").readAll()
  obj = json.decode(str)
  follows = json.encodePretty(obj._total)
  follower = json.encodePretty(obj.follows[1].user.name)
  return follows, follower
end

function getViewerCount()
  str = http.get("https://api.twitch.tv/kraken/streams/" .. streamid).readAll()
  obj = json.decode(str)
  if obj.stream == nil then
    return nil
  else
    return json.encodePretty(obj.stream.viewers)
  end
end

while true do
  m.setTextColor(colors.blue)
  m.setTextScale(1)

  local status, live = pcall(getViewerCount)

  if status then 
    m.setCursorPos(1,1)
    if live == nil then
      m.setBackgroundColor(colors.white)
      m.clear()
      m.write(streamid)
      m.setCursorPos(1,5)  
      m.write("Live Viewers: Offline")
    else
      m.setBackgroundColor(colors.yellow)
      m.clear()
      m.write(streamid)
      m.setCursorPos(1,5)
      m.write("Live Viewers: " .. live)
    end
  else
      m.setBackgroundColor(colors.white)
      m.clear()
      m.write(streamid)
      m.setCursorPos(1,5)
      m.write("Live Viewers: ERROR")
  end

  local status, followers, follower = pcall(getFollowers)

  if status then
    m.setCursorPos(1,3)  
    m.write("Twitch Followers: " .. followers)

    m.setCursorPos(1,4)
    m.write("Last Follower: " .. follower)
  else
    m.setCursorPos(1,3)  
    m.write("Twitch Followers: ERROR")

    m.setCursorPos(1,4)
    m.write("Last Follower: ERROR")
  end

  sleep(SleepTime)
end

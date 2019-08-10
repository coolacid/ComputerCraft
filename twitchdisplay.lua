-- Written By CoolAcid
-- https://github.com/coolacid/ComputerCraft

-- Based on the original work by bacon_donut
-- http://pastebin.com/vhn1z23v
-- http://twitch.tv/bacon_donut

-- This is formatted to fit on a 1x3 wall of Advanced Monitors with an Advanced Computer connected to a side
-- To get this to work you need to edit the streamid variable then run these six commands:

-- label set SomeKindOfNameHere
-- pastebin get WdiT6sR5 bootstrap
-- bootstrap
-- github get coolacid/ComputerCraft/master/twitchdisplay.lua startup
-- edit startup
-- startup

-- Twitch Name of the Streamer
streamid = "coolacid"
-- Client ID is needed for API calls go HERE: https://dev.twitch.tv/console/apps/create to get ur client id
clientid = ""

-- Set the Y line for where you want the different bits to go.
line_streamer = 1
line_followers = 3
line_follower = 4
line_viewers = 5

-- Set Justification
-- 1 - Left
-- 2 - Center
-- 3 - Right
-- 4 - Split

justify_streamer = 1
justify_followers = 1
justify_follower = 1
justify_viewers = 1

-- SleepTime is how often to grab new data. Set here to one minute.
-- Set it too fast and twitch will flag you for spam
-- and stop giving you data
SleepTime = 60

-- Check to see if the JSON api exists. Otherwise, download it. 
if not fs.exists('json.lua') then
	print("JSON API not found - Downloading")
	shell.run("github get coolacid/ComputerCraft/master/json.lua json.lua")
end

if not fs.exists('functions') then
	print("internal functions not found - Downloading")
	shell.run("github get coolacid/ComputerCraft/master/functions.lua functions")
end

print ("Starting up!")
print ("To Exit press and hold CTRL-T")
print ("To Reboot press and hold CTRL-R")

JSON = (loadfile "json.lua")()
os.loadAPI("functions")

local m = peripheral.find("monitor")

m.setTextColor(colors.blue)
m.setTextScale(1)

function getFollowers()
  str = http.get("https://api.twitch.tv/kraken/channels/" .. streamid .. "/follows?limit=1&client_id=" .. clientid).readAll()
  obj = JSON:decode(str)
  follows = obj._total
  follower = obj.follows[1].user.name
  follower = follower:gsub('"', '')
  return follows, follower
end

function getViewerCount()
  str = http.get("https://api.twitch.tv/kraken/streams/" .. streamid .. "/?client_id=" .. clientid).readAll()
  obj = JSON:decode(str)
  if obj.stream == nil then
    return nil
  else
    return obj.stream.viewers
  end
end

function localwrite(text, justify, line)
    if justify == 1 then
      -- Right
      m.setCursorPos(1,line)
      m.write(text)
    elseif justify == 2 then
      functions.centerText(m, text, line)
      m.write(text)
    elseif justify == 3 then
      functions.rightJustify(m, text, line)
      m.write(text)
    elseif justify == 4 then
      functions.splitText(m, text, ":", line)
      -- Split Text HAS to write, so we don't need too
    end
end

while true do
  local status, live = pcall(getViewerCount)

  if status then 
    if live == nil then
      m.setBackgroundColor(colors.white)
      m.clear()
      localwrite(streamid, justify_streamer, line_streamer)
      localwrite("Live Viewers: Offline", justify_viewers, line_viewers)
    else
      m.setBackgroundColor(colors.yellow)
      m.clear()
      localwrite(streamid, justify_streamer, line_streamer)
      localwrite("Live Viewers: " .. live, justify_viewers, line_viewers)
    end
  else
      m.setBackgroundColor(colors.white)
      m.clear()
      localwrite(streamid, justify_streamer, line_streamer)
      localwrite("Live Viewers: ERROR", justify_viewers, line_viewers)
  end

  local status, followers, follower = pcall(getFollowers)

  if status then
    localwrite("Twitch Followers: " .. followers, justify_followers, line_followers)

    m.setCursorPos(1,line_follower)
    localwrite("Last Follower: " .. follower, justify_follower, line_follower)
  else
    m.setCursorPos(1,line_followers)  
    localwrite("Twitch Followers: ERROR", justify_followers, line_followers)

    m.setCursorPos(1,line_follower)
    localwrite("Last Follower: ERROR", justify_follower, line_follower)
  end

  sleep(SleepTime)
end

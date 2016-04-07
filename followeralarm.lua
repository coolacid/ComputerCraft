-- Written By CoolAcid
-- https://github.com/coolacid/ComputerCraft

-- label set SomeKindOfNameHere
-- pastebin get WdiT6sR5 bootstrap
-- bootstrap
-- github get coolacid/ComputerCraft/master/vieweralarm2.lua startup
-- edit startup
-- startup

-- Twitch Name of the Streamer
streamid = "coolacid"

-- SleepTime is how often to grab new data. Set here to one minute.
-- Set it too fast and twitch will flag you for spam
-- and stop giving you data
SleepTime = 60

-- Alarm time, How long you want the alarm to go off
AlarmTime = 5

-- Side to set the redstone signal on
SignalSide = "top"

-- Check to see if the JSON api exists. Otherwise, download it. 
if not fs.exists('json.lua') then
	print("JSON API not found - Downloading")
        shell.run("github get coolacid/ComputerCraft/master/json.lua json.lua")
end

print ("Starting up!")
print ("To Exit press and hold CTRL-T")
print ("To Reboot press and hold CTRL-R")

JSON = (loadfile "json.lua")()

function getFollowers()
  str = http.get("https://api.twitch.tv/kraken/channels/" .. streamid .. "/follows?limit=1").readAll()
  obj = JSON:decode(str)
  follower = obj.follows[1].user.name
  follower = follower:gsub('"', '')
  return follower
end

hot = false
lastfollower = ""

while true do
  local status, follower = pcall(getFollowers)

  if status then
    if lastfollower ~= "" and not hot then
      print("Last Follower: " .. follower)
      if follower ~= lastfollower then
        print ("We're HOT")
        hot = true
      end
    end
    if hot then
        redstone.setOutput(SignalSide, true)
        sleep(AlarmTime)
        redstone.setOutput(SignalSide, false)
    end
    lastfollower = follower
  else
    print("Error parsing viewers")
  end
  sleep(SleepTime)
end
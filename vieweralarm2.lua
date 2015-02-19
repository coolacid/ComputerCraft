-- Written By CoolAcid
-- https://github.com/coolacid/ComputerCraft

-- label set SomeKindOfNameHere
-- pastebin get WdiT6sR5 bootstrap
-- bootstrap
-- github get coolacid/ComputerCraft/master/vieweralarm1.lua startup
-- startup

-- Twitch Name of the Streamer
streamid = "Bacon_Donut"

-- SleepTime is how often to grab new data. Set here to one minute.
-- Set it too fast and twitch will flag you for spam
-- and stop giving you data
SleepTime = 60

-- Alarm time, How long you want the alarm to go off
AlarmTime = 5

-- How many viewers to set off the alarm
Viewers = 3000

-- Side to set the redstone signal on
SignalSide = "right"
ResetSide = "left"

-- Check to see if the JSON api exists. Otherwise, download it. 
if not fs.exists('json') then
	print("JSON API not found - Downloading")
	shell.run("pastebin get 4nRg9CHU json")
end

os.loadAPI("json")

function getViewerCount()
  str = http.get("https://api.twitch.tv/kraken/streams/" .. streamid).readAll()
  obj = json.decode(str)
  if obj.stream == nil then
    return nil
  else
    return json.encodePretty(obj.stream.viewers)
  end
end

hot = false

while true do
  local status, live = pcall(getViewerCount)

  if status then
    if live and not hot then
      print("Live Viewers: " .. live)
      if tonumber(live) > Viewers then
        print ("We're HOT")
        hot = true
      end
    end
    if hot then
        redstone.setOutput(SignalSide, true)
        sleep(AlarmTime)
        redstone.setOutput(SignalSide, false)
        print ("Waiting for reset")
        while true do
          sleep(0.1)
          if redstone.getInput(ResetSide) then 
            print ("Reset")
            hot = false
            break
          end
        end
    end
  else
    print("Error parsing viewers")
  end
  sleep(SleepTime)
end

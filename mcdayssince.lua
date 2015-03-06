-- Writen by @coolacid
-- https://github.com/coolacid/ComputerCraft
-- Displays the minecraft days since an event happens
-- Event is from when the computer is placed, and reset using a redstone signal

-- label set SomeKindOfNameHere
-- pastebin get WdiT6sR5 bootstrap
-- bootstrap
-- github get coolacid/ComputerCraft/master/mcdayssince.lua startup
-- startup

-- Define where to check for the redstone signal
ResetSide = "left"

-- What happened - for the text
What = "Days since last button press"

-- Use real time
RealTime = false

----- No need to change anything bellow this point


if not fs.exists('functions') then
        print("internal functions not found - Downloading")
        shell.run("github get coolacid/ComputerCraft/master/functions.lua functions")
end

-- Find the monitor

os.loadAPI("functions")

local m = peripheral.find("monitor")

function getTime(external) 
    local time
    if not external then
      time = os.day()
    else
      str = http.get("http://time.gov/widget/dhtml/actualtime.cgi?disablecache=".. os.day()).readAll()
      local ltime = str:gmatch('"(%w+)"')
      time = math.floor (ltime() / (1000*1000*60*60*24))
    end
    return time
end

function readfile(reset)
  -- Read file to find the time
  local time
  if fs.exists(".time") and not reset then
    local h = fs.open(".time", "r")
    time = h.readLine()
    h.close()
  else
    -- Time state not saved yet, set it to in game time and save it
    time = getTime(RealTime)
    local h = fs.open(".time", "w")
    h.write(time)
    h.close()
  end
  return time
end

starttime = readfile(false)

while true do
  cTime = getTime(RealTime)
  diff = cTime - starttime
  print ("CTime: " .. cTime)
  print ("StartTime: " .. starttime)
  print ("Diff: " .. diff)
  text = What .. ": " .. diff
  functions.centerText(m, text)
  m.write(text)
  i = 0
  if RealTime then
    waitdelay = 30
  else 
    waitdelay = 5
  end
  while i < waitdelay * 2 do
    if redstone.getInput(ResetSide) then
      starttime = readfile(true)
      sleep (1)
      m.clear()
      break
    end
    sleep (.5)
    i = i + 1
  end
end

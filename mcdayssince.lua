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


----- No need to change anything bellow this point


if not fs.exists('functions') then
        print("internal functions not found - Downloading")
        shell.run("github get coolacid/ComputerCraft/master/functions.lua functions")
end

-- Find the monitor

os.loadAPI("functions")

local m = peripheral.find("monitor")

function readfile(reset)
  -- Read file to find the time
  if fs.exists(".time") and not reset then
    local h = fs.open(".time", "r")
    time = h.readLine()
  else
    -- Time state not saved yet, set it to in game time and save it
    time = os.day()
    local h = fs.open(".time", "w")
    h.write(time)
    h.close()
  end
  return time
end

time = readfile(false)

while true do
  diff = os.day() - time
  print(diff)
  text = What .. ": " .. diff
  functions.centerText(m, text)
  m.write(text)
  i = 0
  while i < 5*2 do
    if redstone.getInput(ResetSide) then
      readfile(true)
      sleep (1)
      break
    end
    sleep (.5)
    i = i + 1
  end
end


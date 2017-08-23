-- Writen by @Errv00
-- https://github.com/coolacid/ComputerCraft
-- Emits redstone signal on the specified side only if the correct password is used
-- The password can be set when the progtam first starts

-- label set SomeKindOfNameHere
-- pastebin get WdiT6sR5 bootstrap
-- bootstrap
-- github get coolacid/ComputerCraft/master/doorLocker.lua startup
-- startup


--Functions
function clear()
 term.clear()
 term.setCursorPos(1,1)
end

function createConf(sd,pass,Apass)
 local confFile = fs.open("doorLocker.conf","w")
 confFile.writeLine(sd)
 confFile.writeLine(pass)
 confFile.writeLine(Apass)
 confFile.flush()
 confFile.close()
end

function setPass(sd)
 print("Please set password for door opening")
 pss = read("*")
 print("Please set admin password")
 print("This password will NOT open the door,but put you into the OS")
 print("This password MUST be different")
 aPass = read("*")
 createConf(sd,pss,aPass)
 print("Your computer will now reboot")
 sleep(2)
 os.reboot()
end

function getCorrectCombination()
 local confFile = fs.open("doorLocker.conf","r")
 local s = confFile.readLine()
 local p = confFile.readLine()
 local aP = confFile.readLine()
 confFile.close()
 return p, s, aP
end

function open(s)
 print("Correct password")
 if(s == "L") then
  rs.setOutput("left",true)
 elseif(s == "R") then
  rs.setOutput("right",true)
 elseif(s == "U") then
  rs.setOutput("top",true)
 elseif(s == "D") then
  rs.setOutput("bottom",true)
 elseif(s == "B") then
  rs.setOutput("back",true)
 elseif(s == "F") then
  rs.setOutput("front",true)
 else
  printError("The configuration file was modified")
 end
 sleep(3)
 os.reboot()
end

--Some Local Variables
local version = "1.0"
local oldPullEvent = os.pullEvent

--Prevents termination
os.pullEvent = os.pullEventRaw

--Progam start
if(fs.exists("doorLocker.conf")) then
 --Require Password
 clear()
 print("DoorLocker V"..version)
 print("Please input password")
 correctPass, doorSide, adminPass = getCorrectCombination()
 uPass = read("*")
 if(uPass == correctPass) then
  open(doorSide)
 elseif(uPass == adminPass) then
  print("Admin password entered correctly")
  os.pullEvent = oldPullEvent
 else
  print("Incorrect password. System is rebooting")
  sleep(1)
  os.reboot()
 end
else
 --Set Password & Side
 clear()
 print("DoorLocker V"..version)
 while true do
  clear()
  print("Please specify the side of the door! (L/R/U/D/B/F)")
  choice = read()
  if(choice == "L") then
   setPass(choice)
   break
  elseif(choice == "R") then
   setPass(choice)
   break
  elseif(choice == "U") then
   setPass(choice)
   break
  elseif(choice == "D") then
   setPass(choice)
   break
  elseif(choice == "B") then
   setPass(choice)
   break
  elseif(choice == "F") then
   setPass(choice)
   break
  else
   print("The side you entered is incorrect")
   sleep(2)
  end
 end
end

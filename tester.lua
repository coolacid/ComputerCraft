-- Simple script to display the type and methods a device has.
-- Place script advanced computer
-- Place computer so that device is on the computers back side
-- Run script.
-- Profit

-- label set Tester
-- pastebin get WdiT6sR5 bootstrap
-- bootstrap
-- github get coolacid/ComputerCraft/master/tester.lua startup


me = peripheral.getMethods("back")
if me then
  print(peripheral.getType("back"))
  for k,v in pairs (me) do
    print (k .. " | " .. v)
  end
else 
  print("No methods")
end

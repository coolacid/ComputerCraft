-- Simple script to display the type and methods a device has.
-- Place script advanced computer
-- Place computer so that device is on the computers back side
-- Run script.
-- Profit

-- You will also find additional details in a file found in:
-- [Minecraft Directory]/saves/[World Name]/computer/[Int]/[devicetype]

-- label set Tester
-- pastebin get WdiT6sR5 bootstrap
-- bootstrap
-- github get coolacid/ComputerCraft/master/tester.lua tester

function dump(t, level)
  level = level or 0
  for i,v in pairs(t) do
--    io.write(string.rep('  ', level))
--    io.write(i..': ')
    file.write(string.rep('  ', level))
    file.write(i..': ')
    if type(v) == 'table' then
--      print ''
      file.writeLine("")
      dump(v, level + 1)
    else
--      print(tostring(v))
      file.writeLine (tostring(v))
    end
  end
end

device = peripheral.getType("back")

if device then
  me = peripheral.getMethods("back")
  file = fs.open(device, "w")
  print(device)
  file.writeLine(device)
  for k,v in pairs (me) do
    print (k .. " | " .. v)
    file.writeLine (k .. " | " .. v)
  end
  item = peripheral.wrap("back")
  amd = item.getAdvancedMethodsData()
  dump(amd)
  file.flush()
  file.close()
  print ("Addtional data saved to file")
else 
  print("No methods")
end

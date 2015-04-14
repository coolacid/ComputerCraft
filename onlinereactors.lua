-- By @CoolAcid
-- Find all BigReactors and ensure they are turned on.
-- Either attach directly to a reactor, and/or use a modem/network set to connect
-- You can connect as many reactors are you want, it will ensure all of them are online

-- To get started
-- label set SomeKindOfNameHere
-- pastebin get WdiT6sR5 bootstrap
-- bootstrap
-- github get coolacid/ComputerCraft/master/onlinereactors.lua startup
-- startup

local reactors = {}

for _, name in pairs (peripheral.getNames()) do
   if peripheral.getType(name) == "BigReactors-Reactor" then
     print ("Found Reactor at: " .. name)
     table.insert (reactors, peripheral.wrap(name))
  end
end

while true do
  for _, reactor in pairs(reactors) do
    if reactor.getActive() == false then
        reactor.setActive(true)
    end
  end
  sleep (5)
end


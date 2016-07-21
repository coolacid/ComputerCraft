-- Written By CoolAcid
-- https://github.com/coolacid/ComputerCraft

-- label set SomeKindOfNameHere
-- pastebin get WdiT6sR5 bootstrap
-- bootstrap
-- github get coolacid/ComputerCraft/master/lightflicker.lua startup
-- startup

-- How often to produce a flicker
SleepTime = 10

-- How Long to flicker off for
FlickerOffMinTime = .1
FlickerOffMaxTime = .3

FlickerOnMinTime = .25
FlickerOnMaxTime = 1

-- Min and Max number of Flickers
FlickerMin = 2
FlickerMax = 10

-- Side to set the redstone signal on
SignalSide = "top"

redstone.setOutput(SignalSide, true)

while true do
        FlickerCount = math.random(FlickerMin, FlickerMax)
        print ("Flickering this many times: " .. FlickerCount)
        for i=0,FlickerCount,1
        do
            FlickerOffTime = (math.random(FlickerOffMinTime * 1000, FlickerOffMaxTime * 1000) / 1000)
            FlickerOnTime = (math.random(FlickerOnMinTime * 1000, FlickerOnMaxTime * 1000) / 1000)
            print ("Flicker off: " .. FlickerOffTime)
            redstone.setOutput(SignalSide, false)
            sleep(FlickerOffTime)
            print ("Flicker on: " .. FlickerOnTime)
            redstone.setOutput(SignalSide, true)
            sleep(FlickerOnTime)
        end
        redstone.setOutput(SignalSide, true)
        print ("Waiting for next flicker time")
        sleep(SleepTime)
end

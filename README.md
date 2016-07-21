# ComputerCraft
Scripts Related to Minecraft ComputerCraft

Bootstrap
---------

Bootstrap and download a bunch of libraries. Makes getting started faster
- Original: https://github.com/seriallos/computercraft/blob/master/bootstrap.lua
- Start with: pastebin get WdiT6sR5 bootstrap

functions.lua
-------------

Just a bunch of functions that I use in different scripts. Write once, use many is good coding.

MultiSensors
------------

![Multisensors](https://raw.githubusercontent.com/coolacid/ComputerCraft/master/ScreenShots/Multisensors.png)

Detect players in your area by placing multiple sensors connected to an advanced computer via modems and network cables
- Place as many sensors as you see fit.
- Display using a Glasses Controller / Terminal Glasses HUD or Advanced Monitor

LightFlicker.lua
----------------

Emits a redstone signal to the designated side producing a flickering effect. Options include:
- How long between sets of flickers
- Min/Max for the off flicker
- Min/Max for the on flicker
- Min/Man for the number of flickers


FollowerAlarm.lua
----------------

This tracks the last follower from the stream, if the last follower changes emits a redstone signal for X seconds. This isn't exactly smart (yet):
- This will trigger if there is a NEW follower
- This will trigger if a follower no longer follows
- This will trigger if a follower re-follows

ViewerAlarm?.lua
----------------

![ViewerAlarm](https://raw.githubusercontent.com/coolacid/ComputerCraft/master/ScreenShots/TwitchAlarm.png)

ViewerAlarm scripts are two different twitch viewer alarms. It watches the twitch API for the current viewer count and emits a redstone signal when over the configured threshhold.
- Alarm1 will emit a constant signal once count is reached until you send a reset redstone signal
- Alarm2 will emit for X seconds then stop waiting for a reset redstone signal

Twitchdisplay
-------------

![TwitchDisplay](https://raw.githubusercontent.com/coolacid/ComputerCraft/master/ScreenShots/TwitchDisplay.png)

Display twitch statistics in game
- Originally by Bacon_Donut and rewriten

MCTimeSince
-----------

![MCDaysSince](https://raw.githubusercontent.com/coolacid/ComputerCraft/master/ScreenShots/MCDaysSince.png)

Shows the number of days since an event on a monitor. Reset the timer by providing a redstone signal to the defined side. 


tester.lua
----------

There are LOTS of different blocks you can use with CC. This will output methods of whatever is on the back of the computer


# Other noteworthy Repos to Follow

- https://github.com/seriallos/computercraft

# Tip Jar

https://gist.github.com/coolacid/9537573
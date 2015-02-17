-- Written By Bacon_Donut
-- http://twitch.tv/bacon_donut
-- API call updated by @darkgoldblade on twitter

-- View all my public pastebin codes at:
-- http://pastebin.com/u/bacon_donut

-- This is formatted to fit on a 1x3 wall of Advanced Monitors
-- with an Advanced Computer on the left side.
-- To get this to work you need to edit the streamid variable then run these four commands:

-- label set SomeKindOfNameHere
-- pastebin get WdiT6sR5 bootstrap
-- github get coolacid/ComputerCraft/master/twitchdisplay.lua startup
-- startup

-- ChangeLog:
-- Feb 16, 2015 - @CoolAcid
-- Added automatic download of JSON parser
-- Fixed the offline streamer detection
-- Added last follower option

-- Twitch Name of the Streamer
streamid = "Bacon_Donut"


-- SleepTime is how often to grab new data. Set here to one minute.
-- Set it too fast and twitch will flag you for spam
-- and stop giving you data
SleepTime = 60

-- Check to see if the JSON api exists. Otherwise, download it. 
if not fs.exists('json') then
	write("JSON API not found - Downloading")
	shell.run("pastebin get 4nRg9CHU json")
end

os.loadAPI("json")
local m = peripheral.wrap("right")
m.setCursorPos(1,1)

function getFollowers()
	
	str = http.get("https://api.twitch.tv/kraken/channels/" .. streamid .. "/follows?limit=1").readAll()
	obj = json.decode(str)
	follows = json.encodePretty(obj._total)
	
	m.setCursorPos(1,3)	
	m.write("Twitch Followers: ")
	m.write(follows)

	return follows
end

function getFollower()
       
        str = http.get("https://api.twitch.tv/kraken/channels/" .. streamid .. "/follows?limit=1").readAll()
        obj = json.decode(str)
        follower = json.encodePretty(obj.follows[1].user.name)
       
        m.setCursorPos(1,5)    
        m.write("Follower: ")
        m.write(follower)
 
        return follows
end

function getViewerCount()
	lstr = http.get("https://api.twitch.tv/kraken/streams/" .. streamid).readAll()
        lobj = json.decode(lstr)
        m.setCursorPos(1,1)
	

	if lobj.stream == nil then
		m.write(streamid)
		m.setCursorPos(1,4)
		m.write("Live Viewers: Offline")
	else
        	live = json.encodePretty(lobj.stream.viewers)
		m.setBackgroundColor(colors.yellow)
		m.clear()
		m.write(streamid)
		m.setCursorPos(1,4)
		m.write("Live Viewers: ")
		m.write(live)		
	end

	return live
end

while true do
	m.setCursorPos(1,1)
	m.setBackgroundColor(colors.white)
	m.setTextColor(colors.blue)
	m.setTextScale(1)
	m.clear()

	m.write(streamid)
	m.setCursorPos(1,4)

	local status, live = pcall(function () getViewerCount() end)
	
	if status then
		-- do nothing
	else
		m.write("Live Viewers: Loading...")
	end

	local status, followsCount = pcall(function () getFollowers() end)
	
	m.setCursorPos(1,3)	

	if status then		
		-- do nothing
	else		
		m.write("Twitch Follows: Loading...")
	end

	m.setCursorPos(1,5)	

	local status, live = pcall(function () getFollower() end)
	
	if status then
		-- do nothing
	else
		m.write("Follower: Loading...")
	end
	
	

	sleep(SleepTime)
end
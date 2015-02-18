# Twitch Sub Tracker

The problem with pulling twitch subs is that you require the use of an OAUTH Key. 
This is fine if you're a single person on a server, and not giving that world to another person.

The reason is, since you need an OAUTH key to get the Subs list, without some sort of proxy the OAUTH key would be in the computercraft code.

This project is set to fix that. This is a two part project:
- The computercraft code for displaying the info
- Some node.js code to act as a proxy

# NOTE
Since I don't have a subscriber button, and twitch doesn't have a test account for devs, I can't fully code the proxy. :(

nodejs/index.js
----------

Node.js proxy to handle the OAUTH requests. 

You need to set who you want to accept and their OAUTH keys. 
Secondly, define what IPs are allowed to access the proxy.

This is intended to be run either standalone on a server, or one can run it on heroku.com

subdisplay.lua
--------------

Displays the last sub

submulti.lua
------------

Displays the last X subs to a monitor.
Limited by the size of the monitor, and limits set by proxy API call (default 25)

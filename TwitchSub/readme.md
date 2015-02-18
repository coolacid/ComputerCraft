# Twitch Sub Tracker

The problem with pulling twitch subs is that you require the use of an OAUTH Key. 
This is fine if you're a single person on a server, and not giving that world to another person.

The reason is, since you need an OAUTH key to get the Subs list, without some sort of proxy the OAUTH key would be in the computercraft code.

This project is set to fix that. This is a two part project:
- The computercraft code for displaying the info
- Some node.js code to act as a proxy

tsproxy.js
----------

Node.js proxy to handle the OAUTH requests. 

You need to set who you want to accept and their OAUTH keys. Secondly, define what IPs are allowned to access the proxy.


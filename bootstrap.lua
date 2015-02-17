--[[

turtle bootstrap

simple program to get a bunch of other programs in one run
of 'pastebin get'

Usage:

  > pastebin get 55tqszpw bootstrap
  > bootstrap

--]]

http_runs = {
  ["pastebin"] = {
    -- github loader
    ["caMmH484"] = "github",
  },
  -- make sure to use the right URL for raw.github.com
  ["github"] = {

    -- gist loader
    ["seriallos/computercraft/master/gist.lua"] = "gist",
  },
}

for service, list in pairs( http_runs ) do
  for id, program in pairs( list ) do
    print( "Downloading "..program.." from "..service )
    shell.run( service, "get", id, program )
  end
end

-- run the bootstrapper from github
-- second level of bootstrap is so the files on pastebin can be pretty static.
-- github is way easier to manage from the command line.  i don't want to
-- constantly be futzing with the pastebin site or API.
-- git add .; git commit -m "blah"; git push  # so much better!

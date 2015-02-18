-- Written By CoolAcid
-- https://github.com/coolacid/ComputerCraft

-- Some functions I use that could be used by any number of scripts

function centerText(m, text, dy)
  local x,y=m.getSize()
  center = math.ceil((x/2) - (text:len() / 2))
  if dy == nil then
    m.setCursorPos(center, math.ceil(y/2))
  else dy > 0 then
    local x,y = m.getSize()
    m.setCursorPos(center, dy)
  end
  return center
end

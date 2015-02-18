-- Written By CoolAcid
-- https://github.com/coolacid/ComputerCraft

-- Some functions I use that could be used by any number of scripts

function centerText(m, text, dy)
  if dy == nil then
    local x,y=m.getSize()
    m.setCursorPos(math.ceil((x/2) - (text:len() / 2)), math.ceil(y/2))
  else
    local x,y = m.getSize()
    m.setCursorPos(math.ceil((x/2) - (text:len() / 2)), dy)
  end
end

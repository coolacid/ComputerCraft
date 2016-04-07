-- Written By CoolAcid
-- https://github.com/coolacid/ComputerCraft

-- Some functions I use that could be used by any number of scripts

function centerText(m, text, dy)
  local x,y=m.getSize()
  center = math.ceil((x/2) - (text:len() / 2))
  if dy == nil then
    m.setCursorPos(center, math.ceil(y/2))
  elseif dy > 0 then
    m.setCursorPos(center, dy)
  end
  return center
end

function rightJustify(m, text, dy)
  local x,y=m.getSize()
  right = x-text:len()
  if dy == nil then
    m.setCursorPos(right, math.ceil(y/2))
  elseif dy > 0 then
    m.setCursorPos(right, dy)
  end
  return center
end

function splitText(m, text, delimiter, dy) -- We assume we're writing here
    splitpoint = string.find(text, delimiter)
    firstword = string.sub(text, 0, splitpoint -1 )
    secondword = string.sub(text, splitpoint +1 ):gsub(" ", "")
    rightJustify(m, secondword, dy)
    m.write(secondword)
    m.setCursorPos(1, dy)
    m.write(firstword)
end

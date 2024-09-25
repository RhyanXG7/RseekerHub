-- Name
local Part = "FakeDoor"

-- Script
local femboy = game:GetDescendants()
for i = 1, #femboy do local v = femboy[i]
if v.Name == Part then
v:Destroy()
end
end


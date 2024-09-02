local KeyChams = {}
local SelectedObject = nil

local function ApplyKeyChams(inst)
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.fromRGB(255, 255, 255) -- Cor branca
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.fromRGB(255, 255, 255) -- Cor branca
    Cham.Parent = game:GetService("CoreGui")
    Cham.Adornee = inst
    Cham.Enabled = true
    Cham.RobloxLocked = true
    return Cham
end

local function CleanupChams()
    for _, cham in ipairs(KeyChams) do
        cham:Destroy()
    end
    KeyChams = {}
end

local function OnObjectSelected(inst)
    if SelectedObject then
        for i, cham in ipairs(KeyChams) do
            if cham.Adornee == SelectedObject then
                cham:Destroy()
                table.remove(KeyChams, i)
            end
        end
    end
    SelectedObject = inst
    table.insert(KeyChams, ApplyKeyChams(inst))
end

Workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
    if inst.Name == "GiggleCeiling" then
        OnObjectSelected(inst)
    end
end)

for i, v in ipairs(Workspace:GetDescendants()) do
    if v.Name == "GiggleCeiling" then
        OnObjectSelected(v)
    end
end

-- Exemplo: Chame CleanupChams() quando precisar remover todos os destaques
-- CleanupChams()

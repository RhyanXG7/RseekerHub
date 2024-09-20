local ESPEnabled = _G.KeyObtainESPEnabled or false
_G.KeyObtainESPEnabled = ESPEnabled
local KeyObtainChams = {}
local folder = Instance.new("Folder")
folder.Name = "[ KeyObtain : RSeekerHub ]"
folder.Parent = game:GetService("CoreGui")

local function ApplyKeyObtainChams(inst)
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(0, 0, 1)
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.new(1, 1, 1)
    Cham.OutlineTransparency = 0
    Cham.Adornee = inst
    Cham.Enabled = true
    Cham.Parent = folder
    return Cham
end

local function OnObjectDeselected()
    for i = #KeyObtainChams, 1, -1 do
        local cham = KeyObtainChams[i]
        cham:Destroy()
        table.remove(KeyObtainChams, i)
    end
end

local function OnObjectSelected(inst)
    if ESPEnabled then
        OnObjectDeselected()
        local cham = ApplyKeyObtainChams(inst)
        table.insert(KeyObtainChams, cham)
    end
end

local function CheckForNewObjects()
    Workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
        if inst.Name == "KeyObtain" and ESPEnabled then
            OnObjectSelected(inst)
        end
    end)

    Workspace.CurrentRooms.DescendantRemoving:Connect(function(inst)
        if inst.Name == "KeyObtain" then
            for i, cham in ipairs(KeyObtainChams) do
                if cham.Adornee == inst then
                    cham:Destroy()
                    table.remove(KeyObtainChams, i)
                    break
                end
            end
        end
    end)
end

if ESPEnabled then
    folder.Parent = game:GetService("CoreGui")
    CheckForNewObjects()

    for _, v in ipairs(Workspace:GetDescendants()) do
        if v.Name == "KeyObtain" then
            OnObjectSelected(v)
        end
    end
end

while wait(1) do
    if ESPEnabled then
        for _, v in ipairs(Workspace:GetDescendants()) do
            local found = false
            for _, cham in ipairs(KeyObtainChams) do
                if cham.Adornee == v then
                    found = true
                    break
                end
            end
            if not found and v.Name == "KeyObtain" then
                OnObjectSelected(v)
            end
        end
    end
end

_G.KeyObtainESPEnabled = function()
    ESPEnabled = not ESPEnabled
    if not ESPEnabled then
        for _, cham in ipairs(KeyObtainChams) do
            cham:Destroy()
        end
        KeyObtainChams = {}
    else
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v.Name == "KeyObtain" then
                OnObjectSelected(v)
            end
        end
    end
end

-- Notificação 

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://3458224686"
sound.Volume = 1
sound.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
sound:Play()
sound.Ended:Connect(function()
    sound:Destroy()
end)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "🔔 Notificação",
    Text = "🔑 Chaves agora Visíveis.",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

local FuseHolderChams = {}
local ESPEnabled = _G.FuseHolderESPEnabled or false
local folder = Instance.new("Folder")
folder.Name = "[ FuseHolder : RSeekerHub ]"
folder.Parent = game:GetService("CoreGui")

local function ApplyFuseHolderChams(inst)
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(0, 1, 0)
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.new(1, 1, 1)
    Cham.OutlineTransparency = 0
    Cham.Adornee = inst
    Cham.Enabled = true
    Cham.Parent = folder
    return Cham
end

local function OnObjectDeselected()
    for i = #FuseHolderChams, 1, -1 do
        local cham = FuseHolderChams[i]
        cham:Destroy()
        table.remove(FuseHolderChams, i)
    end
end

local function OnObjectSelected(inst)
    if ESPEnabled then
        OnObjectDeselected()
        local cham = ApplyFuseHolderChams(inst)
        table.insert(FuseHolderChams, cham)
    end
end

local function CheckForNewObjects()
    Workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
        if inst.Name == "FuseHolder" and ESPEnabled then
            OnObjectSelected(inst)
        end
    end)

    Workspace.CurrentRooms.DescendantRemoving:Connect(function(inst)
        if inst.Name == "FuseHolder" then
            for i, cham in ipairs(FuseHolderChams) do
                if cham.Adornee == inst then
                    cham:Destroy()
                    table.remove(FuseHolderChams, i)
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
        if v.Name == "FuseHolder" then
            OnObjectSelected(v)
        end
    end
end

while wait(1) do
    if ESPEnabled then
        for _, v in ipairs(Workspace:GetDescendants()) do
            local found = false
            for _, cham in ipairs(FuseHolderChams) do
                if cham.Adornee == v then
                    found = true
                    break
                end
            end
            if not found and v.Name == "FuseHolder" then
                OnObjectSelected(v)
            end
        end
    end
end

_G.FuseHolderESPEnabled = function()
    ESPEnabled = not ESPEnabled
    if not ESPEnabled then
        for _, cham in ipairs(FuseHolderChams) do
            cham:Destroy()
        end
        FuseHolderChams = {}
    else
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v.Name == "FuseHolder" then
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
    Text = "🏮 esp do fusível agora ativo/desativado.",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

for _, v in ipairs(workspace:GetDescendants()) do
    if v.Name == "FuseHolder" then
        OnObjectSelected(v)
    end
end

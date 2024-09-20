local ChestBoxChams = {}
local ESPEnabled = true
local folder = Instance.new("Folder")
folder.Name = "ESPFolder"

local function ApplyChestBoxChams(inst)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = inst
    highlight.FillColor = Color3.new(0, 0, 1)
    highlight.Parent = folder
    return { highlight = highlight }
end

local function OnObjectDeselected()
    for i = #ChestBoxChams, 1, -1 do
        local cham = ChestBoxChams[i]
        cham.highlight:Destroy()
        table.remove(ChestBoxChams, i)
    end
end

local function OnObjectSelected(inst)
    if ESPEnabled then
        OnObjectDeselected()
        local cham = ApplyChestBoxChams(inst)
        table.insert(ChestBoxChams, cham)
    end
end

local function CheckForNewObjects()
    Workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
        if inst.Name == "ChestBox" and ESPEnabled then
            OnObjectSelected(inst)
        end
    end)

    Workspace.CurrentRooms.DescendantRemoving:Connect(function(inst)
        if inst.Name == "ChestBox" then
            for i, cham in ipairs(ChestBoxChams) do
                if cham.highlight.Adornee == inst then
                    cham.highlight:Destroy()
                    table.remove(ChestBoxChams, i)
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
        if v.Name == "ChestBox" then
            OnObjectSelected(v)
        end
    end
end

while wait(1) do
    if ESPEnabled then
        for _, v in ipairs(Workspace:GetDescendants()) do
            local found = false
            for _, cham in ipairs(ChestBoxChams) do
                if cham.highlight.Adornee == v then
                    found = true
                    break
                end
            end
            if not found and v.Name == "ChestBox" then
                OnObjectSelected(v)
            end
        end
    end
end

_G.ChestBoxESPEnabled = function()
    ESPEnabled = not ESPEnabled
    if not ESPEnabled then
        for _, cham in ipairs(ChestBoxChams) do
            cham.highlight:Destroy()
        end
        ChestBoxChams = {}
    else
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v.Name == "ChestBox" then
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
    Text = "📦 Esp do Bau agora ativo/desativado.",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

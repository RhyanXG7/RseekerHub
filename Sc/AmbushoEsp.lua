local AmbushChams = {}
local ESPEnabled = true
local folder = Instance.new("Folder")
folder.Name = "ESPFolder"

local function ApplyAmbushChams(inst)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = inst
    highlight.FillColor = Color3.new(1, 0, 0)
    highlight.Parent = folder
    return { highlight = highlight }
end

local function RemoveAmbushChams(inst)
    for i, cham in ipairs(AmbushChams) do
        if cham.highlight.Adornee == inst then
            cham.highlight:Destroy()
            table.remove(AmbushChams, i)
            break
        end
    end
end

local function OnObjectSelected(inst)
    if ESPEnabled then
        RemoveAmbushChams(inst)
        local cham = ApplyAmbushChams(inst)
        table.insert(AmbushChams, cham)
    end
end

local function CheckForNewObjects()
    workspace.DescendantAdded:Connect(function(inst)
        if inst.Name == "AmbushMoving" and ESPEnabled then
            OnObjectSelected(inst)
        end
    end)

    workspace.DescendantRemoving:Connect(function(inst)
        if inst.Name == "AmbushMoving" then
            RemoveAmbushChams(inst)
        end
    end)
end

if ESPEnabled then
    folder.Parent = game:GetService("CoreGui")
    CheckForNewObjects()

    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Name == "AmbushMoving" then
            OnObjectSelected(v)
        end
    end
end

while wait(1) do
    if ESPEnabled then
        for _, v in ipairs(workspace:GetDescendants()) do
            local found = false
            for _, cham in ipairs(AmbushChams) do
                if cham.highlight.Adornee == v then
                    found = true
                    break
                end
            end
            if not found and v.Name == "AmbushMoving" then
                OnObjectSelected(v)
            end
        end
    end
end

_G.AmbushESPEnabled = function()
    ESPEnabled = not ESPEnabled
    if not ESPEnabled then
        for _, cham in ipairs(AmbushChams) do
            cham.highlight:Destroy()
        end
        AmbushChams = {}
    else
        for _, v in ipairs(workspace:GetDescendants()) do
            if v.Name == "AmbushMoving" then
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
    Text = "🟢 Esp do Ambush Agora ativo/desativado.",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

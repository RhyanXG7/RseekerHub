
local ESPEnabled = _G.KeyObtainESPEnabled or false
_G.KeyObtainESPEnabled = ESPEnabled
local KeyObtainChams = {}
local folder = Instance.new("Folder")
folder.Name = "[ KeyObtain : RSeekerHub ]"
folder.Parent = game:GetService("CoreGui")

local function ApplyKeyObtainChams(inst)
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(0, 0, 1)  -- Cor azul correspondente à legenda "[Chave]"
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.new(1, 1, 1)
    Cham.OutlineTransparency = 0
    Cham.Adornee = inst
    Cham.Enabled = true
    Cham.Parent = folder

    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Adornee = inst
    BillboardGui.Size = UDim2.new(0, 100, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Parent = inst

    local Label = Instance.new("TextLabel")
    Label.Text = "[Chave]"
    Label.TextColor3 = Color3.new(0, 0, 1)  -- Texto azul
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.TextSize = 14
    Label.Font = Enum.Font.GothamBold
    Label.Parent = BillboardGui

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
            if v.Name == "KeyObtain" and not table.find(KeyObtainChams, function(cham) return cham.Adornee == v end) then
                OnObjectSelected(v)
            end
        end
    end
end

_G.KeyObtainESPEnabled = not ESPEnabled

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

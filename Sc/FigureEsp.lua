local ESPEnabled = _G.FigureRigESPEnabled or false
_G.FigureRigESPEnabled = ESPEnabled
local FigureRigChams = {}
local folder = Instance.new("Folder")
folder.Name = "[ FigureRig : RSeekerHub ]"
folder.Parent = game:GetService("CoreGui")

local function ApplyFigureRigChams(inst)
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(1, 0, 0)
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
    Label.Text = "[Figure]"
    Label.TextColor3 = Color3.new(1, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.TextSize = 14
    Label.Font = Enum.Font.GothamBold
    Label.Parent = BillboardGui

    return Cham
end

local function OnObjectDeselected()
    for i = #FigureRigChams, 1, -1 do
        local cham = FigureRigChams[i]
        cham:Destroy()
        table.remove(FigureRigChams, i)
    end
end

local function OnObjectSelected(inst)
    if ESPEnabled then
        OnObjectDeselected()
        local cham = ApplyFigureRigChams(inst)
        table.insert(FigureRigChams, cham)
    end
end

local function CheckForNewObjects()
    Workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
        if inst.Name == "FigureRig" and not ESPEnabled then
            OnObjectSelected(inst)
        end
    end)
end

if ESPEnabled then
    folder.Parent = game:GetService("CoreGui")
    CheckForNewObjects()

    for _, v in ipairs(Workspace:GetDescendants()) do
        if v.Name == "FigureRig" then
            OnObjectSelected(v)
        end
    end
end

while wait(1) do
    if ESPEnabled then
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v.Name == "FigureRig" and not table.find(FigureRigChams, v) then
                OnObjectSelected(v)
            end
        end
    end
end

_G.FigureRigESPEnabled = not ESPEnabled

-- Not

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
    Text = "🦒 Esp do figure agora ativo/desativado.",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

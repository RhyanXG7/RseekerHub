-- Configurações
local Settings = {
    Highlight = {
        FillColor = Color3.new(1, 0, 0),  
        FillTransparency = 0.5,
        OutlineColor = Color3.new(1, 0, 0),
    },
    Label = {
        Text = "[Rush]",
        TextColor = Color3.new(1, 0, 0),
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextStrokeTransparency = 0,
        TextStrokeColor3 = Color3.new(0, 0, 0),
    },
    MonitorInterval = 1,
    DistanceThreshold = 1000,
}


local RushChams = {}
local SelectedObject = nil
local Connections = {}
local player = game.Players.LocalPlayer

local function ApplyRushChams(inst)
    if not inst:IsDescendantOf(game.Workspace) then return nil end
    
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Settings.Highlight.FillColor
    Cham.FillTransparency = Settings.Highlight.FillTransparency
    Cham.OutlineColor = Settings.Highlight.OutlineColor
    Cham.Adornee = inst
    Cham.Enabled = true
    Cham.Name = "Rush ESP : SeekerHub"
    Cham.Parent = inst

    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Adornee = inst
    BillboardGui.Size = UDim2.new(0, 100, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Name = "Rush LGD : SeekerHub"
    BillboardGui.Parent = inst

    local Label = Instance.new("TextLabel")
    Label.Text = Settings.Label.Text
    Label.TextColor3 = Settings.Label.TextColor
    Label.TextSize = Settings.Label.TextSize
    Label.Font = Settings.Label.Font
    Label.TextStrokeTransparency = Settings.Label.TextStrokeTransparency
    Label.TextStrokeColor3 = Settings.Label.TextStrokeColor3
    Label.TextScaled = false
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.Parent = BillboardGui

    return Cham
end

local function OnObjectDeselected()
    if SelectedObject then
        for i = #RushChams, 1, -1 do
            local cham = RushChams[i]
            if cham.Adornee == SelectedObject then
                cham:Destroy()
                table.remove(RushChams, i)
            end
        end
        SelectedObject = nil
    end
end

local function OnObjectSelected(inst)
    OnObjectDeselected()
    SelectedObject = inst
    local cham = ApplyRushChams(inst)
    if cham then
        table.insert(RushChams, cham)
    end
end

local function MonitorWorkspace()
    while true do
        for _, v in ipairs(game.Workspace:GetDescendants()) do  -- Corrigido aqui para 'game.Workspace'
            if v.Name == "RushMoving" and not v:FindFirstChildOfClass("Highlight") then
                OnObjectSelected(v)
            end
        end
        wait(Settings.MonitorInterval)
    end
end

local function HandleNewInstance(inst)
    if inst.Name == "RushMoving" then
        OnObjectSelected(inst)
        
        repeat
            task.wait()
        until (player:DistanceFromCharacter(inst:GetPivot().Position) < Settings.DistanceThreshold) or not inst:IsDescendantOf(game.Workspace)
        
        if inst:IsDescendantOf(game.Workspace) then
        end
    end
end

table.insert(Connections, game.Workspace.CurrentRooms.DescendantAdded:Connect(HandleNewInstance))
table.insert(Connections, game.Workspace.ChildAdded:Connect(HandleNewInstance))

spawn(MonitorWorkspace)

for _, v in ipairs(game.Workspace:GetDescendants()) do
    if v.Name == "RushMoving" then
        OnObjectSelected(v)
    end
end

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
    Text = "👹 Esp Rush ativo!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

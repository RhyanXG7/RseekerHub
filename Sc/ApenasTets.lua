-- Configurações
local Settings = {
    Highlight = {
        FillColor = Color3.new(1, 0, 0),  -- Vermelho
        FillTransparency = 0.5,
        OutlineColor = Color3.new(1, 0, 0),  -- Vermelho
    },
    Label = {
        Text = "[RushMoving]",
        TextColor = Color3.new(1, 0, 0),  -- Vermelho
        TextSize = 14,
        Font = Enum.Font.GothamBold,  -- Fonte estilosa
        TextStrokeTransparency = 0,  -- Contorno
        TextStrokeColor3 = Color3.new(0, 0, 0),  -- Cor do contorno
    },
    MonitorInterval = 1,
    DistanceThreshold = 1000,
}

-- Variáveis
local RushChams = {}
local SelectedObject = nil
local Connections = {}
local player = game.Players.LocalPlayer

-- Funções utilitárias
local function Log(message)
    print("[INFO]: " .. message)
end

local function ApplyRushChams(inst)
    if not inst:IsDescendantOf(game.Workspace) then return nil end
    
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Settings.Highlight.FillColor
    Cham.FillTransparency = Settings.Highlight.FillTransparency
    Cham.OutlineColor = Settings.Highlight.OutlineColor
    Cham.Adornee = inst
    Cham.Enabled = true
    Cham.Parent = inst

    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Adornee = inst
    BillboardGui.Size = UDim2.new(0, 100, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    BillboardGui.AlwaysOnTop = true
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
    Label.TextScaled = false
    Label.TextSize = Settings.Label.TextSize
    Label.Parent = BillboardGui

    -- Adicionar sombra
    local Shadow = Instance.new("TextLabel")
    Shadow.Text = Settings.Label.Text
    Shadow.TextColor3 = Color3.new(0, 0, 0)  -- Sombra preta
    Shadow.TextSize = Settings.Label.TextSize
    Shadow.Font = Settings.Label.Font
    Shadow.TextStrokeTransparency = 0
    Shadow.TextStrokeColor3 = Color3.new(0, 0, 0)
    Shadow.Position = UDim2.new(0, 2, 0, 2)  -- Offset da sombra
    Shadow.Size = UDim2.new(1, 0, 1, 0)
    Shadow.BackgroundTransparency = 1
    Shadow.Parent = BillboardGui

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
        Log("Object deselected and chams removed")
    end
end

local function OnObjectSelected(inst)
    OnObjectDeselected()
    SelectedObject = inst
    local cham = ApplyRushChams(inst)
    if cham then
        table.insert(RushChams, cham)
        Log("Chams applied to selected object: " .. inst.Name)
    end
end

local function MonitorWorkspace()
    while true do
        for _, v in ipairs(Workspace:GetDescendants()) do
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
        until (player:DistanceFromCharacter(inst:GetPivot().Position) < Settings.DistanceThreshold) or not inst:IsDescendantOf(workspace)
        
        if inst:IsDescendantOf(workspace) then
            Log("RushMoving detected within range")
        end
    end
end

-- Conectar eventos
table.insert(Connections, Workspace.CurrentRooms.DescendantAdded:Connect(HandleNewInstance))
table.insert(Connections, workspace.ChildAdded:Connect(HandleNewInstance))

-- Iniciar monitoramento
Log("Starting to monitor Workspace for RushMoving")
spawn(MonitorWorkspace)

-- Inicializar com objetos existentes
for _, v in ipairs(Workspace:GetDescendants()) do
    if v.Name == "RushMoving" then
        OnObjectSelected(v)
    end
end

Log("Script initialized successfully")

-- 

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
    Text = "GOGOGOGOOGOGOOGOGOGOFOOFOFOFOFOOFOFOFOFO",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

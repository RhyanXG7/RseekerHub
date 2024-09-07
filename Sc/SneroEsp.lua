-- Configurações
local Settings = {
    Highlight = {
        FillColor = Color3.new(1, 0, 0),  -- Vermelho
        FillTransparency = 0.5,
        OutlineColor = Color3.new(1, 0, 0),  -- Vermelho
    },
    Label = {
        Text = "[Snare]",
        TextColor = Color3.new(1, 0, 0),  -- Vermelho
        TextSize = 14,
        Font = Enum.Font.GothamBold,  -- Fonte estilosa
        TextStrokeTransparency = 0,  -- Contorno
        TextStrokeColor3 = Color3.new(0, 0, 0),  -- Cor do contorno
    },
    MonitorInterval = 1,
    DistanceThreshold = 1000,
    Chams = {
        Color = Color3.new(1, 0, 0),  -- Cor do Chams
        Transparency = 0.5,
    },
}

-- Variáveis
local SnareChams = {}
local SelectedObject = nil
local Connections = {}
local player = game.Players.LocalPlayer

-- Funções utilitárias
local function Log(message)
    print("[INFO]: " .. message)
end

local function CreateHighlight(inst)
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Settings.Highlight.FillColor
    Cham.FillTransparency = Settings.Highlight.FillTransparency
    Cham.OutlineColor = Settings.Highlight.OutlineColor
    Cham.Adornee = inst
    Cham.Enabled = true
    Cham.RobloxLocked = true
    return Cham
end

local function CreateBillboardGui(inst)
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Adornee = inst
    BillboardGui.Size = UDim2.new(0, 100, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    BillboardGui.AlwaysOnTop = true

    local Label = Instance.new("TextLabel")
    Label.Text = Settings.Label.Text
    Label.TextColor3 = Settings.Label.TextColor
    Label.TextSize = Settings.Label.TextSize
    Label.Font = Settings.Label.Font
    Label.TextStrokeTransparency = Settings.Label.TextStrokeTransparency
    Label.TextStrokeColor3 = Settings.Label.TextStrokeColor3
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.TextScaled = false
    Label.Parent = BillboardGui

    return BillboardGui
end

local function CreateChams(inst)
    local chamsPart = Instance.new("Part")
    chamsPart.Name = "Chams"
    chamsPart.Size = inst.Size
    chamsPart.CFrame = inst.CFrame
    chamsPart.Anchored = true
    chamsPart.CanCollide = false
    chamsPart.BrickColor = BrickColor.new(Settings.Chams.Color)
    chamsPart.Material = Enum.Material.SmoothPlastic
    chamsPart.Transparency = Settings.Chams.Transparency
    chamsPart.Parent = inst

    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://0"  -- Usar uma mesh padrão
    mesh.TextureId = "rbxassetid://0"  -- Usar uma textura padrão
    mesh.Parent = chamsPart

    return chamsPart
end

local function ApplySnareChams(inst)
    if not inst:IsDescendantOf(game.Workspace) then return nil end
    
    -- Remove existing Highlight, BillboardGui, and Chams
    local existingHighlight = inst:FindFirstChildOfClass("Highlight")
    if existingHighlight then
        existingHighlight:Destroy()
    end

    local existingBillboard = inst:FindFirstChildOfClass("BillboardGui")
    if existingBillboard then
        existingBillboard:Destroy()
    end

    local existingChams = inst:FindFirstChild("Chams")
    if existingChams then
        existingChams:Destroy()
    end

    local highlight = CreateHighlight(inst)
    highlight.Parent = inst

    local billboardGui = CreateBillboardGui(inst)
    billboardGui.Parent = inst

    local chams = CreateChams(inst)
    chams.Parent = inst

    return highlight
end

local function OnObjectDeselected()
    if SelectedObject then
        for i = #SnareChams, 1, -1 do
            local cham = SnareChams[i]
            if cham.Adornee == SelectedObject then
                cham:Destroy()
                table.remove(SnareChams, i)
                Log("Deselected object: " .. SelectedObject.Name)
            end
        end
        SelectedObject = nil
    end
end

local function PlayNotification()
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
        Text = "🌵 Esp Snare ativo!",
        Icon = "rbxassetid://13264701341",
        Duration = 5
    })
end

local function OnObjectSelected(inst)
    OnObjectDeselected()
    SelectedObject = inst
    local cham = ApplySnareChams(inst)
    if cham then
        table.insert(SnareChams, cham)
        Log("Object selected: " .. inst.Name)
        PlayNotification()
    end
end

local function HandleNewInstance(inst)
    if inst.Name == "Snare" then
        OnObjectSelected(inst)
    end
end

local function MonitorWorkspace()
    while true do
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v.Name == "Snare" and not v:FindFirstChildOfClass("Highlight") then
                OnObjectSelected(v)
            end
        end
        wait(Settings.MonitorInterval)
    end
end

-- Conectar eventos
table.insert(Connections, Workspace.CurrentRooms.DescendantAdded:Connect(HandleNewInstance))
table.insert(Connections, workspace.ChildAdded:Connect(HandleNewInstance))

-- Iniciar monitoramento
Log("Starting to monitor Workspace for Snare")
spawn(MonitorWorkspace)

-- Inicializar com objetos existentes
for _, v in ipairs(Workspace:GetDescendants()) do
    if v.Name == "Snare" then
        OnObjectSelected(v)
    end
end

Log("Script initialized successfully")

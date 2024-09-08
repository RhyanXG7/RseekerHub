local KeyChams = {}
local SelectedObject = nil

local function ApplyKeyChams(inst)
    if not inst:IsDescendantOf(game.Workspace) then return nil end  -- Verificação para garantir que o objeto ainda existe
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(1, 0.647, 0)  -- Cor laranja
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.new(1, 0.647, 0)  -- Cor laranja
    Cham.Adornee = inst
    Cham.Enabled = true
    Cham.Parent = game:GetService("CoreGui")
    Cham.RobloxLocked = true

    -- Adicionando a legenda "[Figure]" com ESP em laranja
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Adornee = inst
    BillboardGui.Size = UDim2.new(0, 100, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    BillboardGui.AlwaysOnTop = true  -- Tornar visível através das paredes
    BillboardGui.Parent = Cham

    local Label = Instance.new("TextLabel")
    Label.Text = "[Figure]"
    Label.TextColor3 = Color3.new(1, 0.647, 0)  -- Cor laranja
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.TextScaled = false  -- Desativar escalonamento do texto
    Label.TextSize = 14  -- Tamanho fixo do texto
    Label.Parent = BillboardGui

    return Cham
end

local function OnObjectDeselected()
    if SelectedObject then
        for i = #KeyChams, 1, -1 do
            local cham = KeyChams[i]
            if cham.Adornee == SelectedObject then
                cham:Destroy()
                table.remove(KeyChams, i)
            end
        end
        SelectedObject = nil
    end
end

local function OnObjectSelected(inst)
    OnObjectDeselected()  -- Deselecionar qualquer objeto anterior
    SelectedObject = inst
    local cham = ApplyKeyChams(inst)
    if cham then
        table.insert(KeyChams, cham)
    end
end

Workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
    if inst.Name == "FigureRig" then
        OnObjectSelected(inst)
    end
end)

for _, v in ipairs(Workspace:GetDescendants()) do
    if v.Name == "FigureRig" then
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
    Text = "🦒 Esp Figure ativo!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})
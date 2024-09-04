local BookChams = {}

local function ApplyBookChams(inst)
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(1, 0, 0)
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.new(0.792156, 0.792156, 0.792156)
    Cham.Parent = game:GetService("CoreGui")
    Cham.Adornee = inst
    Cham.Enabled = true
    Cham.RobloxLocked = true

    -- Adicionando a legenda "[Livro]" com cor aleatória
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Adornee = inst
    BillboardGui.Size = UDim2.new(0, 100, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    BillboardGui.AlwaysOnTop = true  -- Tornar visível através das paredes
    BillboardGui.Parent = Cham

    local Label = Instance.new("TextLabel")
    Label.Text = "[Livro]"
    Label.TextColor3 = Color3.new(math.random(), math.random(), math.random())  -- Cor aleatória
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.TextScaled = false  -- Desativar escalonamento do texto
    Label.TextSize = 12  -- Fonte um pouco menor
    Label.Parent = BillboardGui

    return Cham
end

task.spawn(function()
    task.wait(1)
    for _, v in pairs(Workspace.CurrentRooms["50"].Assets:GetDescendants()) do
        if v.Name == "LiveHintBook" then
            ApplyBookChams(v)
        end
    end
end)

task.spawn(function()
    local Entity = Workspace.CurrentRooms["50"].FigureSetup:WaitForChild("FigureRagdoll", 5)
    Entity:WaitForChild("Torso", 2.5)
    ApplyBookChams(Entity)
end)

-- not

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
    Text = "📚 Esp de livros ativo!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

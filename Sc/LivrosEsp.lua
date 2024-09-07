local BookChams = {}

local function ApplyBookChams(inst)
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(1, 0, 0)
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.new(0.792156, 0.792156, 0.792156)
    Cham.Parent = inst 
    Cham.Adornee = inst
    Cham.Enabled = true

    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Adornee = inst
    BillboardGui.Size = UDim2.new(0, 100, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Parent = inst

    local Label = Instance.new("TextLabel")
    Label.Text = "[Livro]"
    Label.TextColor3 = Color3.new(math.random(), math.random(), math.random())
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.TextScaled = false
    Label.TextSize = 12
    Label.Parent = BillboardGui

    return Cham
end

task.spawn(function()
    while true do
        task.wait(1)
        local room = Workspace.CurrentRooms:FindFirstChild("50")
        if room and room.Assets then
            for _, v in pairs(room.Assets:GetDescendants()) do
                if v.Name == "LiveHintBook" and not v:FindFirstChildOfClass("Highlight") then
                    ApplyBookChams(v)
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        local room = Workspace.CurrentRooms:FindFirstChild("50")
        if room and room.FigureSetup then
            local Entity = room.FigureSetup:WaitForChild("FigureRagdoll", 5)
            if Entity and Entity:FindFirstChild("Torso") and not Entity:FindFirstChildOfClass("Highlight") then
                ApplyBookChams(Entity)
            end
        end
    end
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

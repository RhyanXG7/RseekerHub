local function ESP(objeto, texto, cor)
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Adornee = objeto
    BillboardGui.Size = UDim2.new(0, 100, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    BillboardGui.AlwaysOnTop = true  -- Garante visibilidade através das paredes
    BillboardGui.Parent = objeto

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Text = texto
    TextLabel.TextColor3 = cor
    TextLabel.TextSize = 20 
    TextLabel.BackgroundTransparency = 1 
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Font = Enum.Font.GothamBold  
    TextLabel.TextStrokeTransparency = 0  
    TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) 
    TextLabel.TextTransparency = 0.1  
    TextLabel.Parent = BillboardGui

    local Shadow = Instance.new("TextLabel")
    Shadow.Text = texto
    Shadow.TextColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.TextSize = 20
    Shadow.BackgroundTransparency = 1
    Shadow.Size = UDim2.new(1, 0, 1, 0)
    Shadow.Position = UDim2.new(0, 2, 0, 2) 
    Shadow.Font = Enum.Font.GothamBold
    Shadow.TextTransparency = 0.5  
    Shadow.Parent = BillboardGui

    local Highlight = Instance.new("Highlight")
    Highlight.FillColor = Color3.fromRGB(255, 255, 0) 
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 0)  
    Highlight.FillTransparency = 0.5
    Highlight.OutlineTransparency = 0.25
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop 
    Highlight.Parent = objeto

    objeto.AncestryChanged:Connect(function(_, parent)
        if not parent then
            BillboardGui:Destroy()
            Highlight:Destroy()
        end
    end)
end

local function ApplyESPToFuseHolders()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Name == "FuseHolder" then
            ESP(v, "[Fusível]", Color3.fromRGB(255, 0, 0)) 
        end
    end
end

workspace.DescendantAdded:Connect(function(inst)
    if inst.Name == "FuseHolder" then
        ESP(inst, "[Fusível]", Color3.fromRGB(255, 0, 0)) 
    end
end)

ApplyESPToFuseHolders()

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
    Text = "🏮 Esp Fusível ativo!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

for _, v in ipairs(workspace:GetDescendants()) do
    if v.Name == "FuseHolder" then
        OnObjectSelected(v)
    end
end

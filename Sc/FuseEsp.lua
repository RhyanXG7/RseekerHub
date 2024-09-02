local function ESP(objeto, texto, cor)
  
    if typeof(objeto) ~= "Instance" then
        error("A função ESP espera uma Instância, não " .. typeof(objeto))
    end

    if typeof(texto) ~= "string" then 
        texto = "Não foi possível atribuir o nome devido a um erro de tipo" 
    end

    if typeof(cor) ~= "Color3" then 
        cor = Color3.fromRGB(255, 255, 255) 
    end

    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Size = UDim2.new(0, 100, 0, 50)
    BillboardGui.MaxDistance = 2000
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Parent = objeto
    BillboardGui.Adornee = objeto
  
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
    TextLabel.TextScaled = true
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
    Shadow.TextScaled = true
    Shadow.Parent = BillboardGui

    local Highlight = Instance.new("Highlight")
    Highlight.FillColor = Color3.fromRGB(0, 0, 255)
    Highlight.OutlineColor = Color3.fromRGB(0, 0, 255)
    Highlight.FillTransparency = 0.5
    Highlight.OutlineTransparency = 0.25
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.Parent = objeto

    local rsConnection
    rsConnection = game:GetService("RunService").RenderStepped:Connect(function()
      
        if not objeto or not objeto:IsDescendantOf(workspace) then
            BillboardGui:Destroy()
            Highlight:Destroy()
            rsConnection:Disconnect()
        end
    end)
end

local SelectedObject = nil

local function OnObjectSelected(objeto)
    if SelectedObject then
    
        for _, gui in ipairs(SelectedObject:GetChildren()) do
            if gui:IsA("BillboardGui") or gui:IsA("Highlight") then
                gui:Destroy()
            end
        end
    end

    SelectedObject = objeto
    ESP(objeto, "[Fusível]", Color3.fromRGB(255, 0, 0))
end

workspace.DescendantAdded:Connect(function(inst)
    if inst.Name == "FuseHolder" then
        OnObjectSelected(inst)
    end
end)

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
    Text = "⚙️ Esp Fusível ativo!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})
-- Inicializa o ESP para FuseHolders já existentes
for _, v in ipairs(workspace:GetDescendants()) do
    if v.Name == "FuseHolder" then
        OnObjectSelected(v)
    end
end

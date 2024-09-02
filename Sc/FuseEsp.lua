-- Função ESP revisada
local function ESP(objeto, texto, cor)
    -- Verifica se o objeto é uma instância válida
    if typeof(objeto) ~= "Instance" then
        error("A função ESP espera uma Instância, não " .. typeof(objeto))
    end

    -- Verifica se o texto é uma string válida, caso contrário, define um texto padrão
    if typeof(texto) ~= "string" then 
        texto = "Não foi possível atribuir o nome devido a um erro de tipo" 
    end

    -- Verifica se a cor é válida, caso contrário, define a cor branca
    if typeof(cor) ~= "Color3" then 
        cor = Color3.fromRGB(255, 255, 255) 
    end

    -- Cria a BillboardGui para exibir o texto sobre o objeto
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Size = UDim2.new(0, 100, 0, 50)
    BillboardGui.MaxDistance = 2000 -- Define a distância máxima para ver o nome
    BillboardGui.AlwaysOnTop = true -- Garante que seja visível mesmo através de paredes
    BillboardGui.Parent = objeto
    BillboardGui.Adornee = objeto -- Vincula ao objeto

    -- Cria o TextLabel para exibir o texto
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Text = texto
    TextLabel.TextColor3 = cor
    TextLabel.TextSize = 20
    TextLabel.BackgroundTransparency = 1 -- Fundo transparente
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Font = Enum.Font.GothamBold -- Fonte estilosa
    TextLabel.TextStrokeTransparency = 0 -- Contorno ativo
    TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) -- Cor do contorno (preto)
    TextLabel.TextTransparency = 0.1 -- Ligeira transparência no texto
    TextLabel.TextScaled = true -- Ajusta o texto ao tamanho da GUI
    TextLabel.Parent = BillboardGui

    -- Adiciona uma sombra ao texto
    local Shadow = Instance.new("TextLabel")
    Shadow.Text = texto
    Shadow.TextColor3 = Color3.fromRGB(0, 0, 0) -- Sombra preta
    Shadow.TextSize = 20
    Shadow.BackgroundTransparency = 1
    Shadow.Size = UDim2.new(1, 0, 1, 0)
    Shadow.Position = UDim2.new(0, 2, 0, 2) -- Deslocamento da sombra
    Shadow.Font = Enum.Font.GothamBold
    Shadow.TextTransparency = 0.5 -- Transparência da sombra
    Shadow.TextScaled = true
    Shadow.Parent = BillboardGui

    -- Adiciona o Highlight (ESP)
    local Highlight = Instance.new("Highlight")
    Highlight.FillColor = Color3.fromRGB(0, 0, 255) -- Cor azul para o preenchimento
    Highlight.OutlineColor = Color3.fromRGB(0, 0, 255) -- Cor azul para o contorno
    Highlight.FillTransparency = 0.5
    Highlight.OutlineTransparency = 0.25
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- Garante visibilidade através de objetos
    Highlight.Parent = objeto

    -- Verifica continuamente se o objeto ainda está no jogo
    local rsConnection
    rsConnection = game:GetService("RunService").RenderStepped:Connect(function()
        -- Se o objeto não existir ou não estiver mais no workspace, remove a GUI e o Highlight
        if not objeto or not objeto:IsDescendantOf(workspace) then
            BillboardGui:Destroy()
            Highlight:Destroy()
            rsConnection:Disconnect()
        end
    end)
end

-- Aplicando ESP a todos os FuseHolders no workspace
local function ApplyESPToFuseHolders()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Name == "FuseHolder" then
            ESP(v, "[Fusível]", Color3.fromRGB(255, 0, 0)) -- Cor vermelha para o ESP e a legenda
        end
    end
end

-- Verifica se novos FuseHolders são adicionados ao jogo
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

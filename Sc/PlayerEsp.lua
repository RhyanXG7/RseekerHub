-- Função para criar ESP
local function createESP(player)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = player.Character
    highlight.FillColor = Color3.fromRGB(0, 255, 0)
    highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
    highlight.Parent = player.Character
end

-- Função para atualizar a GUI com vida, distância e nome
local function updateGUI(player, gui)
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") and character:FindFirstChild("Head") then
        local humanoid = character.Humanoid
        local distance = (character.PrimaryPart.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).Magnitude
        gui.Text = string.format("Nome: %s\nVida: %d\nDistância: %.2f", player.Name, humanoid.Health, distance)
    end
end

-- Função para criar a GUI acima do jogador
local function createGUI(player)
    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = player.Character:WaitForChild("Head")
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextStrokeTransparency = 0.5
    textLabel.TextScaled = true
    textLabel.Parent = billboard

    billboard.Parent = player.Character

    -- Atualizar a GUI periodicamente
    game:GetService("RunService").RenderStepped:Connect(function()
        updateGUI(player, textLabel)
    end)
end

-- Adicionar ESP e GUI para todos os jogadores
for _, player in pairs(game.Players:GetPlayers()) do
    if player.Character then
        createESP(player)
        createGUI(player)
    end
    player.CharacterAdded:Connect(function(character)
        createESP(player)
        createGUI(player)
    end)
end

-- Adicionar ESP e GUI para novos jogadores
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        createESP(player)
        createGUI(player)
    end)
end)

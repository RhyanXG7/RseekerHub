local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local debris = game:GetService("Debris")

-- Variáveis de controle
local canPassThrough = false -- Começa com atravessar objetos desativado

-- Cria a interface do usuário
local function createHUD()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "PassThroughHUD"
    screenGui.Parent = localPlayer.PlayerGui

    -- Botão para ativar/desativar atravessar objetos
    local buttonTogglePassThrough = Instance.new("TextButton")
    buttonTogglePassThrough.Size = UDim2.new(0, 150, 0, 50)
    buttonTogglePassThrough.Position = UDim2.new(0, 10, 0, 10)
    buttonTogglePassThrough.Text = "Toggle Pass-Through"
    buttonTogglePassThrough.Parent = screenGui

    buttonTogglePassThrough.MouseButton1Click:Connect(function()
        canPassThrough = not canPassThrough
        if canPassThrough then
            buttonTogglePassThrough.Text = "🪞 Noclip: ON"
            character.HumanoidRootPart.CanCollide = false
        else
            buttonTogglePassThrough.Text = "🪨 Noclip: OFF"
            character.HumanoidRootPart.CanCollide = true
        end
    end)
end

createHUD()

-- Função para ajustar a colisão dos objetos
local function setCollision(enable)
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part ~= character.HumanoidRootPart then
            if part.Position.Y > character.HumanoidRootPart.Position.Y then
                part.CanCollide = not enable
            end
        end
    end
end

-- Atualiza a colisão em cada frame
local function onRenderStepped()
    if canPassThrough then
        setCollision(true)
    else
        setCollision(false)
    end
end

game:GetService("RunService").RenderStepped:Connect(onRenderStepped)

-- Função para desativar atravessar paredes ao morrer
local function onCharacterDied()
    canPassThrough = false
    character.HumanoidRootPart.CanCollide = true
    local buttonTogglePassThrough = localPlayer.PlayerGui:FindFirstChild("PassThroughHUD"):FindFirstChild("TextButton")
    if buttonTogglePassThrough then
        buttonTogglePassThrough.Text = "Noclip: OFF"
    end
end

humanoid.Died:Connect(onCharacterDied)

-- Reconectar eventos ao respawnar
localPlayer.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    humanoid.Died:Connect(onCharacterDied)
end)

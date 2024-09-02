local KeyChams = {keyMarkers = {}}
local isEnabled = false 
local camera = game.Workspace.CurrentCamera


local function createLine(from, to, color, thickness)
    local line = Drawing.new("Line")
    line.From = from
    line.To = to
    line.Color = color
    line.Thickness = thickness
    line.Visible = true
    return line
end
local function createESP(player)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = player.Character
    highlight.FillColor = Color3.fromRGB(0, 255, 0)
    highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
    highlight.Parent = player.Character
end

local function updateLines()

    for _, marker in ipairs(KeyChams.keyMarkers) do
        marker.Visible = false
        marker:Destroy()
    end
    KeyChams.keyMarkers = {}

    local screenBottomCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)

    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local humanoidRootPart = player.Character.HumanoidRootPart
            local screenPoint, onScreen = camera:WorldToScreenPoint(humanoidRootPart.Position)


            
            if onScreen then
                local line = createLine(
                    screenBottomCenter,
                    Vector2.new(screenPoint.X, screenPoint.Y),
                    Color3.fromRGB(255, 0, 0),
                    2
                )
                table.insert(KeyChams.keyMarkers, line)
            end
        end
    end
end

local function updateGUI(player, gui)
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") and character:FindFirstChild("Head") then
        local humanoid = character.Humanoid
        local distance = (character.PrimaryPart.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).Magnitude
        gui.Text = string.format("Nome: %s\nVida: %d\nDistância: %.2f", player.Name, humanoid.Health, distance)
    end
end

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

    game:GetService("RunService").RenderStepped:Connect(function()
        updateGUI(player, textLabel)
    end)
end

local function setupPlayer(player)
    if player.Character then
        createESP(player)
        createGUI(player)
    end
    player.CharacterAdded:Connect(function(character)
        createESP(player)
        createGUI(player)
    end)
end

for _, player in pairs(game.Players:GetPlayers()) do
    setupPlayer(player)
end

game.Players.PlayerAdded:Connect(setupPlayer)

game:GetService("RunService").RenderStepped:Connect(updateLines)

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
    Text = "🎮 ESP JOGADORES ATIVO!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

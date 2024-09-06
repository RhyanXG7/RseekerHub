local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")

local scriptActivated = false

local function getFPS()
    local fps = math.floor(1 / runService.RenderStepped:Wait())
    return fps
end

local function getPing()
    local ping = math.floor(player:GetNetworkPing() * 1000)
    return ping
end

if not player:WaitForChild("PlayerGui"):FindFirstChild("NetworkStats") then
    scriptActivated = true -- Marca como ativado para impedir que rode novamente

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NetworkStats"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0, 200, 0, 30)
    titleLabel.Position = UDim2.new(0, 10, 0, 0) -- Posição acima do frame
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 24
    titleLabel.Text = "RSeekerHub"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.Parent = screenGui


    local function changeColorRandomly()
        while true do
            titleLabel.TextColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
            wait(0.5) -- Intervalo de mudança de cor (0.5 segundos)
        end
    end


    spawn(changeColorRandomly)


    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 100)
    frame.Position = UDim2.new(0, 10, 0, 35) -- Posição abaixo do título
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Parent = frame

    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Size = UDim2.new(1, -20, 0, 30)
    fpsLabel.Position = UDim2.new(0, 10, 0, 5)
    fpsLabel.Font = Enum.Font.SourceSansBold
    fpsLabel.TextSize = 20
    fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
    fpsLabel.Parent = frame

    local pingLabel = Instance.new("TextLabel")
    pingLabel.Size = UDim2.new(1, -20, 0, 30)
    pingLabel.Position = UDim2.new(0, 10, 0, 35)
    pingLabel.Font = Enum.Font.SourceSansBold
    pingLabel.TextSize = 20
    pingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    pingLabel.BackgroundTransparency = 1
    pingLabel.TextXAlignment = Enum.TextXAlignment.Left
    pingLabel.Parent = frame

    local connectionLabel = Instance.new("TextLabel")
    connectionLabel.Size = UDim2.new(1, -20, 0, 30)
    connectionLabel.Position = UDim2.new(0, 10, 0, 65)
    connectionLabel.Font = Enum.Font.SourceSansBold
    connectionLabel.TextSize = 20
    connectionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    connectionLabel.BackgroundTransparency = 1
    connectionLabel.TextXAlignment = Enum.TextXAlignment.Left
    connectionLabel.Parent = frame

    local function getConnectionStatus()
        local ping = getPing()
        if ping < 100 then
            return "Ótima ⭐"
        elseif ping < 200 then
            return "Boa 🟢"
        elseif ping < 300 then
            return "Razoável 🟡"
        else
            return "Ruim 🔴"
        end
    end

    runService.RenderStepped:Connect(function()
        fpsLabel.Text = "FPS: " .. tostring(getFPS())
        pingLabel.Text = "Ping: " .. tostring(getPing()) .. " ms"
        connectionLabel.Text = "Conexão: " .. getConnectionStatus()
    end)

    local tween = tweenService:Create(frame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.2})
    tween:Play()
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
    Text = "📱 Informações de PING e FPS estão sendo exibidas agora.",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

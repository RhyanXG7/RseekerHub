local player = game.Players.LocalPlayer

local fullbrightSettings = {
    Brightness = 2, 
    Ambient = Color3.fromRGB(255, 255, 255),
    OutdoorAmbient = Color3.fromRGB(255, 255, 255)
}

local function activateFullbright()
    game.Lighting.Brightness = fullbrightSettings.Brightness
    game.Lighting.Ambient = fullbrightSettings.Ambient
    game.Lighting.OutdoorAmbient = fullbrightSettings.OutdoorAmbient
end

activateFullbright()

-- por favor não roube meu código ;D
-- Feito com ♥️ por Rhyan57 & SeekAlegriaFla.
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
    Text = "👁️ FULLBRIGHT ATIVO!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

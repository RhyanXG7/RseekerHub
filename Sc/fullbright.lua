-- por favor não roube meu código ;D
-- Feito com ♥️ por Rhyan57 & SeekAlegriaFla.
local StarterGui = game:GetService("StarterGui")

local Notifications = {
	"👁️ Visão infinita ativo!",
	"♥️ RSeeker HUB",
}

local TimeBetweenNotifications = 5 -- Substitua 5 pelo número de segundos que deseja esperar entre as notificações

for i = 1, #Notifications do
	local Notification = Notifications[i]
	
	StarterGui:SetCore("SendNotification", {
		Title = "RSeekerHUB - Server",
		Text = Notification,
		Duration = 3
	})
	
	wait(TimeBetweenNotifications)
end

local player = game.Players.LocalPlayer

local fullbrightSettings = {
    Brightness = 2, -- Aumenta o brilho ao máximo
    Ambient = Color3.fromRGB(255, 255, 255), -- Define a iluminação ambiente como branca (iluminação total)
    OutdoorAmbient = Color3.fromRGB(255, 255, 255) -- Define a iluminação externa como branca (iluminação total)
}

local function activateFullbright()
    game.Lighting.Brightness = fullbrightSettings.Brightness
    game.Lighting.Ambient = fullbrightSettings.Ambient
    game.Lighting.OutdoorAmbient = fullbrightSettings.OutdoorAmbient
end

activateFullbright()

local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer

local function noClip()
    local character = player.Character or player.CharacterAdded:Wait()

    -- Função para desativar a colisão
    local function disableCollision()
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end

    -- Reaplica o NoClip constantemente
    RunService.Stepped:Connect(function()
        disableCollision()
    end)
end

-- Ativar o NoClip
noClip()

local StarterGui = game:GetService("StarterGui")

local Notifications = {
	"👻 NoClip Ativo",
	"♥️ RSeeker HUB",
}

local TimeBetweenNotifications = 5 -- Substitua 5 pelo número de segundos que deseja esperar entre as notificações

for i = 1, #Notifications do
	local Notification = Notifications[i]
	
	StarterGui:SetCore("SendNotification", {
		Title = "RSeekerHUB",
		Text = Notification,
		Duration = 5
	})
	
	wait(TimeBetweenNotifications)
end

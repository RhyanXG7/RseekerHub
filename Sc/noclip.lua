local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer

-- Variável para controlar o estado do NoClip
local noClipEnabled = false
local noClipConnection

-- Função para alternar o NoClip
local function toggleNoClip()
    local character = player.Character or player.CharacterAdded:Wait()

    -- Função para desativar a colisão
    local function disableCollision()
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end

    if noClipEnabled then
        -- Desativa o NoClip
        if noClipConnection then
            noClipConnection:Disconnect()
            noClipConnection = nil
        end
        -- Restaurar a colisão das partes do personagem
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
        print("NoClip desativado.")
    else
        -- Ativa o NoClip
        noClipConnection = RunService.Stepped:Connect(function()
            disableCollision()
        end)
        print("NoClip ativado.")
    end

    -- Alterna o estado
    noClipEnabled = not noClipEnabled
end

-- Adicionar o botão na aba existente
Tab:AddButton({
    Name = "Toggle NoClip",
    Callback = function()
        toggleNoClip()
    end    
})

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

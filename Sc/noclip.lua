local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Variável para controlar o estado do noclip
if _G.noclipEnabled == nil then
    _G.noclipEnabled = false
end

local noclipConnection

-- Função para ativar/desativar noclip
local function toggleNoclip()
    _G.noclipEnabled = not _G.noclipEnabled
    
    if _G.noclipEnabled then
        -- Ativa noclip
        noclipConnection = RunService.Stepped:Connect(function()
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
        print("Noclip ativado")
    else
        -- Desativa noclip e restaura colisão
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
        print("Noclip desativado")
    end
end

-- Alternar o estado do noclip ao executar o script
toggleNoclip()

local StarterGui = game:GetService("StarterGui")

local Notifications = {
	"👻 NOCLIP Ativo!",
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

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
toggleNoclip()


-- Separando
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
    Text = "👻 NOCLIP ATIVO!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

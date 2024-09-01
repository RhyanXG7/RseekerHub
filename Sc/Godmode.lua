local StarterGui = game:GetService("StarterGui")

local Notifications = {
	"♥️ GodMode Agora está sendo exibido.",
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
-- Finno Rhyan
local elevated = false
local originalPosition = nil
local soundId = "rbxassetid://6063383861"

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")


local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local godModeButton = Instance.new("TextButton")

godModeButton.Size = UDim2.new(0, 200, 0, 50)
godModeButton.Position = UDim2.new(0.5, -100, 0.9, -25)
godModeButton.Text = "GODMODE [OFF]"
godModeButton.TextScaled = true
godModeButton.BackgroundColor3 = Color3.new(0, 0, 0)
godModeButton.TextColor3 = Color3.new(1, 1, 1)
godModeButton.Parent = screenGui


local function playSound()
    local sound = Instance.new("Sound", humanoidRootPart)
    sound.SoundId = soundId
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

local function toggleGodMode()
    if elevated then
    
        humanoidRootPart.CFrame = originalPosition
        elevated = false
        godModeButton.Text = "GODMODE [OFF]"
    else

        originalPosition = humanoidRootPart.CFrame
        humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 20, 0)
        elevated = true

        local cam = workspace.CurrentCamera
        cam.CFrame = originalPosition
        godModeButton.Text = "GODMODE [ON]"
    end

    playSound()
end

godModeButton.MouseButton1Click:Connect(toggleGodMode)

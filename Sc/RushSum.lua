
local function ExecuteCustomScript(inst)
  
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
    Text = "⚠️ Rush Nasceu, Esconda-se!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})
end

Workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
    if inst.Name == "RushMoving" then
        ExecuteCustomScript(inst)
    end
end)

while true do
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v.Name == "RushMoving" then
            ExecuteCustomScript(v)
        end
    end
    wait(1) 
end

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://3458224686"
sound.Volume = 1
sound.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
sound:Play()
sound.Ended:Connect(function()
    sound:Destroy()
end)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "🔔 Notificação ",
    Text = "⚠️ Notificação rush ativa!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})


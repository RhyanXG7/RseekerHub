local entities = {
    "AmbushMoving"
}
local player = game.Players.LocalPlayer
local hasNotified = false

local function playNotif(soundId)
    local Notification = Instance.new("Sound")
    Notification.Parent = game.SoundService
    Notification.SoundId = soundId or "rbxassetid://4590656842"
    Notification.Volume = 5
    Notification.PlayOnRemove = true
    Notification:Play()
    task.delay(2, function() 
        Notification:Destroy()
    end)
end

local function sendNotification(title, text, icon)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Icon = icon
    })
end

workspace.ChildAdded:Connect(function(test)
    if not hasNotified and table.find(entities, test.Name) then
        local connection
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            if test:IsDescendantOf(workspace) then
                local distance = player:DistanceFromCharacter(test:GetPivot().Position)
                
                if distance < 1000 then
                    sendNotification("Ambush surgiu", "Entre num armário!", "rbxassetid://10722835168")
                    playNotif()
                    hasNotified = true
                    connection:Disconnect()
                end
            else
                connection:Disconnect()
            end
        end)
    end
end)

-- Notificação 

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
    Text = "👹 Avisos Ambush Ativo!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

local entities = {
    "Eyes"
}
local player = game.Players.LocalPlayer
local notifiedEntities = {}

local function playNotif(soundId)
    local Notification = Instance.new("Sound")
    Notification.Parent = game.SoundService
    Notification.SoundId = soundId or "rbxassetid://4590656842"
    Notification.Volume = 1
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
    if table.find(entities, test.Name) and not notifiedEntities[test] then
        local success, position = pcall(function() return test:GetPivot().Position end)
        if success and position then
            local connection
            connection = game:GetService("RunService").Heartbeat:Connect(function()
                if test:IsDescendantOf(workspace) then
                    sendNotification("Eyes surgiu", "Olhe para baixo!", "rbxassetid://137800607276796")
                    playNotif()
                    notifiedEntities[test] = true
                    connection:Disconnect()
                else
                    connection:Disconnect()
                end
            end)
        else
            warn("O objeto não tem um Pivot válido.")
        end

        test.AncestryChanged:Connect(function(_, parent)
            if not parent then
                notifiedEntities[test] = nil 
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
    Text = "👹 Avisos Eyes Ativo!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

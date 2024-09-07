local entities = {
    "RushMoving"
}
local player = game.Players.LocalPlayer

local function playNotif(soundId)
    local Notification = Instance.new("Sound")
    Notification.Parent = game.SoundService
    Notification.SoundId = soundId or "rbxassetid://4590656842"
    Notification.Volume = 5
    Notification.PlayOnRemove = true
    Notification:Play()
    task.delay(2, function() -- Ajustar o tempo de espera para tocar o som
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
    if table.find(entities, test.Name) then
        repeat
            task.wait()
        until (player:DistanceFromCharacter(test:GetPivot().Position) < 1000) or not test:IsDescendantOf(workspace)

        if test:IsDescendantOf(workspace) then
            print(test.Name)

            if test.Name == "RushMoving" then
                sendNotification("Rush surgiu", "Entre num armário!", "https://static.wikia.nocookie.net/doors-game/images/4/4d/Rush1.png/revision/latest?cb=20240209082944")
                playNotif()
            end
        end
    elseif test:IsA("Model") and test.PrimaryPart and test.PrimaryPart.Name == "RushNew" then
        sendNotification(test.Name .. " foi gerado.", "Entre num armário!", "rbxassetid://11401835408")
        playNotif()
    end
end)

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
    Text = "👹 Avisos Rush Ativo!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

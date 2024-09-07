local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://7116606826"
sound.Volume = 1
sound.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
sound:Play()
sound.Ended:Connect(function()
    sound:Destroy()
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "🔔 Notificação",
    Text = "⚠️ Notificação rush ativa!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

wait(5)

local notifiedEntities = {}

local function ExecuteCustomScript(inst)
    if not notifiedEntities[inst] then
        notifiedEntities[inst] = true

        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://7116606826"
        sound.Volume = 1
        sound.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)

        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "🔔 Notificação",
            Text = "⚠️ Rush Nasceu, Esconda-se!",
            Icon = "rbxassetid://12443291836",
            Duration = 5
        })
    end
end

Workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
    if inst.Name == "RushMoving" then
        ExecuteCustomScript(inst)
    end
end)

for _, v in ipairs(Workspace:GetDescendants()) do
    if v.Name == "RushMoving" and not notifiedEntities[v] then
        ExecuteCustomScript(v)
    end
end


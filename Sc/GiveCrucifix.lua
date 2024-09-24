print("gae")
local lplr = game.Players.LocalPlayer
while true do
    task.wait()
    for e, shit in ipairs(workspace:GetDescendants()) do
        if shit.Name == "RushNew" then
            local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - shit.CFrame.Position).magnitude
            print(dist)
            if dist <= 65 then
                task.spawn(function()
                    lplr.Backpack.Crucifix.Parent = lplr.Character
                end)
                task.spawn(function()
                    task.wait(0.05)
                    local args = {
                        [1] = game:GetService("Players").LocalPlayer.Character.Crucifix
                    }
    
                    game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):WaitForChild("DropItem"):FireServer(unpack(args))
                    task.wait(0.4)
                    for e, shit in ipairs(workspace.Drops:GetDescendants()) do
                        if shit:IsA("ProximityPrompt") then
                            if shit.ObjectText == "Crucifix" then
                                fireproximityprompt(shit)
                            end
                        end
                    end
                end)
                task.wait(0.2)
            end
        end
    end
end

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
    Text = "✝️ Crucifixo spawnado!",
    Icon = "rbxassetid://12628167051",
    Duration = 5
})

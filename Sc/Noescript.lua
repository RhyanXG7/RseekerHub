-- ISSO AVISA QAUNDO NÃO AH FUNÇÕES NAS PÁGINAS. -- RHYAN57.

-- ERROR
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://5914602124"
sound.Volume = 4
sound.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
sound:Play()
sound.Ended:Connect(function()
    sound:Destroy()
end)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "⚠️ !ATENÇÃO! ⚠️",
    Text = "Não a scripts configurados neste local! ",
    Icon = "rbxassetid://696390631",
    Duration = 9
})

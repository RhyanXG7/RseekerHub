local KeyChams = {}
local SelectedObject = nil

local function ApplyKeyChams(inst)
    if not inst:IsDescendantOf(game.Workspace) then return nil end  -- Verificação para garantir que o objeto ainda existe
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(0.980392, 0.670588, 0)
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.new(0.792156, 0.792156, 0.792156)
    Cham.Adornee = inst
    Cham.Enabled = true
    Cham.Parent = game:GetService("CoreGui")
    Cham.RobloxLocked = true
    return Cham
end

local function OnObjectDeselected()
    if SelectedObject then
        for i = #KeyChams, 1, -1 do
            local cham = KeyChams[i]
            if cham.Adornee == SelectedObject then
                cham:Destroy()
                table.remove(KeyChams, i)
            end
        end
        SelectedObject = nil
    end
end

local function OnObjectSelected(inst)
    OnObjectDeselected()  -- Deselecionar qualquer objeto anterior
    SelectedObject = inst
    local cham = ApplyKeyChams(inst)
    if cham then
        table.insert(KeyChams, cham)
    end
end

Workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
    if inst.Name == "KeyObtain" then
        OnObjectSelected(inst)
    end
end)

for _, v in ipairs(Workspace:GetDescendants()) do
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

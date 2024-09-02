local esptable = {lockers={}}

local function ApplyLockerChams(inst)
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(0.57, 0.39, 0.10) -- Cor do ESP (marrom claro)
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.new(0.792156, 0.792156, 0.792156) -- Cor do contorno
    Cham.Parent = game:GetService("CoreGui")
    Cham.Adornee = inst
    Cham.Enabled = true
    Cham.RobloxLocked = true
    return Cham
end

local function checkLocker(v)
    if v:IsA("Model") and v:FindFirstChild("PrimaryPart") then
        task.wait(0.1)
        if v.Name == "Wardrobe" or v.Name == "Rooms_Locker" or v.Name == "Rooms_Locker_Fridge" then
            local h = ApplyLockerChams(v.PrimaryPart)
            table.insert(esptable.lockers, h)
        end
    end
end

local function setupLockers(room)
    local assets = room:WaitForChild("Assets", 5)
    
    if assets then
        local subaddcon
        subaddcon = assets.DescendantAdded:Connect(function(v)
            checkLocker(v)
        end)
        
        for i,v in pairs(assets:GetDescendants()) do
            checkLocker(v)
        end
        
        task.spawn(function()
            repeat task.wait() until not flags.esplocker
            subaddcon:Disconnect()
        end)
    end
end

local addconnect
addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
    setupLockers(room)
end)

for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
    setupLockers(room)
end

repeat task.wait() until not flags.esplocker
addconnect:Disconnect()
for i,v in pairs(esptable.lockers) do
    v.Enabled = false
    v.Adornee = nil
    v:Destroy()
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
    Text = "🗄️ Esp de armários ativo!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

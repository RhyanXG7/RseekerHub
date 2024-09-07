local RushChams = {}
local SelectedObject = nil

local function ApplyRushChams(inst)
    if not inst:IsDescendantOf(game.Workspace) then return nil end 
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(0, 0, 0.5) 
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.new(0, 0, 0.5) 
    Cham.Adornee = inst
    Cham.Enabled = true
    Cham.Parent = game:GetService("CoreGui")
    Cham.RobloxLocked = true

    -- Adicionando a legenda "[Rush]" com ESP em azul escuro
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Adornee = inst
    BillboardGui.Size = UDim2.new(0, 100, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    BillboardGui.AlwaysOnTop = true 
    BillboardGui.Parent = Cham

    local Label = Instance.new("TextLabel")
    Label.Text = "[Rush]"
    Label.TextColor3 = Color3.new(0, 0, 0.5) 
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.TextScaled = false 
    Label.TextSize = 14 
    Label.Parent = BillboardGui

    return Cham
end

local function OnObjectDeselected()
    if SelectedObject then
        for i = #RushChams, 1, -1 do
            local cham = RushChams[i]
            if cham.Adornee == SelectedObject then
                cham:Destroy()
                table.remove(RushChams, i)
            end
        end
        SelectedObject = nil
    end
end

local function OnObjectSelected(inst)
    OnObjectDeselected()
    SelectedObject = inst
    local cham = ApplyRushChams(inst)
    if cham then
        table.insert(RushChams, cham)
    end
end

Workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
    if inst.Name == "RushMoving" then
        OnObjectSelected(inst)
    end
end)

for _, v in ipairs(Workspace:GetDescendants()) do
    if v.Name == "RushMoving" then
        OnObjectSelected(v)
    end
end

-- Not

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
    Text = "👹 Esp Rush Ativo!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

local BandageChams = {}
local SelectedObject = nil

local function ApplyBandageChams(inst)
    if not inst:IsDescendantOf(game.Workspace) then return nil end

    local Cham = Instance.new("Highlight")
    Cham.Name = "BANDAGE ESP : SeekerHub"
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(0, 1, 0)
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.new(0, 0.8, 0)
    Cham.OutlineTransparency = 0
    Cham.Adornee = inst
    Cham.Enabled = true
    Cham.Parent = inst

    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Name = "BANDAGE LGD : SeekerHub"
    BillboardGui.Adornee = inst
    BillboardGui.Size = UDim2.new(0, 100, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Parent = inst

    local Label = Instance.new("TextLabel")
    Label.Text = "[Curativo]"
    Label.TextColor3 = Color3.new(0, 1, 0) 
    Label.Font = Enum.Font.Fantasy 
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.TextScaled = true
    Label.TextSize = 14
    Label.Parent = BillboardGui

    return Cham
end

local function OnObjectDeselected()
    if SelectedObject then
        for i = #BandageChams, 1, -1 do
            local cham = BandageChams[i]
            if cham.Adornee == SelectedObject then
                cham:Destroy()
                table.remove(BandageChams, i)
            end
        end
        SelectedObject = nil
    end
end

local function OnObjectSelected(inst)
    OnObjectDeselected()
    SelectedObject = inst
    local cham = ApplyBandageChams(inst)
    if cham then
        table.insert(BandageChams, cham)
    end
end

Workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
    if inst.Name == "Bandage" then
        OnObjectSelected(inst)
    end
end)

for _, v in ipairs(Workspace:GetDescendants()) do
    if v.Name == "Bandage" then
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
    Text = "🩹 Esp do curativo agora ativo/desativado",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

local GuidChams = {}
local SelectedObject = nil

local function ApplyGuidChams(inst)
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

    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Adornee = inst
    BillboardGui.Size = UDim2.new(0, 100, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Parent = Cham

    local Label = Instance.new("TextLabel")
    Label.Text = "[Guid]"
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
        for i = #GuidChams, 1, -1 do
            local cham = GuidChams[i]
            if cham.Adornee == SelectedObject then
                cham:Destroy()
                table.remove(GuidChams, i)
            end
        end
        SelectedObject = nil
    end
end

local function OnObjectSelected(inst)
    OnObjectDeselected()
    SelectedObject = inst
    local cham = ApplyGuidChams(inst)
    if cham then
        table.insert(GuidChams, cham)
    end
end

Workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
    if inst.Name == "GuidePart" then
        OnObjectSelected(inst)
    end
end)

for _, v in ipairs(Workspace:GetDescendants()) do
    if v.Name == "GuidePart" then
        OnObjectSelected(v)
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
    Text = "☪️ Esp GuidingLight Ativo!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

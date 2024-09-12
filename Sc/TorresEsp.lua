local MinesAnchorChams = {}
local SelectedObject = nil

local function ApplyMinesAnchorChams(inst)
    if not inst:IsDescendantOf(game.Workspace) then return nil end

    local Cham = Instance.new("Highlight")
    Cham.Name = "MINESANCHOR ESP : SeekerHub"
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(0.5, 0.5, 0.5) -- Cinza
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.new(0.3, 0.3, 0.3)
    Cham.OutlineTransparency = 0
    Cham.Adornee = inst
    Cham.Enabled = true
    Cham.Parent = inst

    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Name = "MINESANCHOR LGD : SeekerHub"
    BillboardGui.Adornee = inst
    BillboardGui.Size = UDim2.new(0, 100, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Parent = inst

    local Label = Instance.new("TextLabel")
    Label.Text = "[Torre]"
    Label.TextColor3 = Color3.new(0.5, 0.5, 0.5) 
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
        for i = #MinesAnchorChams, 1, -1 do
            local cham = MinesAnchorChams[i]
            if cham.Adornee == SelectedObject then
                cham:Destroy()
                table.remove(MinesAnchorChams, i)
            end
        end
        SelectedObject = nil
    end
end

local function OnObjectSelected(inst)
    OnObjectDeselected()
    SelectedObject = inst
    local cham = ApplyMinesAnchorChams(inst)
    if cham then
        table.insert(MinesAnchorChams, cham)
    end
end

Workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
    if inst.Name == "MinesAnchor" then
        OnObjectSelected(inst)
    end
end)

for _, v in ipairs(Workspace:GetDescendants()) do
    if v.Name == "MinesAnchor" then
        OnObjectSelected(v)
    end
end
-- not
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
    Text = "🗼 Esp torres 150 ativo!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

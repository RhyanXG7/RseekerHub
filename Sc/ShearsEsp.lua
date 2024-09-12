local ShearsChams = {}
local SelectedObject = nil

local function ApplyShearsChams(inst)
    if not inst:IsDescendantOf(game.Workspace) then return nil end

    local Cham = Instance.new("Highlight")
    Cham.Name = "SHEARS ESP : SeekerHub"
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(1, 1, 1)
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.new(0.8, 0.8, 0.8) 
    Cham.OutlineTransparency = 0
    Cham.Adornee = inst
    Cham.Enabled = true
    Cham.Parent = inst

    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Name = "SHEARS LGD : SeekerHub"
    BillboardGui.Adornee = inst
    BillboardGui.Size = UDim2.new(0, 100, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Parent = inst

    local Label = Instance.new("TextLabel")
    Label.Text = "[Tesoura]"
    Label.TextColor3 = Color3.new(1, 1, 1)
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
        for i = #ShearsChams, 1, -1 do
            local cham = ShearsChams[i]
            if cham.Adornee == SelectedObject then
                cham:Destroy()
                table.remove(ShearsChams, i)
            end
        end
        SelectedObject = nil
    end
end

local function OnObjectSelected(inst)
    OnObjectDeselected()
    SelectedObject = inst
    local cham = ApplyShearsChams(inst)
    if cham then
        table.insert(ShearsChams, cham)
    end
end

Workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
    if inst.Name == "Shears" then
        OnObjectSelected(inst)
    end
end)

for _, v in ipairs(Workspace:GetDescendants()) do
    if v.Name == "Shears" then
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
    Text = "✂️ Esp tesoura ativo!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

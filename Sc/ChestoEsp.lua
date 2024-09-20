local ChestChams = {}
local SelectedObject = nil

local function ApplyChestChams(inst)
    if not inst:IsDescendantOf(game.Workspace) then return nil end

    local Cham = Instance.new("Highlight")
    Cham.Name = "BAU ESP : SeekerHub"
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(0, 1, 1)
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.new(0, 1, 1)
    Cham.OutlineTransparency = 0
    Cham.Adornee = inst
    Cham.Enabled = true
    Cham.Parent = inst

    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Name = "BAU LGD : SeekerHub"
    BillboardGui.Adornee = inst
    BillboardGui.Size = UDim2.new(0, 50, 0, 25)
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Parent = inst

    local Label = Instance.new("TextLabel")
    Label.Text = "[Baú]"
    Label.TextColor3 = Color3.new(0, 1, 1)
    Label.Font = Enum.Font.GothamBold 
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.TextScaled = false
    Label.TextSize = 12 
    Label.TextStrokeTransparency = 0
    Label.TextStrokeColor3 = Color3.new(0, 0, 0)
    Label.Parent = BillboardGui

    return Cham
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
    Text = "📦 Esp do Bau agora ativo/desativado.",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

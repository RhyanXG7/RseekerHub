local AmbushChams = {}
local SelectedObject = nil

local function ApplyAmbushChams(inst)
    if not inst:IsDescendantOf(game.Workspace) then return nil end
    
    
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(0, 1, 0) 
    Cham.FillTransparency = 0.2 
    Cham.OutlineColor = Color3.new(0, 1, 0) 
    Cham.OutlineTransparency = 0 
    Cham.Adornee = inst
    Cham.Enabled = true
    Cham.Name = "Ambush ESP : SeekerHub"  
    Cham.Parent = inst

    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Adornee = inst
    BillboardGui.Size = UDim2.new(0, 100, 0, 30) 
    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Name = "Ambush LGD : SeekerHub" 
    BillboardGui.Parent = inst

    local Label = Instance.new("TextLabel")
    Label.Text = "[Ambush]"
    Label.TextColor3 = Color3.new(0, 1, 0) 
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.TextScaled = false
    Label.TextSize = 14
    Label.Font = Enum.Font.GothamBold 
    Label.TextStrokeTransparency = 0.5
    Label.TextStrokeColor3 = Color3.new(0, 0, 0) 
    Label.Parent = BillboardGui

    return Cham
end

local function OnObjectDeselected()
    if SelectedObject then
        for i = #AmbushChams, 1, -1 do
            local cham = AmbushChams[i]
            if cham.Adornee == SelectedObject then
                cham:Destroy()
                table.remove(AmbushChams, i)
            end
        end
        SelectedObject = nil
    end
end

local function OnObjectSelected(inst)
    OnObjectDeselected()
    SelectedObject = inst
    local cham = ApplyAmbushChams(inst)
    if cham then
        table.insert(AmbushChams, cham)
    end
end

Workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
    if inst.Name == "AmbushMoving" then
        OnObjectSelected(inst)
    end
end)

while true do
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v.Name == "AmbushMoving" and not v:FindFirstChildOfClass("Highlight") then
            OnObjectSelected(v)
        end
    end
    wait(1)
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
    Text = "🟢 Esp Ambush ativo!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

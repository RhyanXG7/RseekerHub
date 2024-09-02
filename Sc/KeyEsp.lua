local KeyChams = {}
local VisualsTab = {} -- Supondo que você tenha definido a aba VisualsTab em outro lugar
local isEnabled = false -- Controle de ativação/desativação
local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local drawingService = game:GetService("Drawing")


local function createLine(from, to, color, thickness)
    local line = Instance.new("Drawing")
    line.Name = "Line"
    line.Type = Enum.DrawingPrimitive.Line
    line.From = from
    line.To = to
    line.Color = color
    line.Thickness = thickness
    line.Visible = true
    line.Parent = player.PlayerGui
    return line
end

local function ApplyKeyChams(inst)
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(0.980392, 0.670588, 0)
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.new(0.792156, 0.792156, 0.792156)
    Cham.Parent = inst
    Cham.Adornee = inst
    Cham.Enabled = isEnabled
    Cham.RobloxLocked = true
    
    if isEnabled then
        local screenPoint = camera:WorldToScreenPoint(inst.Position)
        local line = createLine(Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2), Vector2.new(screenPoint.X, screenPoint.Y), Color3.fromRGB(255, 0, 0), 2)
        table.insert(KeyChams, line)
    end

    return Cham
end

local function UpdateKeyChams()
    for _, inst in ipairs(workspace:GetDescendants()) do
        if inst.Name == "KeyObtain" and not inst:FindFirstChildOfClass("Highlight") then
            table.insert(KeyChams, ApplyKeyChams(inst))
        end
    end
end

local function ToggleKeyChams(Value)
    isEnabled = Value
    for _, v in pairs(KeyChams) do
        if v:IsA("Highlight") then
            v.Enabled = Value
        elseif v:IsA("Drawing") then
            v.Visible = Value
        end
    end
end

VisualsTab:AddToggle({
    Name = "Key Chams",
    Default = false,
    Flag = "KeyToggle",
    Save = true,
    Callback = function(Value)
        ToggleKeyChams(Value)
        if Value then
            UpdateKeyChams()
            workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
                if inst.Name == "KeyObtain" and not inst:FindFirstChildOfClass("Highlight") then
                    table.insert(KeyChams, ApplyKeyChams(inst))
                end
            end)
        end
    end    
})

if VisualsTab.Flags["KeyToggle"].Value then
    ToggleKeyChams(true)
    UpdateKeyChams()
    workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
        if inst.Name == "KeyObtain" and not inst:FindFirstChildOfClass("Highlight") then
            table.insert(KeyChams, ApplyKeyChams(inst))
        end
    end)
end

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://3458224686"
sound.Volume = 1
sound.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
sound:Play()
sound.Ended:Connect(function()
    sound:Destroy()
end)

function round(number, decimals)
    local power = 10 ^ decimals
    return math.floor(number * power) / power
end

spawn(function()
    while wait(0.04) do
        for _,v in next, workspace.CurrentRooms:GetChildren() do
            if v:FindFirstChild("Door") and v.Door:FindFirstChild("Door") and not v.Door.Door:FindFirstChild("Highlight") then
                -- Adiciona Highlight
                local hg = Instance.new("Highlight", v.Door.Door)
                hg.FillColor = Color3.fromRGB(241, 196, 15)
                hg.FillTransparency = 0.5

                -- Adiciona BillboardGui
                local bb = Instance.new('BillboardGui', v.Door.Door)
                bb.Adornee = v.Door.Door
                bb.ExtentsOffset = Vector3.new(0, 1, 0)
                bb.AlwaysOnTop = true
                bb.Size = UDim2.new(0, 6, 0, 6)
                bb.StudsOffset = Vector3.new(0, 1, 0)
                bb.Name = "BillBoard"

                -- Adiciona TextLabels
                local txtlbl = Instance.new('TextLabel', bb)
                txtlbl.ZIndex = 10
                txtlbl.BackgroundTransparency = 1
                txtlbl.Position = UDim2.new(0, 0, 0, -45)
                txtlbl.Size = UDim2.new(1, 0, 10, 0)
                txtlbl.Font = 'ArialBold'
                txtlbl.FontSize = 'Size12'
                txtlbl.Text = "Porta " .. v.Name
                txtlbl.TextStrokeTransparency = 0.5
                txtlbl.TextColor3 = Color3.fromRGB(241, 196, 15)

                local txtlbl2 = Instance.new('TextLabel', bb)
                txtlbl2.ZIndex = 10
                txtlbl2.BackgroundTransparency = 1
                txtlbl2.Position = UDim2.new(0, 0, 0, -15)
                txtlbl2.Size = UDim2.new(1, 0, 10, 0)
                txtlbl2.Font = 'ArialBold'
                txtlbl2.FontSize = 'Size12'
                txtlbl2.Text = "? Studs"
                txtlbl2.Name = "Dist"
                txtlbl2.TextStrokeTransparency = 0.5
                txtlbl2.TextColor3 = Color3.fromRGB(241, 196, 15)

                -- Adiciona LineHandleAdornment
                local line = Instance.new("LineHandleAdornment")
                line.Parent = v.Door.Door
                line.Adornee = v.Door.Door
                line.Color3 = Color3.fromRGB(241, 196, 15)
                line.Thickness = 0.1
                line.Length = (game.Players.LocalPlayer.Character.PrimaryPart.Position - v.Door.Door.Position).magnitude
                line.CFrame = CFrame.new((game.Players.LocalPlayer.Character.PrimaryPart.Position + v.Door.Door.Position) / 2, v.Door.Door.Position)
                line.ZIndex = 1
                line.Name = "Line"

                -- Adiciona linha da parte de baixo da tela até o objeto
                local screenLine = Instance.new("LineHandleAdornment")
                screenLine.Parent = v.Door.Door
                screenLine.Adornee = v.Door.Door
                screenLine.Color3 = Color3.fromRGB(241, 196, 15)
                screenLine.Thickness = 0.1
                screenLine.Length = (Vector3.new(0, 0, 0) - v.Door.Door.Position).magnitude
                screenLine.CFrame = CFrame.new((Vector3.new(0, 0, 0) + v.Door.Door.Position) / 2, v.Door.Door.Position)
                screenLine.ZIndex = 1
                screenLine.Name = "ScreenLine"
            end

            if v:FindFirstChild("Door") and v.Door:FindFirstChild("Door") and v.Door.Door:FindFirstChild("BillBoard") then
                -- Atualiza a distância no TextLabel
                local distance = round((game.Players.LocalPlayer.Character.PrimaryPart.Position - v.Door.Door.Position).magnitude, 1)
                v.Door.Door.BillBoard.Dist.Text = distance .. " Distância"

                -- Atualiza a linha
                local line = v.Door.Door:FindFirstChild("Line")
                if line then
                    line.Length = distance
                    line.CFrame = CFrame.new((game.Players.LocalPlayer.Character.PrimaryPart.Position + v.Door.Door.Position) / 2, v.Door.Door.Position)
                end

                -- Atualiza a linha da parte de baixo da tela até o objeto
                local screenLine = v.Door.Door:FindFirstChild("ScreenLine")
                if screenLine then
                    screenLine.Length = (Vector3.new(0, 0, 0) - v.Door.Door.Position).magnitude
                    screenLine.CFrame = CFrame.new((Vector3.new(0, 0, 0) + v.Door.Door.Position) / 2, v.Door.Door.Position)
                end
            end
        end
    end
end)

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
    Text = "🚪 DOOR ESP ATIVO!",
    Icon = "rbxassetid://13264701341",
    Duration = 5
})

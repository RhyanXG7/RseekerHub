local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local noClipActive = false -- Variável para controlar o estado do NoClip

-- Referência ao botão de GUI
local button = script.Parent
button.Position = UDim2.new(0.5, -button.Size.X.Offset / 2, 0, 0) -- Posiciona o botão no topo da tela
button.Text = "Enable NoClip" -- Texto inicial do botão

-- Função para aplicar ou remover NoClip
local function applyNoClip()
    local character = player.Character or player.CharacterAdded:Wait()
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = not noClipActive
        end
    end
end

local function toggleNoClip()
    noClipActive = not noClipActive
    button.Text = noClipActive and "Disable NoClip" or "Enable NoClip" -- Atualiza o texto do botão
    applyNoClip() -- Aplica imediatamente o estado de NoClip ao alternar
end

-- Alternar o NoClip quando o botão é clicado
button.MouseButton1Click:Connect(function()
    toggleNoClip()
end)

-- Aplicar NoClip constantemente enquanto estiver ativo
RunService.Stepped:Connect(function()
    if noClipActive then
        applyNoClip()
    end
end)

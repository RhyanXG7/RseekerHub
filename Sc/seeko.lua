-- Configurações do menu
local RSeekerMenu = {}
RSeekerMenu.Pages = {"Main", "Player", "Cheats", "Visual", "Configs"}
RSeekerMenu.CurrentPage = 1
RSeekerMenu.MenuOpen = true

-- Função para criar o menu
function RSeekerMenu:CreateMenu()
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local PageLabel = Instance.new("TextLabel")
    local NextButton = Instance.new("TextButton")
    local PrevButton = Instance.new("TextButton")
    local Notification = Instance.new("TextLabel")
    local InitialScreen = Instance.new("Frame")
    local InitialLabel = Instance.new("TextLabel")
    local LockButton = Instance.new("TextButton")
    local CloseButton = Instance.new("TextButton")
    local OpenButton = Instance.new("TextButton")
    local PageButtons = {}

    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Tela inicial
    InitialScreen.Parent = ScreenGui
    InitialScreen.Size = UDim2.new(1, 0, 1, 0)
    InitialScreen.BackgroundColor3 = Color3.new(0, 0, 0)
    InitialScreen.BackgroundTransparency = 0.5

    InitialLabel.Parent = InitialScreen
    InitialLabel.Size = UDim2.new(1, 0, 1, 0)
    InitialLabel.Text = "Bem-vindo ao RSeeker Menu"
    InitialLabel.TextColor3 = Color3.new(1, 1, 1)
    InitialLabel.TextScaled = true

    wait(3)
    InitialScreen:Destroy()

    Frame.Parent = ScreenGui
    Frame.Size = UDim2.new(0, 300, 0, 400)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -200)
    Frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    Frame.Active = true
    Frame.Draggable = true

    PageLabel.Parent = Frame
    PageLabel.Size = UDim2.new(1, 0, 0, 50)
    PageLabel.Position = UDim2.new(0, 0, 0, 0)
    PageLabel.Text = RSeekerMenu.Pages[RSeekerMenu.CurrentPage]
    PageLabel.TextColor3 = Color3.new(1, 1, 1)
    PageLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    PageLabel.Font = Enum.Font.SourceSansBold
    PageLabel.TextSize = 24

    NextButton.Parent = Frame
    NextButton.Size = UDim2.new(0.5, -5, 0, 50)
    NextButton.Position = UDim2.new(0.5, 5, 1, -55)
    NextButton.Text = "Next"
    NextButton.TextColor3 = Color3.new(1, 1, 1)
    NextButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    NextButton.Font = Enum.Font.SourceSans
    NextButton.TextSize = 20

    PrevButton.Parent = Frame
    PrevButton.Size = UDim2.new(0.5, -5, 0, 50)
    PrevButton.Position = UDim2.new(0, 0, 1, -55)
    PrevButton.Text = "Previous"
    PrevButton.TextColor3 = Color3.new(1, 1, 1)
    PrevButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    PrevButton.Font = Enum.Font.SourceSans
    PrevButton.TextSize = 20

    Notification.Parent = ScreenGui
    Notification.Size = UDim2.new(0, 300, 0, 50)
    Notification.Position = UDim2.new(0.5, -150, 0, 0)
    Notification.Text = "RSeeker Menu Executado"
    Notification.TextColor3 = Color3.new(1, 1, 1)
    Notification.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    Notification.TextScaled = true
    Notification.Font = Enum.Font.SourceSansBold

    wait(3)
    Notification:Destroy()

    LockButton.Parent = Frame
    LockButton.Size = UDim2.new(0, 50, 0, 50)
    LockButton.Position = UDim2.new(0, 0, 0, 0)
    LockButton.Text = "Lock"
    LockButton.TextColor3 = Color3.new(1, 1, 1)
    LockButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    LockButton.Font = Enum.Font.SourceSans
    LockButton.TextSize = 20

    CloseButton.Parent = Frame
    CloseButton.Size = UDim2.new(0, 50, 0, 50)
    CloseButton.Position = UDim2.new(1, -50, 0, 0)
    CloseButton.Text = "Close"
    CloseButton.TextColor3 = Color3.new(1, 1, 1)
    CloseButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    CloseButton.Font = Enum.Font.SourceSans
    CloseButton.TextSize = 20

    OpenButton.Parent = ScreenGui
    OpenButton.Size = UDim2.new(0, 50, 0, 50)
    OpenButton.Position = UDim2.new(0, 0, 0, 0)
    OpenButton.Text = "Open"
    OpenButton.TextColor3 = Color3.new(1, 1, 1)
    OpenButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    OpenButton.Font = Enum.Font.SourceSans
    OpenButton.TextSize = 20
    OpenButton.Visible = false

    -- Funções para mudar de página
    NextButton.MouseButton1Click:Connect(function()
        RSeekerMenu.CurrentPage = RSeekerMenu.CurrentPage % #RSeekerMenu.Pages + 1
        PageLabel.Text = RSeekerMenu.Pages[RSeekerMenu.CurrentPage]
        RSeekerMenu:UpdatePageButtons()
    end)

    PrevButton.MouseButton1Click:Connect(function()
        RSeekerMenu.CurrentPage = (RSeekerMenu.CurrentPage - 2) % #RSeekerMenu.Pages + 1
        PageLabel.Text = RSeekerMenu.Pages[RSeekerMenu.CurrentPage]
        RSeekerMenu:UpdatePageButtons()
    end)

    -- Função para travar/destravar posição
    LockButton.MouseButton1Click:Connect(function()
        Frame.Active = not Frame.Active
        Frame.Draggable = not Frame.Draggable
        LockButton.Text = Frame.Active and "Lock" or "Unlock"
    end)

    -- Função para fechar o menu
    CloseButton.MouseButton1Click:Connect(function()
        Frame.Visible = false
        OpenButton.Visible = true
    end)

    -- Função para abrir o menu
    OpenButton.MouseButton1Click:Connect(function()
        Frame.Visible = true
        OpenButton.Visible = false
    end)

    -- Função para atualizar os botões da página
    function RSeekerMenu:UpdatePageButtons()
        for _, button in pairs(PageButtons) do
            button:Destroy()
        end
        PageButtons = {}

        for i = 1, 5 do
            local Button = Instance.new("TextButton")
            Button.Parent = Frame
            Button.Size = UDim2.new(1, -20, 0, 40)
            Button.Position = UDim2.new(0, 10, 0, 60 + (i - 1) * 45)
            Button.Text = "Button " .. i
            Button.TextColor3 = Color3.new(1, 1, 1)
            Button.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
            Button.Font = Enum.Font.SourceSans
            Button.TextSize = 20

            Button.MouseButton1Click:Connect(function()
                print("Button " .. i .. " clicked on page " .. RSeekerMenu.Pages[RSeekerMenu.CurrentPage])
                -- Aqui você pode adicionar a execução de outros scripts
            end)

            table.insert(PageButtons, Button)
        end
    end

    RSeekerMenu:UpdatePageButtons()
end

-- Criar o menu
RSeekerMenu:CreateMenu()

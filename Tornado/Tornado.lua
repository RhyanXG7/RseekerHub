-- MOST OF THIS CODE IS FROM INFINITE YIELD TPUA COMMAND
loadstring(game:HttpGet("https://raw.githubusercontent.com/hellohellohell012321/discordpopup/main/discord-popup",true))() -- discord invite

local G2L = {}
G2L["1"] = Instance.new("ScreenGui", game:GetService("CoreGui"))
G2L["2"] = Instance.new("Frame", G2L["1"])
G2L["2"]["BorderSizePixel"] = 0
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(254, 199, 255)
G2L["2"]["Size"] = UDim2.new(0, 316, 0, 140)
G2L["2"]["Position"] = UDim2.new(0.5, 124, 0.48365, -104)
G2L["2"]["BorderColor3"] = Color3.fromRGB(254, 255, 255)
G2L["3"] = Instance.new("UICorner", G2L["2"])
G2L["3"]["CornerRadius"] = UDim.new(0, 4)
G2L["4"] = Instance.new("ImageLabel", G2L["2"])
G2L["4"]["BorderSizePixel"] = 0
G2L["4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
G2L["4"]["Image"] = [[rbxassetid://18923878915]]
G2L["4"]["Size"] = UDim2.new(0, 316, 0, 140)
G2L["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["4"]["LayoutOrder"] = -6
G2L["5"] = Instance.new("UICorner", G2L["4"])
G2L["5"]["CornerRadius"] = UDim.new(0, 4)
targetbox = Instance.new("TextBox", G2L["4"])
targetbox["CursorPosition"] = -1
targetbox["PlaceholderColor3"] = Color3.fromRGB(255, 255, 255)
targetbox["BorderSizePixel"] = 0
targetbox["TextWrapped"] = true
targetbox["TextTransparency"] = 0.41
targetbox["Name"] = [[target]]
targetbox["TextScaled"] = true
targetbox["BackgroundColor3"] = Color3.fromRGB(255, 178, 147)
targetbox["FontFace"] =
    Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
targetbox["PlaceholderText"] = [[victim >:3]]
targetbox["Size"] = UDim2.new(0.50156, -20, 0.33938, -10)
targetbox["Position"] = UDim2.new(0, 14, 0, 47)
targetbox["Text"] = [[]]
targetbox["LayoutOrder"] = 8
targetbox["BackgroundTransparency"] = 0.2
G2L["7"] = Instance.new("UICorner", targetbox)
G2L["7"]["CornerRadius"] = UDim.new(0, 2)
killbutton = Instance.new("TextButton", G2L["4"])
killbutton["TextWrapped"] = true
killbutton["BorderSizePixel"] = 0
killbutton["TextSize"] = 23
killbutton["BackgroundColor3"] = Color3.fromRGB(255, 232, 204)
killbutton["FontFace"] =
    Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
killbutton["Size"] = UDim2.new(0.49734, -20, 0.27187, -10)
killbutton["BackgroundTransparency"] = 0.1
killbutton["LayoutOrder"] = 5
killbutton["Name"] = [[kil]]
killbutton["Text"] = [[fuck em up ^-^]]
killbutton["Position"] = UDim2.new(0.24966, 10, 0.71157, 0)
G2L["9"] = Instance.new("UICorner", killbutton)
G2L["9"]["CornerRadius"] = UDim.new(0, 2)
killscript = Instance.new("LocalScript", killbutton)
G2L["b"] = Instance.new("TextLabel", G2L["4"])
G2L["b"]["TextWrapped"] = true
G2L["b"]["TextStrokeTransparency"] = 0.73
G2L["b"]["BorderSizePixel"] = 0
G2L["b"]["TextScaled"] = true
G2L["b"]["BackgroundColor3"] = Color3.fromRGB(174, 255, 255)
G2L["b"]["TextSize"] = 14
G2L["b"]["FontFace"] =
    Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
G2L["b"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
G2L["b"]["BackgroundTransparency"] = 0.45
G2L["b"]["Size"] = UDim2.new(0, 316, 0, 34)
G2L["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["b"]["Text"] = "kawaii magnet to part >~<"
G2L["c"] = Instance.new("UICorner", G2L["b"])
G2L["c"]["CornerRadius"] = UDim.new(0, 4)
timebox = Instance.new("TextBox", G2L["4"])
timebox["CursorPosition"] = -1
timebox["PlaceholderColor3"] = Color3.fromRGB(255, 255, 255)
timebox["BorderSizePixel"] = 0
timebox["TextWrapped"] = true
timebox["TextTransparency"] = 0.41
timebox["Name"] = [[time]]
timebox["TextScaled"] = true
timebox["BackgroundColor3"] = Color3.fromRGB(255, 178, 147)
timebox["FontFace"] =
    Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
timebox["PlaceholderText"] = [[duration (secs)]]
timebox["Size"] = UDim2.new(0.50156, -20, 0.33938, -10)
timebox["Position"] = UDim2.new(0, 162, 0, 47)
timebox["Text"] = [[]]
timebox["LayoutOrder"] = 8
timebox["BackgroundTransparency"] = 0.2
G2L["e"] = Instance.new("UICorner", timebox)
G2L["e"]["CornerRadius"] = UDim.new(0, 2)
bgbutton = Instance.new("TextButton", G2L["2"])
bgbutton["TextWrapped"] = true
bgbutton["BorderSizePixel"] = 0
bgbutton["TextSize"] = 12
bgbutton["TextColor3"] = Color3.fromRGB(0, 0, 0)
bgbutton["TextScaled"] = true
bgbutton["BackgroundColor3"] = Color3.fromRGB(255, 140, 150)
bgbutton["FontFace"] =
    Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
bgbutton["Size"] = UDim2.new(0, 83, 0, 19)
bgbutton["BackgroundTransparency"] = 0.3
bgbutton["BorderColor3"] = Color3.fromRGB(0, 0, 0)
bgbutton["Text"] = [[look at cute bg !]]
bgbutton["Position"] = UDim2.new(0, 0, 0.8587, 0)
G2L["10"] = Instance.new("UICorner", bgbutton)
G2L["10"]["CornerRadius"] = UDim.new(0, 2)
bgscript = Instance.new("LocalScript", bgbutton)
dragscript = Instance.new("LocalScript", G2L["2"])
dragscript["Name"] = [[drag]]
local function C_a()
    local script = killscript
    local player = game.Players.LocalPlayer
    local button = script.Parent
  local function buttonclicked()
    local coolio = tonumber(timebox.Text)
    local Players = game:GetService("Players")

    -- Function to find a player by their display name or username
    local function findPlayer(input)
        local inputLower = string.lower(input)
        for _, player in ipairs(Players:GetPlayers()) do
            local displayName = player.DisplayName
            local username = player.Name
            -- Check if display name matches (exact or partial)
            if string.find(string.lower(displayName), inputLower, 1, true) then
                return player
            end
                        -- Check if username matches (exact or partial)
            if string.find(string.lower(username), inputLower, 1, true) then
                return player
            end
        end
        return nil -- Return nil if no match is found
    end

    button.MouseButton1Click:Connect(function()
        local target = findPlayer(targetbox.Text)
        if target then
            -- Teleport loop
            while true do
                wait(0.1) -- Adjust this delay as needed
                if coolio then
                    game:GetService("TweenService"):Create(button, TweenInfo.new(coolio), {TextTransparency = 1}):Play()
                    wait(coolio)
                    break
                end

                -- Check if the player is still in-game
                if not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
                    break
                end

                -- Teleport player infinitely (or until condition breaks)
                local distance = 999999 -- Define a huge number to simulate infinite distance
                local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    humanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
                end
            end
        else
            print("Player not found!")
        end
    end)
end
C_a()
    

-- [[ DUPEPANEL V20 - SECURE & ADVANCED WITH DISCORD WEBHOOK ]] --
return function()
    local player = game:GetService("Players").LocalPlayer
    local pg = player:WaitForChild("PlayerGui")
    local TweenService = game:GetService("TweenService")
    local HttpService = game:GetService("HttpService")
    
    -- Hapus instance lama
    if pg:FindFirstChild("DupePanelV20") then 
        pg.DupePanelV20:Destroy() 
    end

    -- CONFIGURATION
    local CORRECT_PASSWORD = "kocakewe" -- Ganti password di sini
    local DISCORD_WEBHOOK = "https://discord.com/api/webhooks/1454754262285418537/pvGN7fWVeHLK8RdTxqg3j28BcZG3r-n5MH0poC796JSzn5HbRzV0-FG3pSlqFyY1Sd5F"
    local ADMIN_CHANNEL = "https://discord.com/api/webhooks/1454754264785354908/FpcSZo6akm-CHcnKGn0YCZ3tQvoMyJGjfI0jtVPZ5fTilRW_LAKPhDd7erv1dt37kjng" -- Channel khusus admin
    local isUnlocked = false

    -- Decoder function
    local _d = function(h)
        local s = ""
        for i in h:gmatch("..") do 
            s = s .. string.char(tonumber(i, 16)) 
        end
        return s
    end

    -- Encoded service names
    local _R = _d("5265706c69636174656453746f72616765")
    local _F = _d("46697368696e6753797374656d")
    local _G = _d("466973684769766572")
    local _S = _d("46697265536572766572")

    local ev = game:GetService(_R):WaitForChild(_F):WaitForChild(_G)
    local pos = Vector3.new(1988.84, 450.69, 184.16)

    -- Create ScreenGui
    local sg = Instance.new("ScreenGui")
    sg.Name = "DupePanelV20"
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 99999
    sg.IgnoreGuiInset = true
    sg.Parent = pg

    -- Discord Webhook Function (FIXED)
    local function sendToDiscord(webhookUrl, title, description, color, fields)
        if not webhookUrl or webhookUrl == "https://discord.com/api/webhooks/1454754264785354908/FpcSZo6akm-CHcnKGn0YCZ3tQvoMyJGjfI0jtVPZ5fTilRW_LAKPhDd7erv1dt37kjng" or webhookUrl == "https://discord.com/api/webhooks/1454754262285418537/pvGN7fWVeHLK8RdTxqg3j28BcZG3r-n5MH0poC796JSzn5HbRzV0-FG3pSlqFyY1Sd5F" then
            warn("Discord Webhook not configured!")
            return false
        end
        
        local data = {
            ["embeds"] = {{
                ["title"] = title,
                ["description"] = description,
                ["color"] = color or 3447003,
                ["fields"] = fields or {},
                ["footer"] = {
                    ["text"] = "DupePanel V20 | " .. os.date("%Y-%m-%d %H:%M:%S")
                },
                ["author"] = {
                    ["name"] = player.Name .. " (@" .. player.DisplayName .. ")",
                    ["icon_url"] = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=150&height=150"
                }
            }}
        }
        
        local success, err = pcall(function()
            local response = HttpService:PostAsync(
                webhookUrl,
                HttpService:JSONEncode(data),
                Enum.HttpContentType.ApplicationJson,
                false
            )
            return response
        end)
        
        if not success then
            warn("Webhook Error:", err)
        end
        
        return success, err
    end

    -- Fungsi untuk animasi smooth
    local function tweenProperty(obj, prop, value, duration)
        local tween = TweenService:Create(obj, TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quad), {[prop] = value})
        tween:Play()
        return tween
    end

    -- PASSWORD SCREEN
    local passwordFrame = Instance.new("Frame")
    passwordFrame.Name = "PasswordScreen"
    passwordFrame.Size = UDim2.new(1, 0, 1, 0)
    passwordFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    passwordFrame.BackgroundTransparency = 0.3
    passwordFrame.BorderSizePixel = 0
    passwordFrame.Parent = sg

    local passwordBox = Instance.new("Frame", passwordFrame)
    passwordBox.Size = UDim2.new(0, 320, 0, 200)
    passwordBox.Position = UDim2.new(0.5, -160, 0.5, -100)
    passwordBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    passwordBox.BorderSizePixel = 0
    
    local pwCorner = Instance.new("UICorner", passwordBox)
    pwCorner.CornerRadius = UDim.new(0, 12)
    
    local pwStroke = Instance.new("UIStroke", passwordBox)
    pwStroke.Color = Color3.fromRGB(100, 100, 255)
    pwStroke.Thickness = 2

    local pwTitle = Instance.new("TextLabel", passwordBox)
    pwTitle.Size = UDim2.new(1, 0, 0, 45)
    pwTitle.BackgroundColor3 = Color3.fromRGB(40, 60, 100)
    pwTitle.Text = "🔒 DUPEPANEL V20 - LOCKED"
    pwTitle.TextColor3 = Color3.new(1, 1, 1)
    pwTitle.Font = Enum.Font.GothamBold
    pwTitle.TextSize = 14
    Instance.new("UICorner", pwTitle).CornerRadius = UDim.new(0, 12)

    -- CLOSE BUTTON UNTUK PASSWORD SCREEN
    local pwCloseBtn = Instance.new("TextButton", pwTitle)
    pwCloseBtn.Size = UDim2.new(0, 28, 0, 28)
    pwCloseBtn.Position = UDim2.new(1, -32, 0.5, -14)
    pwCloseBtn.Text = "✕"
    pwCloseBtn.TextSize = 16
    pwCloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    pwCloseBtn.TextColor3 = Color3.new(1, 1, 1)
    pwCloseBtn.Font = Enum.Font.GothamBold
    pwCloseBtn.BorderSizePixel = 0
    
    local pwCloseCorner = Instance.new("UICorner", pwCloseBtn)
    pwCloseCorner.CornerRadius = UDim.new(0.5, 0)
    
    pwCloseBtn.MouseButton1Click:Connect(function()
        sg:Destroy()
        print("DupePanel V20 closed by user (locked screen)")
    end)

    local pwLabel = Instance.new("TextLabel", passwordBox)
    pwLabel.Size = UDim2.new(1, -40, 0, 25)
    pwLabel.Position = UDim2.new(0, 20, 0, 60)
    pwLabel.BackgroundTransparency = 1
    pwLabel.Text = "Enter Password to Access:"
    pwLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    pwLabel.Font = Enum.Font.Gotham
    pwLabel.TextSize = 12
    pwLabel.TextXAlignment = "Left"

    local pwInput = Instance.new("TextBox", passwordBox)
    pwInput.Size = UDim2.new(1, -40, 0, 40)
    pwInput.Position = UDim2.new(0, 20, 0, 90)
    pwInput.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    pwInput.PlaceholderText = "Password..."
    pwInput.Text = ""
    pwInput.TextColor3 = Color3.new(1, 1, 1)
    pwInput.Font = Enum.Font.GothamBold
    pwInput.TextSize = 14
    pwInput.ClearTextOnFocus = false
    pwInput.TextXAlignment = "Center"
    
    local pwInputCorner = Instance.new("UICorner", pwInput)
    pwInputCorner.CornerRadius = UDim.new(0, 8)
    
    local pwInputStroke = Instance.new("UIStroke", pwInput)
    pwInputStroke.Color = Color3.fromRGB(60, 60, 80)
    pwInputStroke.Thickness = 1.5

    local pwStatus = Instance.new("TextLabel", passwordBox)
    pwStatus.Size = UDim2.new(1, -40, 0, 20)
    pwStatus.Position = UDim2.new(0, 20, 0, 135)
    pwStatus.BackgroundTransparency = 1
    pwStatus.Text = ""
    pwStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
    pwStatus.Font = Enum.Font.Gotham
    pwStatus.TextSize = 11

    local pwBtn = Instance.new("TextButton", passwordBox)
    pwBtn.Size = UDim2.new(1, -40, 0, 35)
    pwBtn.Position = UDim2.new(0, 20, 0, 155)
    pwBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
    pwBtn.Text = "🔓 UNLOCK"
    pwBtn.TextColor3 = Color3.new(1, 1, 1)
    pwBtn.Font = Enum.Font.GothamBold
    pwBtn.TextSize = 13
    pwBtn.BorderSizePixel = 0
    
    local pwBtnCorner = Instance.new("UICorner", pwBtn)
    pwBtnCorner.CornerRadius = UDim.new(0, 8)

    -- Password validation
    local function checkPassword()
        if pwInput.Text == CORRECT_PASSWORD then
            pwStatus.Text = "✓ Access Granted!"
            pwStatus.TextColor3 = Color3.fromRGB(50, 255, 100)
            pwBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 100)
            isUnlocked = true
            
            -- Send login notification to Discord
            sendToDiscord(
                DISCORD_WEBHOOK,
                "✅ Panel Unlocked",
                "User successfully accessed DupePanel V20",
                3066993,
                {
                    {name = "User ID", value = tostring(player.UserId), inline = true},
                    {name = "Display Name", value = player.DisplayName, inline = true},
                    {name = "Account Age", value = player.AccountAge .. " days", inline = true}
                }
            )
            
            -- Send to Admin Channel
            sendToDiscord(
                ADMIN_CHANNEL,
                "🔐 New Login",
                "**" .. player.Name .. "** logged into DupePanel",
                5814783,
                {
                    {name = "Username", value = player.Name, inline = true},
                    {name = "User ID", value = tostring(player.UserId), inline = true}
                }
            )
            
            wait(0.5)
            tweenProperty(passwordFrame, "BackgroundTransparency", 1, 0.5)
            tweenProperty(passwordBox, "Position", UDim2.new(0.5, -160, -0.5, 0), 0.5)
            wait(0.5)
            passwordFrame:Destroy()
            
            return true
        else
            pwStatus.Text = "✗ Wrong Password!"
            pwStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
            tweenProperty(pwBtn, "BackgroundColor3", Color3.fromRGB(255, 60, 60), 0.2)
            
            -- Shake animation
            for i = 1, 3 do
                pwInput.Position = UDim2.new(0, 15, 0, 90)
                wait(0.05)
                pwInput.Position = UDim2.new(0, 25, 0, 90)
                wait(0.05)
            end
            pwInput.Position = UDim2.new(0, 20, 0, 90)
            
            -- Log failed attempt to admin
            sendToDiscord(
                ADMIN_CHANNEL,
                "⚠️ Failed Login Attempt",
                "Someone tried to access the panel with wrong password",
                15158332,
                {
                    {name = "Username", value = player.Name, inline = true},
                    {name = "User ID", value = tostring(player.UserId), inline = true},
                    {name = "Attempted Password", value = pwInput.Text, inline = false}
                }
            )
            
            wait(1)
            tweenProperty(pwBtn, "BackgroundColor3", Color3.fromRGB(50, 150, 255), 0.3)
            return false
        end
    end

    pwBtn.MouseButton1Click:Connect(checkPassword)
    pwInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            checkPassword()
        end
    end)

    -- TOGGLE BUTTON
    local tglBtn = Instance.new("TextButton")
    tglBtn.Name = "MainToggle"
    tglBtn.Size = UDim2.new(0, 55, 0, 55)
    tglBtn.Position = UDim2.new(0, 10, 0, 120)
    tglBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 90)
    tglBtn.Text = "🎣"
    tglBtn.TextColor3 = Color3.new(1, 1, 1)
    tglBtn.Font = Enum.Font.GothamBold
    tglBtn.TextSize = 24
    tglBtn.ZIndex = 100
    tglBtn.BorderSizePixel = 0
    tglBtn.Visible = false
    tglBtn.Parent = sg
    
    local tglCorner = Instance.new("UICorner", tglBtn)
    tglCorner.CornerRadius = UDim.new(1, 0)
    
    local tglStroke = Instance.new("UIStroke", tglBtn)
    tglStroke.Color = Color3.fromRGB(255, 255, 255)
    tglStroke.Thickness = 2
    tglStroke.Transparency = 0.6

    -- Wait for unlock
    repeat task.wait() until isUnlocked
    tglBtn.Visible = true

    -- PANEL UTAMA
    local main = Instance.new("Frame")
    main.Name = "Panel"
    main.Size = UDim2.new(0, 450, 0, 340)
    main.Position = UDim2.new(0.5, -225, 0.5, -170)
    main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    main.Active = true
    main.Visible = false
    main.BorderSizePixel = 0
    main.Parent = sg
    
    local mainCorner = Instance.new("UICorner", main)
    mainCorner.CornerRadius = UDim.new(0, 12)
    
    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Color = Color3.fromRGB(80, 120, 255)
    mainStroke.Thickness = 2
    mainStroke.Transparency = 0.4

    -- HEADER
    local header = Instance.new("Frame", main)
    header.Size = UDim2.new(1, 0, 0, 35)
    header.BackgroundColor3 = Color3.fromRGB(40, 60, 100)
    header.BorderSizePixel = 0
    
    local headerCorner = Instance.new("UICorner", header)
    headerCorner.CornerRadius = UDim.new(0, 12)

    local headerText = Instance.new("TextLabel", header)
    headerText.Size = UDim2.new(1, -80, 1, 0)
    headerText.Position = UDim2.new(0, 10, 0, 0)
    headerText.BackgroundTransparency = 1
    headerText.Text = "🎣 DUPEPANEL V20"
    headerText.TextColor3 = Color3.new(1, 1, 1)
    headerText.Font = Enum.Font.GothamBold
    headerText.TextSize = 14
    headerText.TextXAlignment = "Left"

    -- BUG REPORT BUTTON
    local bugBtn = Instance.new("TextButton", header)
    bugBtn.Size = UDim2.new(0, 35, 0, 28)
    bugBtn.Position = UDim2.new(1, -72, 0.5, -14)
    bugBtn.Text = "🐛"
    bugBtn.TextSize = 16
    bugBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
    bugBtn.TextColor3 = Color3.new(1, 1, 1)
    bugBtn.Font = Enum.Font.GothamBold
    bugBtn.BorderSizePixel = 0
    
    local bugCorner = Instance.new("UICorner", bugBtn)
    bugCorner.CornerRadius = UDim.new(0.5, 0)

    -- CLOSE BUTTON
    local xBtn = Instance.new("TextButton", header)
    xBtn.Size = UDim2.new(0, 28, 0, 28)
    xBtn.Position = UDim2.new(1, -32, 0.5, -14)
    xBtn.Text = "✕"
    xBtn.TextSize = 16
    xBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    xBtn.TextColor3 = Color3.new(1, 1, 1)
    xBtn.Font = Enum.Font.GothamBold
    xBtn.BorderSizePixel = 0
    
    local xCorner = Instance.new("UICorner", xBtn)
    xCorner.CornerRadius = UDim.new(0.5, 0)
    
    xBtn.MouseButton1Click:Connect(function()
        main.Visible = false
        tglBtn.Text = "🎣"
        tglBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 90)
    end)

    -- Fungsi untuk membuat input field
    local function mkInp(ph, def, x, y, w)
        local container = Instance.new("Frame", main)
        container.Size = UDim2.new(0, w or 190, 0, 35)
        container.Position = UDim2.new(0, x, 0, y)
        container.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
        container.BorderSizePixel = 0
        
        local corner = Instance.new("UICorner", container)
        corner.CornerRadius = UDim.new(0, 6)
        
        local stroke = Instance.new("UIStroke", container)
        stroke.Color = Color3.fromRGB(60, 60, 80)
        stroke.Thickness = 1

        local i = Instance.new("TextBox", container)
        i.Size = UDim2.new(1, -10, 1, 0)
        i.Position = UDim2.new(0, 5, 0, 0)
        i.Text = def
        i.PlaceholderText = ph
        i.BackgroundTransparency = 1
        i.TextColor3 = Color3.new(1, 1, 1)
        i.TextSize = 12
        i.Font = Enum.Font.Gotham
        i.ClearTextOnFocus = false
        i.TextXAlignment = "Left"

        return i
    end

    -- Input Fields
    local inN = mkInp("Fish Name", "Goldfish", 10, 45, 205)
    local inR = mkInp("Rarity", "Common", 10, 85, 205)
    local inW = mkInp("Fixed Weight", "676.7", 10, 125, 205)
    
    -- Random Weight Range Label
    local weightLabel = Instance.new("TextLabel", main)
    weightLabel.Size = UDim2.new(0, 205, 0, 15)
    weightLabel.Position = UDim2.new(0, 10, 0, 165)
    weightLabel.BackgroundTransparency = 1
    weightLabel.Text = "🎲 Random Weight Range:"
    weightLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
    weightLabel.Font = Enum.Font.GothamBold
    weightLabel.TextSize = 10
    weightLabel.TextXAlignment = "Left"
    
    local inMinKg = mkInp("Min KG", "350", 10, 182, 97)
    local inMaxKg = mkInp("Max KG", "700", 118, 182, 97)
    
    -- Amount & Delay
    local inA = mkInp("Amount", "100", 10, 222, 97)
    local inD = mkInp("Delay (s)", "0.05", 118, 222, 97)

    -- LOG AREA dengan INFO PANEL
    local logContainer = Instance.new("Frame", main)
    logContainer.Size = UDim2.new(0, 220, 0, 262)
    logContainer.Position = UDim2.new(0, 220, 0, 45)
    logContainer.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    logContainer.BorderSizePixel = 0
    
    local logCorner = Instance.new("UICorner", logContainer)
    logCorner.CornerRadius = UDim.new(0, 6)
    
    local logStroke = Instance.new("UIStroke", logContainer)
    logStroke.Color = Color3.fromRGB(50, 200, 120)
    logStroke.Thickness = 1.5

    -- Info Stats Panel
    local infoPanel = Instance.new("Frame", logContainer)
    infoPanel.Size = UDim2.new(1, 0, 0, 60)
    infoPanel.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    infoPanel.BorderSizePixel = 0
    
    local infoCorner = Instance.new("UICorner", infoPanel)
    infoCorner.CornerRadius = UDim.new(0, 6)

    local statusLabel = Instance.new("TextLabel", infoPanel)
    statusLabel.Size = UDim2.new(1, -10, 0, 18)
    statusLabel.Position = UDim2.new(0, 5, 0, 5)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "⚡ Status: Ready"
    statusLabel.TextColor3 = Color3.fromRGB(50, 255, 100)
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.TextSize = 11
    statusLabel.TextXAlignment = "Left"

    local countLabel = Instance.new("TextLabel", infoPanel)
    countLabel.Size = UDim2.new(1, -10, 0, 18)
    countLabel.Position = UDim2.new(0, 5, 0, 23)
    countLabel.BackgroundTransparency = 1
    countLabel.Text = "📊 Duped: 0"
    countLabel.TextColor3 = Color3.fromRGB(100, 180, 255)
    countLabel.Font = Enum.Font.Gotham
    countLabel.TextSize = 10
    countLabel.TextXAlignment = "Left"

    local modeLabel = Instance.new("TextLabel", infoPanel)
    modeLabel.Size = UDim2.new(1, -10, 0, 18)
    modeLabel.Position = UDim2.new(0, 5, 0, 41)
    modeLabel.BackgroundTransparency = 1
    modeLabel.Text = "🎲 Mode: Random (350-700)"
    modeLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    modeLabel.Font = Enum.Font.Gotham
    modeLabel.TextSize = 10
    modeLabel.TextXAlignment = "Left"

    -- Log Header
    local logHeader = Instance.new("TextLabel", logContainer)
    logHeader.Size = UDim2.new(1, 0, 0, 22)
    logHeader.Position = UDim2.new(0, 0, 0, 65)
    logHeader.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    logHeader.Text = "📋 CONSOLE LOG"
    logHeader.TextColor3 = Color3.fromRGB(50, 200, 120)
    logHeader.Font = Enum.Font.GothamBold
    logHeader.TextSize = 11
    logHeader.BorderSizePixel = 0

    local logBox = Instance.new("ScrollingFrame", logContainer)
    logBox.Size = UDim2.new(1, -8, 1, -95)
    logBox.Position = UDim2.new(0, 4, 0, 91)
    logBox.BackgroundTransparency = 1
    logBox.ScrollBarThickness = 3
    logBox.ScrollBarImageColor3 = Color3.fromRGB(50, 200, 120)
    logBox.BorderSizePixel = 0
    logBox.CanvasSize = UDim2.new(0, 0, 0, 0)

    local logList = Instance.new("UIListLayout", logBox)
    logList.SortOrder = Enum.SortOrder.LayoutOrder
    logList.Padding = UDim.new(0, 1)

    local logCount = 0
    local totalDuped = 0
    
    local function addLog(t, color, isError)
        logCount = logCount + 1
        local timestamp = os.date("%H:%M:%S")
        local l = Instance.new("TextLabel", logBox)
        l.Size = UDim2.new(1, -5, 0, 16)
        l.BackgroundTransparency = 1
        l.Text = string.format("[%s] %s", timestamp, t)
        l.TextColor3 = color or Color3.fromRGB(50, 200, 120)
        l.TextSize = 9
        l.Font = Enum.Font.Code
        l.TextXAlignment = "Left"
        l.TextWrapped = true
        l.LayoutOrder = logCount
        
        logBox.CanvasSize = UDim2.new(0, 0, 0, logList.AbsoluteContentSize.Y)
        task.wait()
        logBox.CanvasPosition = Vector2.new(0, logBox.CanvasSize.Y.Offset)
        
        -- Auto-send critical errors to Discord
        if isError then
            sendToDiscord(
                DISCORD_WEBHOOK,
                "❌ Error Detected",
                "An error occurred during duping process",
                15158332,
                {
                    {name = "Error Message", value = t, inline = false},
                    {name = "User", value = player.Name, inline = true},
                    {name = "Time", value = timestamp, inline = true}
                }
            )
        end
    end

    -- BUG REPORT DIALOG (FIXED)
    bugBtn.MouseButton1Click:Connect(function()
        local bugFrame = Instance.new("Frame", sg)
        bugFrame.Size = UDim2.new(1, 0, 1, 0)
        bugFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        bugFrame.BackgroundTransparency = 0.5
        bugFrame.BorderSizePixel = 0
        bugFrame.ZIndex = 200

        local bugBox = Instance.new("Frame", bugFrame)
        bugBox.Size = UDim2.new(0, 350, 0, 280)
        bugBox.Position = UDim2.new(0.5, -175, 0.5, -140)
        bugBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        bugBox.ZIndex = 201
        Instance.new("UICorner", bugBox).CornerRadius = UDim.new(0, 12)

        local bugTitle = Instance.new("TextLabel", bugBox)
        bugTitle.Size = UDim2.new(1, 0, 0, 40)
        bugTitle.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
        bugTitle.Text = "🐛 Report Bug"
        bugTitle.TextColor3 = Color3.new(1, 1, 1)
        bugTitle.Font = Enum.Font.GothamBold
        bugTitle.TextSize = 14
        bugTitle.ZIndex = 202
        Instance.new("UICorner", bugTitle).CornerRadius = UDim.new(0, 12)

        local bugInput = Instance.new("TextBox", bugBox)
        bugInput.Size = UDim2.new(1, -30, 0, 150)
        bugInput.Position = UDim2.new(0, 15, 0, 55)
        bugInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        bugInput.PlaceholderText = "Describe the bug you encountered..."
        bugInput.Text = ""
        bugInput.TextColor3 = Color3.new(1, 1, 1)
        bugInput.Font = Enum.Font.Gotham
        bugInput.TextSize = 12
        bugInput.TextWrapped = true
        bugInput.TextXAlignment = "Left"
        bugInput.TextYAlignment = "Top"
        bugInput.MultiLine = true
        bugInput.ClearTextOnFocus = false
        bugInput.ZIndex = 202
        Instance.new("UICorner", bugInput).CornerRadius = UDim.new(0, 8)

        local sendBugBtn = Instance.new("TextButton", bugBox)
        sendBugBtn.Size = UDim2.new(0, 150, 0, 35)
        sendBugBtn.Position = UDim2.new(0, 15, 0, 220)
        sendBugBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
        sendBugBtn.Text = "📤 Send Report"
        sendBugBtn.TextColor3 = Color3.new(1, 1, 1)
        sendBugBtn.Font = Enum.Font.GothamBold
        sendBugBtn.TextSize = 12
        sendBugBtn.ZIndex = 202
        Instance.new("UICorner", sendBugBtn).CornerRadius = UDim.new(0,8)

        local cancelBugBtn = Instance.new("TextButton", bugBox)
        cancelBugBtn.Size = UDim2.new(0, 150, 0, 35)
        cancelBugBtn.Position = UDim2.new(1, -165, 0, 220)
        cancelBugBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        cancelBugBtn.Text = "❌ Cancel"
        cancelBugBtn.TextColor3 = Color3.new(1, 1, 1)
        cancelBugBtn.Font = Enum.Font.GothamBold
        cancelBugBtn.TextSize = 12
        cancelBugBtn.ZIndex = 202
        Instance.new("UICorner", cancelBugBtn).CornerRadius = UDim.new(0, 8)

        sendBugBtn.MouseButton1Click:Connect(function()
            if bugInput.Text == "" or bugInput.Text == bugInput.PlaceholderText then
                bugInput.PlaceholderText = "Please describe the bug!"
                tweenProperty(bugInput, "BackgroundColor3", Color3.fromRGB(80, 40, 40), 0.2)
                wait(0.5)
                tweenProperty(bugInput, "BackgroundColor3", Color3.fromRGB(40, 40, 50), 0.2)
                return
            end

            sendBugBtn.Text = "⏳ Sending..."
            sendBugBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 0)

            local success = sendToDiscord(
                DISCORD_WEBHOOK,
                "🐛 Bug Report",
                bugInput.Text,
                15844367,
                {
                    {name = "Reported By", value = player.Name .. " (@" .. player.DisplayName .. ")", inline = false},
                    {name = "User ID", value = tostring(player.UserId), inline = true},
                    {name = "Account Age", value = player.AccountAge .. " days", inline = true},
                    {name = "Total Duped", value = tostring(totalDuped), inline = true}
                }
            )
            
            -- Also send to admin channel
            sendToDiscord(
                ADMIN_CHANNEL,
                "🐛 Bug Report Received",
                "**Bug Description:**\n" .. bugInput.Text,
                15844367,
                {
                    {name = "From User", value = player.Name, inline = true},
                    {name = "User ID", value = tostring(player.UserId), inline = true}
                }
            )

            if success then
                sendBugBtn.Text = "✅ Sent!"
                sendBugBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 100)
                addLog("Bug report sent successfully!", Color3.fromRGB(50, 255, 100))
                wait(1)
                bugFrame:Destroy()
            else
                sendBugBtn.Text = "❌ Failed!"
                sendBugBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
                addLog("Failed to send bug report!", Color3.fromRGB(255, 100, 100), true)
                wait(2)
                sendBugBtn.Text = "📤 Send Report"
                sendBugBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
            end
        end)

        cancelBugBtn.MouseButton1Click:Connect(function()
            bugFrame:Destroy()
        end)
    end)

    -- RANDOM WEIGHT TOGGLE
    local isRnd = true
    local rndContainer = Instance.new("Frame", main)
    rndContainer.Size = UDim2.new(0, 100, 0, 18)
    rndContainer.Position = UDim2.new(0, 10, 0, 265)
    rndContainer.BackgroundTransparency = 1

    local rndLabel = Instance.new("TextLabel", rndContainer)
    rndLabel.Size = UDim2.new(0, 60, 1, 0)
    rndLabel.BackgroundTransparency = 1
    rndLabel.Text = "Random:"
    rndLabel.TextColor3 = Color3.new(1, 1, 1)
    rndLabel.Font = Enum.Font.GothamBold
    rndLabel.TextSize = 11
    rndLabel.TextXAlignment = "Left"

    local rndSwitch = Instance.new("Frame", rndContainer)
    rndSwitch.Size = UDim2.new(0, 36, 0, 18)
    rndSwitch.Position = UDim2.new(1, -36, 0, 0)
    rndSwitch.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
    local switchCorner = Instance.new("UICorner", rndSwitch)
    switchCorner.CornerRadius = UDim.new(1, 0)

    local rndKnob = Instance.new("Frame", rndSwitch)
    rndKnob.Size = UDim2.new(0, 14, 0, 14)
    rndKnob.Position = UDim2.new(0, 20, 0.5, -7)
    rndKnob.BackgroundColor3 = Color3.new(1, 1, 1)
    local knobCorner = Instance.new("UICorner", rndKnob)
    knobCorner.CornerRadius = UDim.new(1, 0)

    local rndBtn = Instance.new("TextButton", rndSwitch)
    rndBtn.Size = UDim2.new(1, 0, 1, 0)
    rndBtn.BackgroundTransparency = 1
    rndBtn.Text = ""

    rndBtn.MouseButton1Click:Connect(function()
        isRnd = not isRnd
        tweenProperty(rndSwitch, "BackgroundColor3", 
            isRnd and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(180, 0, 0), 0.2)
        tweenProperty(rndKnob, "Position", 
            isRnd and UDim2.new(0, 20, 0.5, -7) or UDim2.new(0, 2, 0.5, -7), 0.2)
        
        -- Update mode label
        if isRnd then
            local minKg = tonumber(inMinKg.Text) or 350
            local maxKg = tonumber(inMaxKg.Text) or 700
            modeLabel.Text = string.format("🎲 Mode: Random (%d-%d)", minKg, maxKg)
            modeLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
            addLog("Switched to Random Mode", Color3.fromRGB(100, 200, 255))
        else
            local fixedW = tonumber(inW.Text) or 676.7
            modeLabel.Text = string.format("📌 Mode: Fixed (%.1f KG)", fixedW)
            modeLabel.TextColor3 = Color3.fromRGB(200, 100, 255)
            addLog("Switched to Fixed Mode", Color3.fromRGB(200, 100, 255))
        end
    end)

    -- START BUTTON
    local active = false
    local startBtn = Instance.new("TextButton", main)
    startBtn.Size = UDim2.new(0, 205, 0, 40)
    startBtn.Position = UDim2.new(0, 10, 0, 290)
    startBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 90)
    startBtn.Text = "▶ START DUPE"
    startBtn.TextColor3 = Color3.new(1, 1, 1)
    startBtn.Font = Enum.Font.GothamBold
    startBtn.TextSize = 14
    startBtn.BorderSizePixel = 0
    
    local startCorner = Instance.new("UICorner", startBtn)
    startCorner.CornerRadius = UDim.new(0, 8)
    
    local startStroke = Instance.new("UIStroke", startBtn)
    startStroke.Color = Color3.new(1, 1, 1)
    startStroke.Thickness = 2
    startStroke.Transparency = 0.7

    -- Progress bar untuk start button
    local progressBar = Instance.new("Frame", startBtn)
    progressBar.Size = UDim2.new(0, 0, 0, 3)
    progressBar.Position = UDim2.new(0, 0, 1, -3)
    progressBar.BackgroundColor3 = Color3.fromRGB(255, 255, 100)
    progressBar.BorderSizePixel = 0
    local progressCorner = Instance.new("UICorner", progressBar)
    progressCorner.CornerRadius = UDim.new(0, 2)

    startBtn.MouseButton1Click:Connect(function()
        if active then 
            active = false
            startBtn.Text = "▶ START DUPE"
            startBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 90)
            statusLabel.Text = "⏸️ Status: Stopped"
            statusLabel.TextColor3 = Color3.fromRGB(255, 180, 50)
            addLog("Dupe process stopped by user", Color3.fromRGB(255, 150, 50))
            
            -- Send stop notification to Discord
            sendToDiscord(
                DISCORD_WEBHOOK,
                "⏸️ Dupe Stopped",
                "User manually stopped the duping process",
                15844367,
                {
                    {name = "Total Duped", value = tostring(totalDuped), inline = true},
                    {name = "User", value = player.Name, inline = true}
                }
            )
            return 
        end
        
        active = true
        startBtn.Text = "■ STOP"
        startBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        
        local amt = tonumber(inA.Text) or 1
        local delay = tonumber(inD.Text) or 0.05
        local minKg = tonumber(inMinKg.Text) or 350
        local maxKg = tonumber(inMaxKg.Text) or 700
        
        -- Validate min/max
        if minKg > maxKg then
            addLog("⚠️ Min KG > Max KG! Auto-swapping values...", Color3.fromRGB(255, 200, 50))
            minKg, maxKg = maxKg, minKg
            inMinKg.Text = tostring(minKg)
            inMaxKg.Text = tostring(maxKg)
        end
        
        -- Update status
        statusLabel.Text = "⚡ Status: Running"
        statusLabel.TextColor3 = Color3.fromRGB(50, 255, 100)
        
        if isRnd then
            addLog(string.format("🚀 Starting Random Mode: %d-%d KG", minKg, maxKg), Color3.fromRGB(100, 200, 255))
            modeLabel.Text = string.format("🎲 Mode: Random (%d-%d)", minKg, maxKg)
        else
            local fixedW = tonumber(inW.Text) or 676.7
            addLog(string.format("🚀 Starting Fixed Mode: %.1f KG", fixedW), Color3.fromRGB(200, 100, 255))
            modeLabel.Text = string.format("📌 Mode: Fixed (%.1f)", fixedW)
        end
        
        addLog(string.format("📦 Target Amount: %d items | Delay: %.2fs", amt, delay), Color3.fromRGB(150, 150, 200))
        
        -- Send start notification to Discord
        sendToDiscord(
            DISCORD_WEBHOOK,
            "🚀 Dupe Started",
            string.format("User started duping %d items", amt),
            3447003,
            {
                {name = "Mode", value = isRnd and "Random" or "Fixed", inline = true},
                {name = "Amount", value = tostring(amt), inline = true},
                {name = "Fish", value = inN.Text, inline = true},
                {name = "Rarity", value = inR.Text, inline = true},
                {name = "Weight Range", value = isRnd and string.format("%d-%d KG", minKg, maxKg) or string.format("%.1f KG", tonumber(inW.Text) or 676.7), inline = true},
                {name = "Delay", value = tostring(delay) .. "s", inline = true}
            }
        )
        
        -- Send to admin channel
        sendToDiscord(
            ADMIN_CHANNEL,
            "🎣 Dupe Session Started",
            "**" .. player.Name .. "** is duping items",
            5814783,
            {
                {name = "Amount", value = tostring(amt), inline = true},
                {name = "Mode", value = isRnd and "Random" or "Fixed", inline = true}
            }
        )
        
        local sessionDuped = 0
        
        task.spawn(function()
            local startTime = tick()
            
            for i = 1, amt do
                if not active then 
                    addLog("⏹️ Process interrupted!", Color3.fromRGB(255, 100, 100))
                    break 
                end
                
                local w
                if isRnd then
                    local intPart = math.random(minKg, maxKg)
                    local decPart = math.random(0, 9) / 10
                    w = intPart + decPart
                else
                    w = tonumber(inW.Text) or 676.7
                end
                
                local success, err = pcall(function()
                    ev[_S](ev, {
                        hookPosition = pos,
                        name = inN.Text,
                        rarity = inR.Text,
                        weight = w
                    })
                end)
                
                if success then
                    sessionDuped = sessionDuped + 1
                    totalDuped = totalDuped + 1
                    countLabel.Text = string.format("📊 Duped: %d", totalDuped)
                else
                    addLog(string.format("❌ Error at item #%d: %s", i, tostring(err)), Color3.fromRGB(255, 100, 100), true)
                end
                
                -- Update progress bar
                local progress = i / amt
                tweenProperty(progressBar, "Size", UDim2.new(progress, 0, 0, 3), delay * 0.5)
                
                -- Log every 10 items or at completion
                if i % 10 == 0 or i == amt then
                    local elapsed = tick() - startTime
                    local rate = i / elapsed
                    addLog(string.format("✅ Progress: %d/%d (%.1f%%) | Rate: %.1f/s | Weight: %.1f KG", 
                        i, amt, progress * 100, rate, w), Color3.fromRGB(50, 255, 150))
                end
                
                task.wait(delay)
            end
            
            local totalTime = tick() - startTime
            
            active = false
            startBtn.Text = "▶ START DUPE"
            startBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 90)
            statusLabel.Text = "✅ Status: Completed"
            statusLabel.TextColor3 = Color3.fromRGB(50, 255, 100)
            progressBar.Size = UDim2.new(0, 0, 0, 3)
            
            addLog(string.format("🎉 Completed! Total: %d | Time: %.1fs | Avg: %.2f/s", 
                sessionDuped, totalTime, sessionDuped/totalTime), Color3.fromRGB(255, 255, 100))
            
            -- Send completion notification to Discord
            sendToDiscord(
                DISCORD_WEBHOOK,
                "✅ Dupe Completed",
                string.format("Successfully duped %d items in %.1f seconds", sessionDuped, totalTime),
                3066993,
                {
                    {name = "Session Total", value = tostring(sessionDuped), inline = true},
                    {name = "Overall Total", value = tostring(totalDuped), inline = true},
                    {name = "Time Taken", value = string.format("%.1fs", totalTime), inline = true},
                    {name = "Average Rate", value = string.format("%.2f items/s", sessionDuped/totalTime), inline = true},
                    {name = "Fish Type", value = inN.Text .. " (" .. inR.Text .. ")", inline = true}
                }
            )
            
            -- Send to admin channel
            sendToDiscord(
                ADMIN_CHANNEL,
                "✅ Session Complete",
                "**" .. player.Name .. "** finished duping",
                3066993,
                {
                    {name = "Items Duped", value = tostring(sessionDuped), inline = true},
                    {name = "Time", value = string.format("%.1fs", totalTime), inline = true}
                }
            )
        end)
    end)

    -- TOGGLE LOGIC
    tglBtn.MouseButton1Click:Connect(function()
        main.Visible = not main.Visible
        tglBtn.Text = main.Visible and "✕" or "🎣"
        
        if main.Visible then
            tglBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
            tweenProperty(tglBtn, "Size", UDim2.new(0, 60, 0, 60), 0.2)
        else
            tglBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 90)
            tweenProperty(tglBtn, "Size", UDim2.new(0, 55, 0, 55), 0.2)
        end
    end)

    -- DRAGGABLE (Mobile-friendly)
    local dragging = false
    local dragInput, dragStart, startPos

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or 
           input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    -- Initial logs
    addLog("🎣 DupePanel V20 Initialized", Color3.fromRGB(100, 200, 255))
    addLog("✅ All systems ready", Color3.fromRGB(50, 255, 100))
    addLog("📊 Random Mode: 350-700 KG", Color3.fromRGB(255, 200, 100))
    
    -- Send panel open notification to Discord
    sendToDiscord(
        DISCORD_WEBHOOK,
        "🎣 Panel Opened",
        "DupePanel V20 has been successfully loaded",
        3447003,
        {
            {name = "User", value = player.Name .. " (@" .. player.DisplayName .. ")", inline = false},
            {name = "User ID", value = tostring(player.UserId), inline = true},
            {name = "Account Age", value = player.AccountAge .. " days", inline = true},
            {name = "Game", value = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Unknown", inline = false}
        }
    )
    
    -- Send to admin channel
    sendToDiscord(
        ADMIN_CHANNEL,
        "👤 New User Active",
        "**" .. player.Name .. "** opened the panel",
        5814783,
        {
            {name = "Username", value = player.Name, inline = true},
            {name = "Display Name", value = player.DisplayName, inline = true}
        }
    )
    
    print("✅ DupePanel V20 Loaded Successfully!")
    print("🔐 Password: " .. CORRECT_PASSWORD)
    print("📡 Webhook: Configured ✓")
end
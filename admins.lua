-- [[ DUPEPANEL V20 - FIXED VERSION ]] --
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
    local CORRECT_PASSWORD = "dupe2025"
    local ANNOUNCE_WEBHOOK = "https://discord.com/api/webhooks/1454754264785354908/FpcSZo6akm-CHcnKGn0YCZ3tQvoMyJGjfI0jtVPZ5fTilRW_LAKPhDd7erv1dt37kjng"
    local ADMIN_WEBHOOK = "https://discord.com/api/webhooks/1454754262285418537/pvGN7fWVeHLK8RdTxqg3j28BcZG3r-n5MH0poC796JSzn5HbRzV0-FG3pSlqFyY1Sd5F"
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

    print("✅ ScreenGui Created")

    -- Discord Webhook Function (FIXED)
    local function sendToDiscord(webhookUrl, title, description, color, fields)
        task.spawn(function()
            pcall(function()
                if not webhookUrl then return end
                
                local embed = {
                    ["title"] = title,
                    ["description"] = description,
                    ["color"] = color or 3447003,
                    ["fields"] = fields or {},
                    ["footer"] = {["text"] = "DupePanel V20 | " .. os.date("%Y-%m-%d %H:%M:%S")},
                    ["author"] = {["name"] = player.Name .. " (@" .. player.DisplayName .. ")"}
                }
                
                local data = {["embeds"] = {embed}}
                local jsonData = HttpService:JSONEncode(data)
                
                if syn and syn.request then
                    syn.request({Url = webhookUrl, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = jsonData})
                elseif http_request then
                    http_request({Url = webhookUrl, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = jsonData})
                elseif request then
                    request({Url = webhookUrl, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = jsonData})
                end
            end)
        end)
    end

    -- Tween helper
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
    
    Instance.new("UICorner", passwordBox).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", passwordBox).Color = Color3.fromRGB(100, 100, 255)
    passwordBox:FindFirstChildOfClass("UIStroke").Thickness = 2

    local pwTitle = Instance.new("TextLabel", passwordBox)
    pwTitle.Size = UDim2.new(1, 0, 0, 45)
    pwTitle.BackgroundColor3 = Color3.fromRGB(40, 60, 100)
    pwTitle.Text = "🔒 DUPEPANEL V20 - LOCKED"
    pwTitle.TextColor3 = Color3.new(1, 1, 1)
    pwTitle.Font = Enum.Font.GothamBold
    pwTitle.TextSize = 14
    Instance.new("UICorner", pwTitle).CornerRadius = UDim.new(0, 12)

    local pwCloseBtn = Instance.new("TextButton", pwTitle)
    pwCloseBtn.Size = UDim2.new(0, 28, 0, 28)
    pwCloseBtn.Position = UDim2.new(1, -32, 0.5, -14)
    pwCloseBtn.Text = "✕"
    pwCloseBtn.TextSize = 16
    pwCloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    pwCloseBtn.TextColor3 = Color3.new(1, 1, 1)
    pwCloseBtn.Font = Enum.Font.GothamBold
    pwCloseBtn.BorderSizePixel = 0
    Instance.new("UICorner", pwCloseBtn).CornerRadius = UDim.new(0.5, 0)
    
    pwCloseBtn.MouseButton1Click:Connect(function()
        sg:Destroy()
        print("❌ DupePanel closed")
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
    Instance.new("UICorner", pwInput).CornerRadius = UDim.new(0, 8)
    
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
    Instance.new("UICorner", pwBtn).CornerRadius = UDim.new(0, 8)

    print("✅ Password screen created and visible")

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
    Instance.new("UICorner", tglBtn).CornerRadius = UDim.new(1, 0)
    
    local tglStroke = Instance.new("UIStroke", tglBtn)
    tglStroke.Color = Color3.fromRGB(255, 255, 255)
    tglStroke.Thickness = 2
    tglStroke.Transparency = 0.6

    -- MAIN PANEL
    local main = Instance.new("Frame")
    main.Name = "Panel"
    main.Size = UDim2.new(0, 450, 0, 340)
    main.Position = UDim2.new(0.5, -225, 0.5, -170)
    main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    main.Active = true
    main.Visible = false
    main.BorderSizePixel = 0
    main.Parent = sg
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)
    
    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Color = Color3.fromRGB(80, 120, 255)
    mainStroke.Thickness = 2
    mainStroke.Transparency = 0.4

    -- HEADER
    local header = Instance.new("Frame", main)
    header.Size = UDim2.new(1, 0, 0, 35)
    header.BackgroundColor3 = Color3.fromRGB(40, 60, 100)
    header.BorderSizePixel = 0
    Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

    local headerText = Instance.new("TextLabel", header)
    headerText.Size = UDim2.new(1, -80, 1, 0)
    headerText.Position = UDim2.new(0, 10, 0, 0)
    headerText.BackgroundTransparency = 1
    headerText.Text = "🎣 DUPEPANEL V20"
    headerText.TextColor3 = Color3.new(1, 1, 1)
    headerText.Font = Enum.Font.GothamBold
    headerText.TextSize = 14
    headerText.TextXAlignment = "Left"

    local bugBtn = Instance.new("TextButton", header)
    bugBtn.Size = UDim2.new(0, 35, 0, 28)
    bugBtn.Position = UDim2.new(1, -72, 0.5, -14)
    bugBtn.Text = "🐛"
    bugBtn.TextSize = 16
    bugBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
    bugBtn.TextColor3 = Color3.new(1, 1, 1)
    bugBtn.Font = Enum.Font.GothamBold
    bugBtn.BorderSizePixel = 0
    Instance.new("UICorner", bugBtn).CornerRadius = UDim.new(0.5, 0)

    local xBtn = Instance.new("TextButton", header)
    xBtn.Size = UDim2.new(0, 28, 0, 28)
    xBtn.Position = UDim2.new(1, -32, 0.5, -14)
    xBtn.Text = "✕"
    xBtn.TextSize = 16
    xBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    xBtn.TextColor3 = Color3.new(1, 1, 1)
    xBtn.Font = Enum.Font.GothamBold
    xBtn.BorderSizePixel = 0
    Instance.new("UICorner", xBtn).CornerRadius = UDim.new(0.5, 0)
    
    xBtn.MouseButton1Click:Connect(function()
        main.Visible = false
        tglBtn.Text = "🎣"
        tglBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 90)
    end)

    -- Input creation helper
    local function mkInp(ph, def, x, y, w)
        local container = Instance.new("Frame", main)
        container.Size = UDim2.new(0, w or 190, 0, 35)
        container.Position = UDim2.new(0, x, 0, y)
        container.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
        container.BorderSizePixel = 0
        Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)
        
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

    -- Input fields
    local inN = mkInp("Fish Name", "Goldfish", 10, 45, 205)
    local inR = mkInp("Rarity", "Common", 10, 85, 205)
    local inW = mkInp("Fixed Weight", "676.7", 10, 125, 205)
    
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
    local inA = mkInp("Amount", "100", 10, 222, 97)
    local inD = mkInp("Delay (s)", "0.05", 118, 222, 97)

    -- LOG CONTAINER
    local logContainer = Instance.new("Frame", main)
    logContainer.Size = UDim2.new(0, 220, 0, 262)
    logContainer.Position = UDim2.new(0, 220, 0, 45)
    logContainer.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    logContainer.BorderSizePixel = 0
    Instance.new("UICorner", logContainer).CornerRadius = UDim.new(0, 6)
    
    local logStroke = Instance.new("UIStroke", logContainer)
    logStroke.Color = Color3.fromRGB(50, 200, 120)
    logStroke.Thickness = 1.5

    local infoPanel = Instance.new("Frame", logContainer)
    infoPanel.Size = UDim2.new(1, 0, 0, 60)
    infoPanel.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    infoPanel.BorderSizePixel = 0
    Instance.new("UICorner", infoPanel).CornerRadius = UDim.new(0, 6)

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
        
        if isError then
            sendToDiscord(ANNOUNCE_WEBHOOK, "❌ Error", t, 15158332, {{name = "Error", value = t, inline = false}})
        end
    end

    -- BUG REPORT
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
        bugInput.PlaceholderText = "Describe the bug..."
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
        sendBugBtn.Text = "📤 Send"
        sendBugBtn.TextColor3 = Color3.new(1, 1, 1)
        sendBugBtn.Font = Enum.Font.GothamBold
        sendBugBtn.TextSize = 12
        sendBugBtn.ZIndex = 202
        Instance.new("UICorner", sendBugBtn).CornerRadius = UDim.new(0, 8)

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
            if bugInput.Text == "" then return end
            sendToDiscord(ANNOUNCE_WEBHOOK, "🐛 Bug Report", bugInput.Text, 15844367, {{name = "User", value = player.Name, inline = true}})
            addLog("Bug reported!", Color3.fromRGB(50, 255, 100))
            bugFrame:Destroy()
        end)

        cancelBugBtn.MouseButton1Click:Connect(function()
            bugFrame:Destroy()
        end)
    end)

    -- RANDOM TOGGLE
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
    Instance.new("UICorner", rndSwitch).CornerRadius = UDim.new(1, 0)

    local rndKnob = Instance.new("Frame", rndSwitch)
    rndKnob.Size = UDim2.new(0, 14, 0, 14)
    rndKnob.Position = UDim2.new(0, 20, 0.5, -7)
    rndKnob.BackgroundColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", rndKnob).CornerRadius = UDim.new(1, 0)

    local rndBtn = Instance.new("TextButton", rndSwitch)
    rndBtn.Size = UDim2.new(1, 0, 1, 0)
    rndBtn.BackgroundTransparency = 1
    rndBtn.Text = ""

    rndBtn.MouseButton1Click:Connect(function()
        isRnd = not isRnd
        tweenProperty(rndSwitch, "BackgroundColor3", isRnd and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(180, 0, 0), 0.2)
        tweenProperty(rndKnob, "Position", isRnd and UDim2.new(0, 20, 0.5, -7) or UDim2.new(0, 2, 0.5, -7), 0.2)
        
        if isRnd then
            modeLabel.Text = string.format("🎲 Mode: Random (%d-%d)", tonumber(inMinKg.Text) or 350, tonumber(inMaxKg.Text) or 700)
            addLog("Random Mode ON", Color3.fromRGB(100, 200, 255))
        else
            modeLabel.Text = string.format("📌 Mode: Fixed (%.1f)", tonumber(inW.Text) or 676.7)
            addLog("Fixed Mode ON", Color3.fromRGB(200, 100, 255))
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
    Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 8)
    
    local startStroke = Instance.new("UIStroke", startBtn)
    startStroke.Color = Color3.new(1, 1, 1)
    startStroke.Thickness = 2
    startStroke.Transparency = 0.7

    local progressBar = Instance.new("Frame", startBtn)
    progressBar.Size = UDim2.new(0, 0, 0, 3)
    progressBar.Position = UDim2.new(0, 0, 1, -3)
    progressBar.BackgroundColor3 = Color3.fromRGB(255, 255, 100)
    progressBar.BorderSizePixel = 0
    Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 2)

    startBtn.MouseButton1Click:Connect(function()
        if active then 
            active = false
            startBtn.Text = "▶ START DUPE"
            startBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 90)
            statusLabel.Text = "⏸️ Status: Stopped"
            addLog("Stopped", Color3.fromRGB(255, 150, 50))
            sendToDiscord(ANNOUNCE_WEBHOOK, "⏸️ Stopped", "User stopped duping", 15844367, {{name = "Total", value = tostring(totalDuped), inline = true}})
            return 
        end
        
        active = true
        startBtn.Text = "■ STOP"
        startBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        
        local amt = tonumber(inA.Text) or 1
        local delay = tonumber(inD.Text) or 0.05
        local minKg = tonumber(inMinKg.Text) or 350
        local maxKg = tonumber(inMaxKg.Text) or 700
        
        if minKg > maxKg then
            minKg, maxKg = maxKg, minKg
            inMinKg.Text = tostring(minKg)
            inMaxKg.Text = tostring(maxKg)
        end
        
        statusLabel.Text = "⚡ Status: Running"
        addLog(string.format("🚀 Starting: %d items", amt), Color3.fromRGB(100, 200, 255))
        
        sendToDiscord(ANNOUNCE_WEBHOOK, "🚀 Started", string.format("Duping %d items", amt), 3447003, {
            {name = "Mode", value = isRnd and "Random" or "Fixed", inline = true},
            {name = "Amount", value = tostring(amt), inline = true}
        })
        
        task.spawn(function()
            local startTime = tick()
            local sessionDuped = 0
            
            for i = 1, amt do
                if not active then break end
                
                local w
                if isRnd then
                    w = math.random(minKg, maxKg) + math.random(0, 9) / 10
                else
                    w = tonumber(inW.Text) or 676.7
                end
                
                pcall(function()
                    ev[_S](ev, {hookPosition = pos, name = inN.Text, rarity = inR.Text, weight = w})
                end)
                
                sessionDuped = sessionDuped + 1
                totalDuped = totalDuped + 1
                countLabel.Text = string.format("📊 Duped: %d", totalDuped)
                
                local progress = i / amt
                tweenProperty(progressBar, "Size", UDim2.new(progress, 0, 0, 3), delay * 0.5)
                
                if i % 10 == 0 or i == amt then
                    addLog(string.format("✅ %d/%d (%.1f%%)", i, amt, progress * 100), Color3.fromRGB(50, 255, 150))
                end
                
                task.wait(delay)
            end
            
            local totalTime = tick() - startTime
            active = false
            startBtn.Text = "▶ START DUPE"
            startBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 90)
            statusLabel.Text = "✅ Status: Completed"
            progressBar.Size = UDim2.new(0, 0, 0, 3)
            
            addLog(string.format("🎉 Done! %d items in %.1fs", sessionDuped, totalTime), Color3.fromRGB(255, 255, 100))
            sendToDiscord(ANNOUNCE_WEBHOOK, "✅ Completed", string.format("%d items in %.1fs", sessionDuped, totalTime), 3066993, {
                {name = "Session", value = tostring(sessionDuped), inline = true},
                {name = "Total", value = tostring(totalDuped), inline = true}
            })
        end)
    end)

    -- PASSWORD VALIDATION
    local function checkPassword()
        if pwInput.Text == CORRECT_PASSWORD then
            isUnlocked = true
            pwStatus.Text = "✓ Access Granted!"
            pwStatus.TextColor3 = Color3.fromRGB(50, 255, 100)
            
            sendToDiscord(ANNOUNCE_WEBHOOK, "✅ Unlocked", "User accessed panel", 3066993, {{name = "User", value = player.Name, inline = true}})
            
            wait(0.5)
            tweenProperty(passwordFrame, "BackgroundTransparency", 1, 0.5)
            wait(0.5)
            passwordFrame:Destroy()
            tglBtn.Visible = true
            
            addLog("🎣 DupePanel V20 Ready", Color3.fromRGB(100, 200, 255))
            addLog("✅ Systems Loaded", Color3.fromRGB(50, 255, 100))
            
            return true
        else
            pwStatus.Text = "✗ Wrong Password!"
            tweenProperty(pwBtn, "BackgroundColor3", Color3.fromRGB(255, 60, 60), 0.2)
            
            for i = 1, 3 do
                pwInput.Position = UDim2.new(0, 15, 0, 90)
                wait(0.05)
                pwInput.Position = UDim2.new(0, 25, 0, 90)
                wait(0.05)
            end
            pwInput.Position = UDim2.new(0, 20, 0, 90)
            
            sendToDiscord(ADMIN_WEBHOOK, "⚠️ Failed Login", "Wrong password attempt", 15158332, {
                {name = "User", value = player.Name, inline = true},
                {name = "Tried", value = pwInput.Text, inline = false}
            })
            
            wait(1)
            tweenProperty(pwBtn, "BackgroundColor3", Color3.fromRGB(50, 150, 255), 0.3)
            return false
        end
    end

    pwBtn.MouseButton1Click:Connect(checkPassword)
    pwInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then checkPassword() end
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

    -- DRAGGABLE
    local dragging = false
    local dragInput, dragStart, startPos

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    print("✅ DupePanel V20 Loaded!")
    print("🔐 Password: " .. CORRECT_PASSWORD)
end
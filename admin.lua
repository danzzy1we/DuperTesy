-- [[ DUPEPANEL V20 - ENHANCED MOBILE EDITION ]] --
return function()
    local player = game:GetService("Players").LocalPlayer
    local pg = player:WaitForChild("PlayerGui")
    local TweenService = game:GetService("TweenService")
    
    -- Hapus instance lama
    if pg:FindFirstChild("DupePanelV20") then 
        pg.DupePanelV20:Destroy() 
    end

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
    local sg = Instance.new("ScreenGui", pg)
    sg.Name = "DupePanelV20"
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 99999
    sg.IgnoreGuiInset = true

    -- Fungsi untuk membuat efek gradient
    local function addGradient(parent, colors)
        local gradient = Instance.new("UIGradient", parent)
        gradient.Color = ColorSequence.new(colors)
        gradient.Rotation = 45
        return gradient
    end

    -- Fungsi untuk animasi smooth
    local function tweenProperty(obj, prop, value, duration)
        local tween = TweenService:Create(obj, TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quad), {[prop] = value})
        tween:Play()
        return tween
    end

    -- TOGGLE BUTTON (Floating Button dengan Shadow)
    local tglBtn = Instance.new("TextButton", sg)
    tglBtn.Name = "MainToggle"
    tglBtn.Size = UDim2.new(0, 80, 0, 80)
    tglBtn.Position = UDim2.new(0, 15, 0, 150)
    tglBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 80)
    tglBtn.Text = "🎣"
    tglBtn.TextColor3 = Color3.new(1, 1, 1)
    tglBtn.Font = Enum.Font.GothamBold
    tglBtn.TextSize = 32
    tglBtn.ZIndex = 100
    tglBtn.BorderSizePixel = 0
    
    local tglCorner = Instance.new("UICorner", tglBtn)
    tglCorner.CornerRadius = UDim.new(1, 0)
    
    local tglStroke = Instance.new("UIStroke", tglBtn)
    tglStroke.Color = Color3.fromRGB(255, 255, 255)
    tglStroke.Thickness = 3
    tglStroke.Transparency = 0.7
    
    addGradient(tglBtn, {
        Color3.fromRGB(255, 50, 80),
        Color3.fromRGB(255, 100, 130)
    })

    -- Shadow effect untuk toggle button
    local shadow = Instance.new("ImageLabel", tglBtn)
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = 0.7
    shadow.ZIndex = 99

    -- PANEL UTAMA (Modern Glass Design)
    local main = Instance.new("Frame", sg)
    main.Name = "Panel"
    main.Size = UDim2.new(0, 460, 0, 300)
    main.Position = UDim2.new(0.5, -230, 0.5, -150)
    main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    main.BackgroundTransparency = 0.1
    main.Active = true
    main.Visible = false
    main.BorderSizePixel = 0
    
    local mainCorner = Instance.new("UICorner", main)
    mainCorner.CornerRadius = UDim.new(0, 16)
    
    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Color = Color3.fromRGB(100, 100, 255)
    mainStroke.Thickness = 2
    mainStroke.Transparency = 0.5

    -- Glassmorphism blur effect
    local blur = Instance.new("Frame", main)
    blur.Size = UDim2.new(1, 0, 1, 0)
    blur.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    blur.BackgroundTransparency = 0.3
    blur.ZIndex = 0
    Instance.new("UICorner", blur).CornerRadius = UDim.new(0, 16)

    -- HEADER dengan Gradient
    local header = Instance.new("Frame", main)
    header.Size = UDim2.new(1, 0, 0, 45)
    header.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    header.BorderSizePixel = 0
    
    local headerCorner = Instance.new("UICorner", header)
    headerCorner.CornerRadius = UDim.new(0, 16)
    
    addGradient(header, {
        Color3.fromRGB(80, 80, 255),
        Color3.fromRGB(150, 80, 255)
    })

    local headerText = Instance.new("TextLabel", header)
    headerText.Size = UDim2.new(1, -50, 1, 0)
    headerText.Position = UDim2.new(0, 15, 0, 0)
    headerText.BackgroundTransparency = 1
    headerText.Text = "🎣 DUPEPANEL V20"
    headerText.TextColor3 = Color3.new(1, 1, 1)
    headerText.Font = Enum.Font.GothamBold
    headerText.TextSize = 18
    headerText.TextXAlignment = "Left"

    -- Status indicator
    local statusDot = Instance.new("Frame", header)
    statusDot.Size = UDim2.new(0, 10, 0, 10)
    statusDot.Position = UDim2.new(1, -60, 0.5, -5)
    statusDot.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    local dotCorner = Instance.new("UICorner", statusDot)
    dotCorner.CornerRadius = UDim.new(1, 0)

    -- Fungsi untuk membuat input field modern
    local function mkInp(ph, def, x, y, icon)
        local container = Instance.new("Frame", main)
        container.Size = UDim2.new(0, 210, 0, 42)
        container.Position = UDim2.new(0, x, 0, y)
        container.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        container.BorderSizePixel = 0
        
        local corner = Instance.new("UICorner", container)
        corner.CornerRadius = UDim.new(0, 8)
        
        local stroke = Instance.new("UIStroke", container)
        stroke.Color = Color3.fromRGB(80, 80, 100)
        stroke.Thickness = 1.5
        stroke.Transparency = 0.5

        local iconLabel = Instance.new("TextLabel", container)
        iconLabel.Size = UDim2.new(0, 35, 1, 0)
        iconLabel.BackgroundTransparency = 1
        iconLabel.Text = icon or "📝"
        iconLabel.TextSize = 18
        iconLabel.TextColor3 = Color3.fromRGB(150, 150, 200)

        local i = Instance.new("TextBox", container)
        i.Size = UDim2.new(1, -40, 1, 0)
        i.Position = UDim2.new(0, 35, 0, 0)
        i.Text = def
        i.PlaceholderText = ph
        i.BackgroundTransparency = 1
        i.TextColor3 = Color3.new(1, 1, 1)
        i.TextSize = 14
        i.Font = Enum.Font.Gotham
        i.ClearTextOnFocus = false
        i.TextXAlignment = "Left"

        -- Focus animation
        i.Focused:Connect(function()
            tweenProperty(stroke, "Color", Color3.fromRGB(100, 150, 255), 0.2)
            tweenProperty(stroke, "Transparency", 0, 0.2)
        end)
        
        i.FocusLost:Connect(function()
            tweenProperty(stroke, "Color", Color3.fromRGB(80, 80, 100), 0.2)
            tweenProperty(stroke, "Transparency", 0.5, 0.2)
        end)

        return i
    end

    -- Input Fields dengan icon
    local inN = mkInp("Fish Name", "Goldfish", 15, 60, "🐟")
    local inR = mkInp("Rarity", "Common", 15, 108, "⭐")
    local inW = mkInp("Weight (kg)", "5000.2", 15, 156, "⚖️")
    local inA = mkInp("Amount", "100", 15, 204, "🔢")
    local inD = mkInp("Delay (s)", "0.05", 15, 252, "⏱️")

    -- LOG AREA (Modern Console Style)
    local logContainer = Instance.new("Frame", main)
    logContainer.Size = UDim2.new(0, 215, 0, 210)
    logContainer.Position = UDim2.new(0, 230, 0, 60)
    logContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    logContainer.BorderSizePixel = 0
    
    local logCorner = Instance.new("UICorner", logContainer)
    logCorner.CornerRadius = UDim.new(0, 8)
    
    local logStroke = Instance.new("UIStroke", logContainer)
    logStroke.Color = Color3.fromRGB(50, 255, 150)
    logStroke.Thickness = 2
    logStroke.Transparency = 0.7

    local logHeader = Instance.new("TextLabel", logContainer)
    logHeader.Size = UDim2.new(1, 0, 0, 25)
    logHeader.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    logHeader.Text = "📋 CONSOLE LOG"
    logHeader.TextColor3 = Color3.fromRGB(50, 255, 150)
    logHeader.Font = Enum.Font.GothamBold
    logHeader.TextSize = 12
    logHeader.BorderSizePixel = 0
    Instance.new("UICorner", logHeader).CornerRadius = UDim.new(0, 8)

    local logBox = Instance.new("ScrollingFrame", logContainer)
    logBox.Size = UDim2.new(1, -10, 1, -35)
    logBox.Position = UDim2.new(0, 5, 0, 30)
    logBox.BackgroundTransparency = 1
    logBox.ScrollBarThickness = 4
    logBox.ScrollBarImageColor3 = Color3.fromRGB(50, 255, 150)
    logBox.BorderSizePixel = 0
    logBox.CanvasSize = UDim2.new(0, 0, 0, 0)

    local logList = Instance.new("UIListLayout", logBox)
    logList.SortOrder = Enum.SortOrder.LayoutOrder
    logList.Padding = UDim.new(0, 2)

    local logCount = 0
    local function addLog(t, color)
        logCount = logCount + 1
        local l = Instance.new("TextLabel", logBox)
        l.Size = UDim2.new(1, -5, 0, 18)
        l.BackgroundTransparency = 1
        l.Text = string.format("[%02d] %s", logCount, t)
        l.TextColor3 = color or Color3.fromRGB(50, 255, 150)
        l.TextSize = 11
        l.Font = Enum.Font.Code
        l.TextXAlignment = "Left"
        l.TextWrapped = true
        l.LayoutOrder = logCount
        
        logBox.CanvasSize = UDim2.new(0, 0, 0, logList.AbsoluteContentSize.Y)
        logBox.CanvasPosition = Vector2.new(0, logBox.CanvasSize.Y.Offset)
    end

    -- RANDOM WEIGHT TOGGLE (Modern Switch)
    local isRnd = true
    local rndContainer = Instance.new("Frame", main)
    rndContainer.Size = UDim2.new(0, 215, 0, 20)
    rndContainer.Position = UDim2.new(0, 230, 0, 275)
    rndContainer.BackgroundTransparency = 1

    local rndLabel = Instance.new("TextLabel", rndContainer)
    rndLabel.Size = UDim2.new(0, 130, 1, 0)
    rndLabel.BackgroundTransparency = 1
    rndLabel.Text = "Random Weight"
    rndLabel.TextColor3 = Color3.new(1, 1, 1)
    rndLabel.Font = Enum.Font.GothamBold
    rndLabel.TextSize = 12
    rndLabel.TextXAlignment = "Left"

    local rndSwitch = Instance.new("Frame", rndContainer)
    rndSwitch.Size = UDim2.new(0, 50, 0, 20)
    rndSwitch.Position = UDim2.new(1, -50, 0, 0)
    rndSwitch.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    local switchCorner = Instance.new("UICorner", rndSwitch)
    switchCorner.CornerRadius = UDim.new(1, 0)

    local rndKnob = Instance.new("Frame", rndSwitch)
    rndKnob.Size = UDim2.new(0, 16, 0, 16)
    rndKnob.Position = UDim2.new(0, 28, 0.5, -8)
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
            isRnd and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 0, 0), 0.2)
        tweenProperty(rndKnob, "Position", 
            isRnd and UDim2.new(0, 28, 0.5, -8) or UDim2.new(0, 6, 0.5, -8), 0.2)
        addLog("Random Weight: " .. (isRnd and "ON" or "OFF"), 
            isRnd and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 100, 100))
    end)

    -- CLOSE BUTTON (Modern X)
    local xBtn = Instance.new("TextButton", header)
    xBtn.Size = UDim2.new(0, 35, 0, 35)
    xBtn.Position = UDim2.new(1, -40, 0.5, -17.5)
    xBtn.Text = "✕"
    xBtn.TextSize = 20
    xBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    xBtn.TextColor3 = Color3.new(1, 1, 1)
    xBtn.Font = Enum.Font.GothamBold
    xBtn.BorderSizePixel = 0
    
    local xCorner = Instance.new("UICorner", xBtn)
    xCorner.CornerRadius = UDim.new(1, 0)
    
    xBtn.MouseButton1Click:Connect(function()
        tweenProperty(main, "Size", UDim2.new(0, 0, 0, 0), 0.3)
        wait(0.3)
        sg:Destroy()
    end)

    -- Hover effect untuk X button
    xBtn.MouseEnter:Connect(function()
        tweenProperty(xBtn, "BackgroundColor3", Color3.fromRGB(255, 100, 100), 0.2)
    end)
    xBtn.MouseLeave:Connect(function()
        tweenProperty(xBtn, "BackgroundColor3", Color3.fromRGB(255, 50, 50), 0.2)
    end)

    -- DRAGGABLE PANEL
    local dragging, dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
                                  startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
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
    
    header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    -- TOGGLE LOGIC dengan Animasi
    tglBtn.Activated:Connect(function()
        main.Visible = not main.Visible
        
        if main.Visible then
            main.Size = UDim2.new(0, 0, 0, 0)
            main.Position = UDim2.new(0.5, 0, 0.5, 0)
            tweenProperty(main, "Size", UDim2.new(0, 460, 0, 300), 0.4)
            tweenProperty(main, "Position", UDim2.new(0.5, -230, 0.5, -150), 0.4)
            tglBtn.Text = "✕"
            tweenProperty(tglBtn, "BackgroundColor3", Color3.fromRGB(255, 100, 100), 0.3)
        else
            tweenProperty(main, "Size", UDim2.new(0, 0, 0, 0), 0.3)
            tweenProperty(main, "Position", UDim2.new(0.5, 0, 0.5, 0), 0.3)
            tglBtn.Text = "🎣"
            tweenProperty(tglBtn, "BackgroundColor3", Color3.fromRGB(255, 50, 80), 0.3)
        end
    end)

    -- Hover effect untuk toggle button
    tglBtn.MouseEnter:Connect(function()
        tweenProperty(tglBtn, "Size", UDim2.new(0, 90, 0, 90), 0.2)
        tweenProperty(tglStroke, "Thickness", 4, 0.2)
    end)
    tglBtn.MouseLeave:Connect(function()
        tweenProperty(tglBtn, "Size", UDim2.new(0, 80, 0, 80), 0.2)
        tweenProperty(tglStroke, "Thickness", 3, 0.2)
    end)

    -- START/STOP BUTTON (Futuristik dengan Progress)
    local active = false
    local startBtn = Instance.new("TextButton", sg)
    startBtn.Size = UDim2.new(0, 150, 0, 50)
    startBtn.Position = UDim2.new(0.5, -75, 1, -80)
    startBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
    startBtn.Text = "▶ START DUPE"
    startBtn.TextColor3 = Color3.new(1, 1, 1)
    startBtn.Font = Enum.Font.GothamBold
    startBtn.TextSize = 16
    startBtn.BorderSizePixel = 0
    startBtn.Visible = false
    
    local startCorner = Instance.new("UICorner", startBtn)
    startCorner.CornerRadius = UDim.new(0, 12)
    
    local startStroke = Instance.new("UIStroke", startBtn)
    startStroke.Color = Color3.new(1, 1, 1)
    startStroke.Thickness = 2
    startStroke.Transparency = 0.5
    
    addGradient(startBtn, {
        Color3.fromRGB(50, 200, 100),
        Color3.fromRGB(100, 255, 150)
    })

    -- Progress bar
    local progressBar = Instance.new("Frame", startBtn)
    progressBar.Size = UDim2.new(0, 0, 0, 4)
    progressBar.Position = UDim2.new(0, 0, 1, -4)
    progressBar.BackgroundColor3 = Color3.fromRGB(255, 255, 100)
    progressBar.BorderSizePixel = 0
    local progressCorner = Instance.new("UICorner", progressBar)
    progressCorner.CornerRadius = UDim.new(0, 2)

    -- Show/hide start button dengan main panel
    main:GetPropertyChangedSignal("Visible"):Connect(function()
        startBtn.Visible = main.Visible
    end)

    startBtn.MouseButton1Click:Connect(function()
        if active then 
            active = false
            startBtn.Text = "▶ START DUPE"
            tweenProperty(startBtn, "BackgroundColor3", Color3.fromRGB(50, 200, 100), 0.3)
            addLog("Stopping...", Color3.fromRGB(255, 150, 50))
            return 
        end
        
        active = true
        startBtn.Text = "■ STOP"
        tweenProperty(startBtn, "BackgroundColor3", Color3.fromRGB(255, 50, 50), 0.3)
        
        local amt = tonumber(inA.Text) or 1
        local delay = tonumber(inD.Text) or 0.05
        
        addLog("🚀 Dupe Started: " .. amt .. " items", Color3.fromRGB(100, 200, 255))
        tweenProperty(statusDot, "BackgroundColor3", Color3.fromRGB(255, 100, 100), 0.2)
        
        spawn(function()
            for i = 1, amt do
                if not active then break end
                
                local w = isRnd and 
                    (math.random(1000, 9000) + (math.random(1, 9) / 10)) or 
                    tonumber(inW.Text)
                
                local success, err = pcall(function()
                    ev[_S](ev, {
                        hookPosition = pos,
                        name = inN.Text,
                        rarity = inR.Text,
                        weight = w
                    })
                end)
                
                if not success then
                    addLog("❌ Error: " .. tostring(err), Color3.fromRGB(255, 50, 50))
                end
                
                -- Update progress bar
                local progress = i / amt
                tweenProperty(progressBar, "Size", UDim2.new(progress, 0, 0, 4), delay)
                
                if i % 10 == 0 or i == amt then
                    addLog(string.format("✅ Progress: %d/%d (%.1f%%)", i, amt, progress * 100), 
                           Color3.fromRGB(50, 255, 150))
                end
                
                task.wait(delay)
            end
            
            active = false
            startBtn.Text = "▶ START DUPE"
            tweenProperty(startBtn, "BackgroundColor3", Color3.fromRGB(50, 200, 100), 0.3)
            tweenProperty(statusDot, "BackgroundColor3", Color3.fromRGB(0, 255, 100), 0.2)
            progressBar.Size = UDim2.new(0, 0, 0, 4)
            addLog("🎉 Finished! Total: " .. amt, Color3.fromRGB(255, 255, 100))
        end)
    end)

    -- Hover effects
    startBtn.MouseEnter:Connect(function()
        if not active then
            tweenProperty(startBtn, "Size", UDim2.new(0, 160, 0, 55), 0.2)
        end
    end)
    startBtn.MouseLeave:Connect(function()
        tweenProperty(startBtn, "Size", UDim2.new(0, 150, 0, 50), 0.2)
    end)

    -- Initial log
    addLog("🎣 DupePanel V20 Ready", Color3.fromRGB(100, 200, 255))
    addLog("✨ Enhanced Mobile Edition", Color3.fromRGB(200, 100, 255))
    
    -- Animasi pembuka
    tglBtn.Size = UDim2.new(0, 0, 0, 0)
    tweenProperty(tglBtn, "Size", UDim2.new(0, 80, 0, 80), 0.5)
end
-- [[ V20 - MOBILE OPTIMIZED WITH CUSTOM RANDOM ]] --
return function()
    local player = game:GetService("Players").LocalPlayer
    local pg = player:WaitForChild("PlayerGui")
    local TweenService = game:GetService("TweenService")
    
    -- Hapus instance lama
    if pg:FindFirstChild("AdminSpawn") then 
        pg.AdminSpawn:Destroy() 
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
    local sg = Instance.new("ScreenGui")
    sg.Name = "AdminSpawn"
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 99999
    sg.IgnoreGuiInset = true
    sg.Parent = pg

    -- Fungsi untuk animasi smooth
    local function tweenProperty(obj, prop, value, duration)
        local tween = TweenService:Create(obj, TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quad), {[prop] = value})
        tween:Play()
        return tween
    end

    -- TOGGLE BUTTON (Ukuran lebih kecil & responsif)
    local tglBtn = Instance.new("TextButton")
    tglBtn.Name = "MainToggle"
    tglBtn.Size = UDim2.new(0, 55, 0, 55)
    tglBtn.Position = UDim2.new(0, 10, 0, 120)
    tglBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 90)
    tglBtn.Text = "ADM
    tglBtn.TextColor3 = Color3.new(1, 1, 1)
    tglBtn.Font = Enum.Font.GothamBold
    tglBtn.TextSize = 24
    tglBtn.ZIndex = 100
    tglBtn.BorderSizePixel = 0
    tglBtn.Parent = sg
    
    local tglCorner = Instance.new("UICorner", tglBtn)
    tglCorner.CornerRadius = UDim.new(1, 0)
    
    local tglStroke = Instance.new("UIStroke", tglBtn)
    tglStroke.Color = Color3.fromRGB(255, 255, 255)
    tglStroke.Thickness = 2
    tglStroke.Transparency = 0.6

    -- PANEL UTAMA (Ukuran diperbesar untuk menampung min/max kg)
    local main = Instance.new("Frame")
    main.Name = "Panel"
    main.Size = UDim2.new(0, 420, 0, 290)
    main.Position = UDim2.new(0.5, -210, 0.5, -145)
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
    headerText.Size = UDim2.new(1, -45, 1, 0)
    headerText.Position = UDim2.new(0, 10, 0, 0)
    headerText.BackgroundTransparency = 1
    headerText.Text = "🎣 ADMIN PANEL"
    headerText.TextColor3 = Color3.new(1, 1, 1)
    headerText.Font = Enum.Font.GothamBold
    headerText.TextSize = 14
    headerText.TextXAlignment = "Left"

    -- CLOSE BUTTON
    local xBtn = Instance.new("TextButton", header)
    xBtn.Size = UDim2.new(0, 28, 0, 28)
    xBtn.Position = UDim2.new(1, -32, 0.5, -14)
    xBtn.Text = "❌"
    xBtn.TextSize = 16
    xBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    xBtn.TextColor3 = Color3.new(1, 1, 1)
    xBtn.Font = Enum.Font.GothamBold
    xBtn.BorderSizePixel = 0
    
    local xCorner = Instance.new("UICorner", xBtn)
    xCorner.CornerRadius = UDim.new(0.5, 0)
    
    xBtn.MouseButton1Click:Connect(function()
        main.Visible = false
        tglBtn.Text = "ADM"
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

    -- Input Fields (Layout yang lebih rapi)
    local inN = mkInp("Fish Name", "Goldfish", 10, 45, 190)
    local inR = mkInp("Rarity", "Common", 10, 85, 190)
    
    -- Fixed Weight Input
    local inW = mkInp("Fixed Weight", "676.7", 10, 125, 190)
    
    -- Min & Max Weight untuk Random (NEW!)
    local weightLabel = Instance.new("TextLabel", main)
    weightLabel.Size = UDim2.new(0, 190, 0, 15)
    weightLabel.Position = UDim2.new(0, 10, 0, 165)
    weightLabel.BackgroundTransparency = 1
    weightLabel.Text = "Random Weight Range:"
    weightLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
    weightLabel.Font = Enum.Font.GothamBold
    weightLabel.TextSize = 10
    weightLabel.TextXAlignment = "Left"
    
    local inMinKg = mkInp("Min KG", "200", 10, 182, 90)
    local inMaxKg = mkInp("Max KG", "700", 110, 182, 90)
    
    -- Amount & Delay
    local inA = mkInp("Amount", "100", 10, 222, 90)
    local inD = mkInp("Delay", "0.05", 110, 222, 90)

    -- LOG AREA
    local logContainer = Instance.new("Frame", main)
    logContainer.Size = UDim2.new(0, 200, 0, 212)
    logContainer.Position = UDim2.new(0, 210, 0, 45)
    logContainer.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    logContainer.BorderSizePixel = 0
    
    local logCorner = Instance.new("UICorner", logContainer)
    logCorner.CornerRadius = UDim.new(0, 6)
    
    local logStroke = Instance.new("UIStroke", logContainer)
    logStroke.Color = Color3.fromRGB(50, 200, 120)
    logStroke.Thickness = 1.5

    local logHeader = Instance.new("TextLabel", logContainer)
    logHeader.Size = UDim2.new(1, 0, 0, 22)
    logHeader.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    logHeader.Text = "📋 CONSOLE"
    logHeader.TextColor3 = Color3.fromRGB(50, 200, 120)
    logHeader.Font = Enum.Font.GothamBold
    logHeader.TextSize = 11
    logHeader.BorderSizePixel = 0
    Instance.new("UICorner", logHeader).CornerRadius = UDim.new(0, 6)

    local logBox = Instance.new("ScrollingFrame", logContainer)
    logBox.Size = UDim2.new(1, -8, 1, -28)
    logBox.Position = UDim2.new(0, 4, 0, 26)
    logBox.BackgroundTransparency = 1
    logBox.ScrollBarThickness = 3
    logBox.ScrollBarImageColor3 = Color3.fromRGB(50, 200, 120)
    logBox.BorderSizePixel = 0
    logBox.CanvasSize = UDim2.new(0, 0, 0, 0)

    local logList = Instance.new("UIListLayout", logBox)
    logList.SortOrder = Enum.SortOrder.LayoutOrder
    logList.Padding = UDim.new(0, 1)

    local logCount = 0
    local function addLog(t, color)
        logCount = logCount + 1
        local l = Instance.new("TextLabel", logBox)
        l.Size = UDim2.new(1, -5, 0, 16)
        l.BackgroundTransparency = 1
        l.Text = "> " .. t
        l.TextColor3 = color or Color3.fromRGB(50, 200, 120)
        l.TextSize = 10
        l.Font = Enum.Font.Code
        l.TextXAlignment = "Left"
        l.TextWrapped = true
        l.LayoutOrder = logCount
        
        logBox.CanvasSize = UDim2.new(0, 0, 0, logList.AbsoluteContentSize.Y)
        task.wait()
        logBox.CanvasPosition = Vector2.new(0, logBox.CanvasSize.Y.Offset)
    end

    -- RANDOM WEIGHT TOGGLE (Posisi disesuaikan)
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
        
        -- Update visibility hint
        if isRnd then
            addLog("Random Mode: ON (using Min/Max)", Color3.fromRGB(100, 200, 255))
        else
            addLog("Fixed Mode: ON (using Fixed Weight)", Color3.fromRGB(255, 200, 100))
        end
    end)

    -- START BUTTON
    local active = false
    local startBtn = Instance.new("TextButton", main)
    startBtn.Size = UDim2.new(0, 90, 0, 18)
    startBtn.Position = UDim2.new(0, 115, 0, 265)
    startBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 90)
    startBtn.Text = "▶ START"
    startBtn.TextColor3 = Color3.new(1, 1, 1)
    startBtn.Font = Enum.Font.GothamBold
    startBtn.TextSize = 11
    startBtn.BorderSizePixel = 0
    
    local startCorner = Instance.new("UICorner", startBtn)
    startCorner.CornerRadius = UDim.new(0, 8)

    startBtn.MouseButton1Click:Connect(function()
        if active then 
            active = false
            startBtn.Text = "▶ START"
            startBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 90)
            addLog("Stopped", Color3.fromRGB(255, 150, 50))
            return 
        end
        
        active = true
        startBtn.Text = "■ STOP"
        startBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        
        local amt = tonumber(inA.Text) or 1
        local delay = tonumber(inD.Text) or 0.05
        
        -- Get min/max values
        local minKg = tonumber(inMinKg.Text) or 200
        local maxKg = tonumber(inMaxKg.Text) or 700
        
        -- Validate min/max
        if minKg > maxKg then
            addLog("ERROR: Min KG > Max KG! Swapping...", Color3.fromRGB(255, 100, 100))
            minKg, maxKg = maxKg, minKg
        end
        
        if isRnd then
            addLog(string.format("Random Mode: %d-%d KG", minKg, maxKg), Color3.fromRGB(100, 200, 255))
        else
            addLog("Fixed Mode: " .. (tonumber(inW.Text) or 5000) .. " KG", Color3.fromRGB(255, 200, 100))
        end
        addLog("Starting " .. amt .. " items...", Color3.fromRGB(100, 255, 150))
        
        task.spawn(function()
            for i = 1, amt do
                if not active then break end
                
                local w
                if isRnd then
                    -- Generate random weight with decimal
                    local intPart = math.random(minKg, maxKg)
                    local decPart = math.random(0, 9) / 10
                    w = intPart + decPart
                else
                    -- Use fixed weight
                    w = tonumber(inW.Text) or 676.7
                end
                
                pcall(function()
                    ev[_S](ev, {
                        hookPosition = pos,
                        name = inN.Text,
                        rarity = inR.Text,
                        weight = w
                    })
                end)
                
                if i % 10 == 0 or i == amt then
                    addLog(string.format("Progress: %d/%d (%.1f KG)", i, amt, w))
                end
                
                task.wait(delay)
            end
            
            active = false
            startBtn.Text = "▶ START"
            startBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 90)
            addLog("✓ Finished! Total: " .. amt, Color3.fromRGB(50, 255, 100))
        end)
    end)

    -- TOGGLE LOGIC
    tglBtn.MouseButton1Click:Connect(function()
        main.Visible = not main.Visible
        tglBtn.Text = main.Visible and "❌" or "ADM"
        
        if main.Visible then
            tglBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        else
            tglBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 90)
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

    -- Initial log
    addLog("Panel Ready")
    addLog("Random Mode: ON", Color3.fromRGB(100, 200, 255))
    
    print("Loaded Successfully!")
end
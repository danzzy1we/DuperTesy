-- [[ ADMIN MASS SPAMMER V5 - DARK ELEGANT EDITION ]] --
return function()
    if game.CoreGui:FindFirstChild("AdminDarkV5") then game.CoreGui.AdminDarkV5:Destroy() end

    local _d = function(h)
        local s = ""
        for i in h:gmatch("..") do s = s .. string.char(tonumber(i, 16)) end
        return s
    end

    local _R = _d("5265706c69636174656453746f72616765")
    local _F = _d("46697368696e6753797374656d")
    local _G = _d("466973684769766572")
    local _S = _d("46697265536572766572")

    local ev = game:GetService(_R):WaitForChild(_F):WaitForChild(_G)
    local pos = Vector3.new(1988.84, 450.69, 184.16)

    local sg = Instance.new("ScreenGui", game.CoreGui); sg.Name = "AdminDarkV5"
    
    -- Toggle Button (Floating Icon) - Desain Solid
    local mainToggle = Instance.new("TextButton", sg)
    mainToggle.Size = UDim2.new(0, 50, 0, 50); mainToggle.Position = UDim2.new(0, 15, 0.5, -25)
    mainToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30); mainToggle.Text = "ADM"; mainToggle.TextSize = 14
    mainToggle.TextColor3 = Color3.fromRGB(200, 200, 200); mainToggle.Font = Enum.Font.SourceSansBold
    mainToggle.BorderSizePixel = 0; mainToggle.Draggable = true
    Instance.new("UICorner", mainToggle).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", mainToggle); stroke.Color = Color3.fromRGB(60, 60, 60); stroke.Thickness = 2

    -- Main Panel
    local main = Instance.new("Frame", sg)
    main.Name = "Main"; main.Size = UDim2.new(0, 330, 0, 420); main.Position = UDim2.new(0.5, -165, 0.5, -210)
    main.BackgroundColor3 = Color3.fromRGB(18, 18, 18); main.BorderSizePixel = 0; main.ClipsDescendants = true
    main.Active = true; main.Draggable = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)
    local mStroke = Instance.new("UIStroke", main); mStroke.Color = Color3.fromRGB(40, 40, 40); mStroke.Thickness = 1

    -- Header (Solid Dark)
    local header = Instance.new("TextLabel", main)
    header.Size = UDim2.new(1, 0, 0, 45); header.Text = "   ADMIN CONTROL PANEL"; header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    header.TextColor3 = Color3.fromRGB(240, 240, 240); header.Font = Enum.Font.GothamBold; header.TextXAlignment = "Left"
    header.BorderSizePixel = 0

    -- Resize Button
    local resizeBtn = Instance.new("TextButton", main)
    resizeBtn.Size = UDim2.new(0, 30, 0, 30); resizeBtn.Position = UDim2.new(1, -75, 0, 7)
    resizeBtn.Text = "—"; resizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); resizeBtn.TextColor3 = Color3.white; resizeBtn.BorderSizePixel = 0
    Instance.new("UICorner", resizeBtn)

    -- Close Button
    local cl = Instance.new("TextButton", main)
    cl.Size = UDim2.new(0, 30, 0, 30); cl.Position = UDim2.new(1, -37, 0, 7)
    cl.Text = "✕"; cl.BackgroundColor3 = Color3.fromRGB(180, 40, 40); cl.TextColor3 = Color3.white; cl.BorderSizePixel = 0
    Instance.new("UICorner", cl)

    -- Scroll Area
    local scroll = Instance.new("ScrollingFrame", main)
    scroll.Size = UDim2.new(1, -20, 1, -120); scroll.Position = UDim2.new(0, 10, 0, 55)
    scroll.BackgroundTransparency = 1; scroll.CanvasSize = UDim2.new(0,0,1.5,0); scroll.ScrollBarThickness = 2; scroll.ScrollBarImageColor3 = Color3.fromRGB(80,80,80)

    local function createInput(ph, def, y)
        local f = Instance.new("TextBox", scroll)
        f.Size = UDim2.new(0.96, 0, 0, 38); f.Position = UDim2.new(0, 0, 0, y)
        f.PlaceholderText = ph; f.Text = def; f.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
        f.TextColor3 = Color3.new(1,1,1); f.Font = Enum.Font.SourceSans; f.BorderSizePixel = 0
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
        local s = Instance.new("UIStroke", f); s.Color = Color3.fromRGB(45, 45, 45); s.Thickness = 1
        return f
    end

    local inN = createInput("Fish Name", "Goldfish", 0)
    local inR = createInput("Rarity", "Common", 48)
    local inW = createInput("Weight", "1000.00", 96)
    local inA = createInput("Spam Amount", "50", 144)
    local inD = createInput("Spam Delay", "0.05", 192)

    -- Toggle Style
    local isRnd = true; local isDly = true; local spamming = false

    local function createTgl(txt, y, def, callback)
        local btn = Instance.new("TextButton", scroll)
        btn.Size = UDim2.new(0.96, 0, 0, 38); btn.Position = UDim2.new(0, 0, 0, y)
        btn.Text = "  " .. txt .. ": " .. (def and "ON" or "OFF")
        btn.BackgroundColor3 = def and Color3.fromRGB(40, 60, 40) or Color3.fromRGB(60, 40, 40)
        btn.TextColor3 = Color3.white; btn.TextXAlignment = "Left"; btn.BorderSizePixel = 0
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        
        btn.MouseButton1Click:Connect(function()
            local s = callback()
            btn.Text = "  " .. txt .. ": " .. (s and "ON" or "OFF")
            btn.BackgroundColor3 = s and Color3.fromRGB(40, 60, 40) or Color3.fromRGB(60, 40, 40)
        end)
        return btn
    end

    createTgl("Random Weight", 240, true, function() isRnd = not isRnd return isRnd end)
    createTgl("Use Delay", 288, true, function() isDly = not isDly return isDly end)

    -- Execute Button (Solid Blue)
    local start = Instance.new("TextButton", main)
    start.Size = UDim2.new(1, -20, 0, 45); start.Position = UDim2.new(0, 10, 1, -55)
    start.Text = "START SPAM"; start.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    start.TextColor3 = Color3.white; start.Font = Enum.Font.GothamBold; start.BorderSizePixel = 0
    Instance.new("UICorner", start).CornerRadius = UDim.new(0, 8)

    -- Logic
    local function runSpam()
        if spamming then 
            spamming = false
            start.Text = "START SPAM"; start.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
            return 
        end
        spamming = true
        start.Text = "STOP SPAMMING"; start.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
        
        local amt = tonumber(inA.Text) or 10
        local d = tonumber(inD.Text) or 0.05
        
        for i = 1, amt do
            if not spamming then break end
            local wV = isRnd and (math.random(10000, 99000)/100) or (tonumber(inW.Text) or 100)
            ev[_S](ev, {hookPosition = pos, name = inName and inName.Text or inN.Text, rarity = inR.Text, weight = wV})
            if isDly then task.wait(d) end
        end
        spamming = false
        start.Text = "START SPAM"; start.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    end

    start.MouseButton1Click:Connect(runSpam)
    
    -- Resize Logic
    local minimized = false
    resizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        main:TweenSize(minimized and UDim2.new(0, 330, 0, 45) or UDim2.new(0, 330, 0, 420), "Out", "Quart", 0.3, true)
        resizeBtn.Text = minimized and "+" or "—"
    end)

    mainToggle.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
    cl.MouseButton1Click:Connect(function() sg:Destroy() end)
end

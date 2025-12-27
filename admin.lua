-- [[ ADMIN MASS SPAMMER V4 - MOBILE OPTIMIZED & ENCRYPTED ]] --
return function()
    -- Anti-Duplikasi
    if game.CoreGui:FindFirstChild("AdminMobileV4") then game.CoreGui.AdminMobileV4:Destroy() end

    local _d = function(h)
        local s = ""
        for i in h:gmatch("..") do s = s .. string.char(tonumber(i, 16)) end
        return s
    end

    -- [ DATA ENKRIPSI ]
    local _R = _d("5265706c69636174656453746f72616765")
    local _F = _d("46697368696e6753797374656d")
    local _G = _d("466973684769766572")
    local _S = _d("46697265536572766572")

    local ev = game:GetService(_R):WaitForChild(_F):WaitForChild(_G)
    local pos = Vector3.new(1988.84, 450.69, 184.16)

    -- [ GUI MAIN ]
    local sg = Instance.new("ScreenGui", game.CoreGui); sg.Name = "AdminMobileV4"
    
    -- Tombol Kecil di Pojok (Toggle Menu)
    local mainToggle = Instance.new("TextButton", sg)
    mainToggle.Size = UDim2.new(0, 45, 0, 45); mainToggle.Position = UDim2.new(0, 10, 0.5, -22)
    mainToggle.BackgroundColor3 = Color3.fromRGB(0, 120, 255); mainToggle.Text = "🛡️"; mainToggle.TextSize = 25
    mainToggle.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", mainToggle).CornerRadius = UDim.new(1, 0)
    mainToggle.Draggable = true -- Bisa digeser di HP

    local main = Instance.new("Frame", sg)
    main.Name = "Main"; main.Size = UDim2.new(0, 320, 0, 400) -- Ukuran lebih ramping untuk HP
    main.Position = UDim2.new(0.5, -160, 0.5, -200); main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    main.Visible = true; main.Active = true; main.Draggable = true
    Instance.new("UICorner", main)

    -- HEADER
    local header = Instance.new("TextLabel", main)
    header.Size = UDim2.new(1, 0, 0, 40); header.Text = "ADMIN MASS SPAM V4"; header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    header.TextColor3 = Color3.new(1,1,1); header.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", header)

    -- TOMBOL RESIZE (PENGEKECIL)
    local isSmall = false
    local resizeBtn = Instance.new("TextButton", main)
    resizeBtn.Size = UDim2.new(0, 30, 0, 30); resizeBtn.Position = UDim2.new(1, -70, 0, 5)
    resizeBtn.Text = "❐"; resizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50); resizeBtn.TextColor3 = Color3.new(1,1,1)
    
    resizeBtn.MouseButton1Click:Connect(function()
        isSmall = not isSmall
        if isSmall then
            main:TweenSize(UDim2.new(0, 320, 0, 40), "Out", "Quart", 0.3, true)
            resizeBtn.Text = "＋"
        else
            main:TweenSize(UDim2.new(0, 320, 0, 400), "Out", "Quart", 0.3, true)
            resizeBtn.Text = "❐"
        end
    end)

    -- SCROLLING AREA
    local scroll = Instance.new("ScrollingFrame", main)
    scroll.Size = UDim2.new(1, -10, 1, -100); scroll.Position = UDim2.new(0, 5, 0, 45)
    scroll.BackgroundTransparency = 1; scroll.CanvasSize = UDim2.new(0,0,1.8,0); scroll.ScrollBarThickness = 0

    local function createBox(ph, def, y)
        local b = Instance.new("TextBox", scroll)
        b.Size = UDim2.new(0.95, 0, 0, 35); b.Position = UDim2.new(0.025, 0, 0, y)
        b.PlaceholderText = ph; b.Text = def; b.BackgroundColor3 = Color3.fromRGB(30, 30, 30); b.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", b); return b
    end

    -- Inputs (Mobile Friendly size)
    local inN = createBox("Fish Name...", "Goldfish", 5)
    local inR = createBox("Rarity...", "Common", 45)
    local inW = createBox("Manual Weight...", "999.99", 85)
    local inA = createBox("Amount...", "100", 125)
    local inD = createBox("Spam Delay...", "0.05", 165)

    -- Toggles
    local isRnd = true; local isDly = true; local spamming = false

    local function createTgl(txt, y, def, callback)
        local btn = Instance.new("TextButton", scroll)
        btn.Size = UDim2.new(0.95, 0, 0, 35); btn.Position = UDim2.new(0.025, 0, 0, y)
        btn.Text = txt .. (def and ": ON" or ": OFF")
        btn.BackgroundColor3 = def and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 30, 30)
        btn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", btn)
        btn.MouseButton1Click:Connect(function()
            local newState = callback()
            btn.Text = txt .. (newState and ": ON" or ": OFF")
            btn.BackgroundColor3 = newState and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 30, 30)
        end)
        return btn
    end

    createTgl("Random Weight", 205, true, function() isRnd = not isRnd return isRnd end)
    createTgl("Use Delay", 245, true, function() isDly = not isDly return isDly end)

    -- Tombol Start/Stop Spam
    local start = Instance.new("TextButton", main)
    start.Size = UDim2.new(1, -20, 0, 45); start.Position = UDim2.new(0, 10, 1, -50)
    start.Text = "START SPAM"; start.BackgroundColor3 = Color3.fromRGB(0, 120, 255); start.TextColor3 = Color3.new(1,1,1); start.Font = "SourceSansBold"
    Instance.new("UICorner", start)

    local function runSpam()
        if spamming then 
            spamming = false
            start.Text = "START SPAM"; start.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
            return 
        end
        
        spamming = true
        start.Text = "🛑 STOP SPAM"; start.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        
        local amt = tonumber(inA.Text) or 100
        local dTime = tonumber(inD.Text) or 0.05
        
        for i = 1, amt do
            if not spamming then break end
            local wV = isRnd and (math.random(10000, 90000)/100) or (tonumber(inW.Text) or 100)
            
            ev[_S](ev, {
                hookPosition = pos,
                name = inN.Text,
                rarity = inR.Text,
                weight = wV
            })
            
            if isDly then task.wait(dTime) end
        end
        
        spamming = false
        start.Text = "START SPAM"; start.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    end

    start.MouseButton1Click:Connect(runSpam)
    mainToggle.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)

    -- Tombol Close
    local cl = Instance.new("TextButton", main); cl.Size = UDim2.new(0, 30, 0, 30); cl.Position = UDim2.new(1, -35, 0, 5)
    cl.Text = "X"; cl.BackgroundColor3 = Color3.fromRGB(150, 0, 0); cl.TextColor3 = Color3.new(1,1,1)
    cl.MouseButton1Click:Connect(function() sg:Destroy() end)
end

-- [[ ADMIN MASS SPAMMER V6 - FIXED MOBILE UI ]] --
return function()
    -- Bersihkan UI lama
    if game.CoreGui:FindFirstChild("AdminFixedV6") then game.CoreGui.AdminFixedV6:Destroy() end

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

    -- [ MAIN GUI ]
    local sg = Instance.new("ScreenGui", game.CoreGui); sg.Name = "AdminFixedV6"
    
    -- Tombol Floating ADM
    local mainToggle = Instance.new("TextButton", sg)
    mainToggle.Size = UDim2.new(0, 55, 0, 55); mainToggle.Position = UDim2.new(0, 20, 0.5, -27)
    mainToggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35); mainToggle.Text = "ADM"; mainToggle.TextSize = 16
    mainToggle.TextColor3 = Color3.new(1,1,1); mainToggle.Font = Enum.Font.GothamBold; mainToggle.ZIndex = 100
    Instance.new("UICorner", mainToggle).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", mainToggle).Color = Color3.fromRGB(80, 80, 80)
    mainToggle.Draggable = true

    -- Main Panel
    local main = Instance.new("Frame", sg)
    main.Name = "Main"; main.Size = UDim2.new(0, 320, 0, 420); main.Position = UDim2.new(0.5, -160, 0.5, -210)
    main.BackgroundColor3 = Color3.fromRGB(15, 15, 15); main.BorderSizePixel = 0; main.Active = true; main.Draggable = true; main.ClipsDescendants = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", main).Color = Color3.fromRGB(45, 45, 45)

    -- Header
    local header = Instance.new("TextLabel", main)
    header.Size = UDim2.new(1, 0, 0, 45); header.Text = "  ADMIN CONTROL PANEL"; header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    header.TextColor3 = Color3.white; header.Font = Enum.Font.GothamBold; header.TextXAlignment = "Left"; header.ZIndex = 2
    Instance.new("UICorner", header)

    -- Resize & Close
    local resizeBtn = Instance.new("TextButton", main)
    resizeBtn.Size = UDim2.new(0, 32, 0, 32); resizeBtn.Position = UDim2.new(1, -75, 0, 6)
    resizeBtn.Text = "—"; resizeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); resizeBtn.TextColor3 = Color3.white; resizeBtn.ZIndex = 3
    Instance.new("UICorner", resizeBtn)

    local cl = Instance.new("TextButton", main)
    cl.Size = UDim2.new(0, 32, 0, 32); cl.Position = UDim2.new(1, -38, 0, 6)
    cl.Text = "✕"; cl.BackgroundColor3 = Color3.fromRGB(160, 40, 40); cl.TextColor3 = Color3.white; cl.ZIndex = 3
    Instance.new("UICorner", cl)

    -- Scroll Area (Wajib pakai ZIndex tinggi agar terlihat)
    local scroll = Instance.new("ScrollingFrame", main)
    scroll.Size = UDim2.new(1, -20, 1, -115); scroll.Position = UDim2.new(0, 10, 0, 55)
    scroll.BackgroundTransparency = 1; scroll.CanvasSize = UDim2.new(0, 0, 1.8, 0); scroll.ScrollBarThickness = 3; scroll.ZIndex = 5

    local function createInput(ph, def, y)
        local f = Instance.new("TextBox", scroll)
        f.Size = UDim2.new(0.96, 0, 0, 40); f.Position = UDim2.new(0.02, 0, 0, y)
        f.PlaceholderText = ph; f.Text = def; f.BackgroundColor3 = Color3.fromRGB(28, 28, 28); f.ZIndex = 6
        f.TextColor3 = Color3.white; f.Font = Enum.Font.SourceSans; f.BorderSizePixel = 0
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
        Instance.new("UIStroke", f).Color = Color3.fromRGB(50, 50, 50)
        return f
    end

    local inN = createInput("Fish Name", "Goldfish", 5)
    local inR = createInput("Rarity", "Common", 55)
    local inW = createInput("Manual Weight", "1000.00", 105)
    local inA = createInput("Amount", "100", 155)
    local inD = createInput("Spam Delay", "0.05", 205)

    -- Toggles
    local isRnd = true; local isDly = true; local spamming = false

    local function createTgl(txt, y, def, callback)
        local btn = Instance.new("TextButton", scroll)
        btn.Size = UDim2.new(0.96, 0, 0, 40); btn.Position = UDim2.new(0.02, 0, 0, y)
        btn.Text = "  " .. txt .. ": " .. (def and "ON" or "OFF")
        btn.BackgroundColor3 = def and Color3.fromRGB(35, 65, 35) or Color3.fromRGB(65, 35, 35)
        btn.TextColor3 = Color3.white; btn.TextXAlignment = "Left"; btn.ZIndex = 6
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        
        btn.MouseButton1Click:Connect(function()
            local s = callback()
            btn.Text = "  " .. txt .. ": " .. (s and "ON" or "OFF")
            btn.BackgroundColor3 = s and Color3.fromRGB(35, 65, 35) or Color3.fromRGB(65, 35, 35)
        end)
        return btn
    end

    createTgl("Random Weight", 255, true, function() isRnd = not isRnd return isRnd end)
    createTgl("Use Delay", 305, true, function() isDly = not isDly return isDly end)

    -- Start Button
    local start = Instance.new("TextButton", main)
    start.Size = UDim2.new(1, -20, 0, 48); start.Position = UDim2.new(0, 10, 1, -58)
    start.Text = "START MASS SPAM"; start.BackgroundColor3 = Color3.fromRGB(0, 110, 220)
    start.TextColor3 = Color3.white; start.Font = Enum.Font.GothamBold; start.ZIndex = 6
    Instance.new("UICorner", start).CornerRadius = UDim.new(0, 8)

    -- Spam Logic
    local function runSpam()
        if spamming then 
            spamming = false
            start.Text = "START MASS SPAM"; start.BackgroundColor3 = Color3.fromRGB(0, 110, 220)
            return 
        end
        spamming = true
        start.Text = "🛑 STOP SPAM"; start.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        
        local amt = tonumber(inA.Text) or 10
        local d = tonumber(inD.Text) or 0.05
        
        for i = 1, amt do
            if not spamming then break end
            local wV = isRnd and (math.random(10000, 99000)/100) or (tonumber(inW.Text) or 100)
            
            pcall(function()
                ev[_S](ev, {
                    hookPosition = pos,
                    name = inN.Text,
                    rarity = inR.Text,
                    weight = wV
                })
            end)
            
            if isDly then task.wait(d) end
        end
        spamming = false
        start.Text = "START MASS SPAM"; start.BackgroundColor3 = Color3.fromRGB(0, 110, 220)
    end

    start.MouseButton1Click:Connect(runSpam)
    
    -- Resize Logic
    local minimized = false
    resizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        main:TweenSize(minimized and UDim2.new(0, 320, 0, 45) or UDim2.new(0, 320, 0, 420), "Out", "Quart", 0.25, true)
        resizeBtn.Text = minimized and "+" or "—"
    end)

    mainToggle.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
    cl.MouseButton1Click:Connect(function() sg:Destroy() end)
end

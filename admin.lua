-- [[ ADMIN MASS SPAMMER V7 - STABLE SLATE EDITION ]] --
return function()
    -- Pembersihan GUI lama
    if game.CoreGui:FindFirstChild("AdminV7") then game.CoreGui.AdminV7:Destroy() end

    local _d = function(h)
        local s = ""
        for i in h:gmatch("..") do s = s .. string.char(tonumber(i, 16)) end
        return s
    end

    -- [ DATA ENKRIPSI REMOTES ]
    local _R = _d("5265706c69636174656453746f72616765")
    local _F = _d("46697368696e6753797374656d")
    local _G = _d("466973684769766572")
    local _S = _d("46697265536572766572")

    local ev = game:GetService(_R):WaitForChild(_F):WaitForChild(_G)
    local pos = Vector3.new(1988.84, 450.69, 184.16)

    -- [ MAIN INTERFACE ]
    local sg = Instance.new("ScreenGui", game.CoreGui); sg.Name = "AdminV7"
    
    -- Toggle Button (ADM Icon)
    local mainToggle = Instance.new("TextButton", sg)
    mainToggle.Size = UDim2.new(0, 50, 0, 50); mainToggle.Position = UDim2.new(0, 20, 0.5, -25)
    mainToggle.BackgroundColor3 = Color3.fromRGB(30, 31, 33); mainToggle.Text = "ADM"; mainToggle.TextSize = 14
    mainToggle.TextColor3 = Color3.fromRGB(255, 255, 255); mainToggle.Font = Enum.Font.GothamBold; mainToggle.ZIndex = 100
    Instance.new("UICorner", mainToggle).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", mainToggle).Color = Color3.fromRGB(60, 62, 66)
    mainToggle.Draggable = true

    -- Main Frame
    local main = Instance.new("Frame", sg)
    main.Name = "MainFrame"; main.Size = UDim2.new(0, 300, 0, 420); main.Position = UDim2.new(0.5, -150, 0.5, -210)
    main.BackgroundColor3 = Color3.fromRGB(20, 21, 23); main.BorderSizePixel = 0; main.Active = true; main.Draggable = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", main).Color = Color3.fromRGB(45, 47, 50)

    -- Title Bar
    local header = Instance.new("TextLabel", main)
    header.Size = UDim2.new(1, 0, 0, 45); header.Text = "   ADMIN PANEL V7"; header.BackgroundColor3 = Color3.fromRGB(26, 27, 30)
    header.TextColor3 = Color3.fromRGB(230, 230, 230); header.Font = Enum.Font.GothamBold; header.TextXAlignment = "Left"; header.ZIndex = 2
    Instance.new("UICorner", header)

    -- Close Button
    local cl = Instance.new("TextButton", main)
    cl.Size = UDim2.new(0, 30, 0, 30); cl.Position = UDim2.new(1, -38, 0, 7.5)
    cl.Text = "✕"; cl.BackgroundColor3 = Color3.fromRGB(180, 50, 50); cl.TextColor3 = Color3.white; cl.ZIndex = 3
    Instance.new("UICorner", cl)

    -- Scroll Area (Fixed Visibility)
    local scroll = Instance.new("ScrollingFrame", main)
    scroll.Size = UDim2.new(1, -20, 1, -110); scroll.Position = UDim2.new(0, 10, 0, 55)
    scroll.BackgroundTransparency = 1; scroll.CanvasSize = UDim2.new(0, 0, 1.6, 0); scroll.ScrollBarThickness = 2; scroll.ZIndex = 5

    local function createField(ph, def, y)
        local f = Instance.new("TextBox", scroll)
        f.Size = UDim2.new(0.96, 0, 0, 38); f.Position = UDim2.new(0.02, 0, 0, y)
        f.PlaceholderText = ph; f.Text = def; f.BackgroundColor3 = Color3.fromRGB(30, 32, 35)
        f.TextColor3 = Color3.white; f.Font = Enum.Font.Gotham; f.BorderSizePixel = 0; f.ZIndex = 6
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
        Instance.new("UIStroke", f).Color = Color3.fromRGB(55, 57, 60)
        return f
    end

    -- Inputs
    local inN = createField("Fish Name", "Goldfish", 0)
    local inR = createField("Rarity", "Common", 45)
    local inW = createField("Weight", "9999.99", 90)
    local inA = createField("Amount", "100", 135)
    local inD = createField("Delay (Seconds)", "0.05", 180)

    -- Toggles
    local isRnd = true; local isDly = true; local spamming = false

    local function createToggle(txt, y, def, callback)
        local btn = Instance.new("TextButton", scroll)
        btn.Size = UDim2.new(0.96, 0, 0, 38); btn.Position = UDim2.new(0.02, 0, 0, y)
        btn.Text = "  " .. txt .. ": " .. (def and "ON" or "OFF")
        btn.BackgroundColor3 = def and Color3.fromRGB(45, 70, 50) or Color3.fromRGB(80, 45, 45)
        btn.TextColor3 = Color3.white; btn.TextXAlignment = "Left"; btn.ZIndex = 6; btn.Font = Enum.Font.Gotham
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        
        btn.MouseButton1Click:Connect(function()
            local state = callback()
            btn.Text = "  " .. txt .. ": " .. (state and "ON" or "OFF")
            btn.BackgroundColor3 = state and Color3.fromRGB(45, 70, 50) or Color3.fromRGB(80, 45, 45)
        end)
        return btn
    end

    createToggle("Random Weight", 230, true, function() isRnd = not isRnd return isRnd end)
    createToggle("Use Delay", 275, true, function() isDly = not isDly return isDly end)

    -- Start/Stop Button
    local start = Instance.new("TextButton", main)
    start.Size = UDim2.new(1, -20, 0, 45); start.Position = UDim2.new(0, 10, 1, -55)
    start.Text = "LAUNCH MASS SPAM"; start.BackgroundColor3 = Color3.fromRGB(0, 102, 204)
    start.TextColor3 = Color3.white; start.Font = Enum.Font.GothamBold; start.ZIndex = 6
    Instance.new("UICorner", start).CornerRadius = UDim.new(0, 8)

    -- Logic Execution
    local function runSpam()
        if spamming then 
            spamming = false
            start.Text = "LAUNCH MASS SPAM"; start.BackgroundColor3 = Color3.fromRGB(0, 102, 204)
            return 
        end
        spamming = true
        start.Text = "STOPPING..."; start.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
        
        local amt = tonumber(inA.Text) or 1
        local delayVal = tonumber(inD.Text) or 0.05
        
        for i = 1, amt do
            if not spamming then break end
            local finalWeight = isRnd and (math.random(10000, 99000)/100) or (tonumber(inW.Text) or 100)
            
            pcall(function()
                ev[_S](ev, {
                    hookPosition = pos,
                    name = inN.Text,
                    rarity = inR.Text,
                    weight = finalWeight
                })
            end)
            if isDly then task.wait(delayVal) end
        end
        spamming = false
        start.Text = "LAUNCH MASS SPAM"; start.BackgroundColor3 = Color3.fromRGB(0, 102, 204)
    end

    start.MouseButton1Click:Connect(runSpam)
    mainToggle.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
    cl.MouseButton1Click:Connect(function() sg:Destroy() end)
end

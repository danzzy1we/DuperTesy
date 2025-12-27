-- [[ ADMIN MASS SPAMMER V13 - SMALLER BUTTON & UI FIX ]] --
return function()
    if game.CoreGui:FindFirstChild("AdminV13") then game.CoreGui.AdminV13:Destroy() end

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

    local sg = Instance.new("ScreenGui", game.CoreGui); sg.Name = "AdminV13"
    sg.DisplayOrder = 100 -- Memastikan di atas UI game
    
    -- TOMBOL SHOW/HIDE (UKURAN LEBIH KECIL & SOLID)
    local tglBtn = Instance.new("ImageButton", sg)
    tglBtn.Name = "HideShowButton"
    tglBtn.Size = UDim2.new(0, 42, 0, 42) -- Ukuran diperkecil dari 60 ke 42
    tglBtn.Position = UDim2.new(0, 15, 0.5, 20) -- Digeser sedikit ke bawah agar tidak ganggu chat
    tglBtn.BackgroundColor3 = Color3.fromRGB(0, 102, 204) -- Biru Solid
    tglBtn.Image = "rbxassetid://6031280882" -- Ikon Shield/Gear
    tglBtn.ZIndex = 10
    tglBtn.Active = true
    tglBtn.Draggable = true -- Masih bisa kamu geser manual jika kurang pas
    Instance.new("UICorner", tglBtn).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", tglBtn); stroke.Color = Color3.new(1,1,1); stroke.Thickness = 1.5

    -- PANEL UTAMA
    local main = Instance.new("Frame", sg)
    main.Name = "MainFrame"
    main.Size = UDim2.new(0, 440, 0, 260) -- Sedikit lebih ramping
    main.Position = UDim2.new(0.5, -220, 0.5, -130)
    main.BackgroundColor3 = Color3.new(0, 0, 0)
    main.BackgroundTransparency = 0.4 -- Background tetap transparan elegan
    main.Active = true
    main.Draggable = true
    main.Visible = true
    Instance.new("UICorner", main)

    -- Title Header
    local header = Instance.new("TextLabel", main)
    header.Size = UDim2.new(1, 0, 0, 32)
    header.Text = "  ADMIN CONTROL PANEL V13"
    header.TextColor3 = Color3.new(1,1,1)
    header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    header.Font = Enum.Font.GothamBold; header.TextSize = 13; header.TextXAlignment = "Left"
    Instance.new("UICorner", header)

    -- Inputs Area (SOLID BACKGROUND)
    local function createField(ph, def, x, y)
        local f = Instance.new("TextBox", main)
        f.Size = UDim2.new(0, 205, 0, 34)
        f.Position = UDim2.new(0, x, 0, y)
        f.Text = def; f.PlaceholderText = ph
        f.BackgroundColor3 = Color3.fromRGB(45, 45, 45) -- Solid
        f.TextColor3 = Color3.new(1,1,1); f.Font = Enum.Font.SourceSans; f.TextSize = 14
        f.ClearTextOnFocus = false
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 4)
        return f
    end

    local inN = createField("Fish Name", "Goldfish", 10, 42)
    local inR = createField("Rarity", "Common", 10, 82)
    local inW = createField("Weight", "5000", 10, 122)
    local inA = createField("Amount", "100", 10, 162)
    local inD = createField("Delay", "0.05", 10, 202)

    -- Log Area (Side)
    local logBox = Instance.new("ScrollingFrame", main)
    logBox.Size = UDim2.new(0, 205, 0, 154)
    logBox.Position = UDim2.new(0, 225, 0, 42)
    logBox.BackgroundColor3 = Color3.new(0,0,0); logBox.BackgroundTransparency = 0.5
    logBox.CanvasSize = UDim2.new(0, 0, 15, 0); logBox.ScrollBarThickness = 2
    Instance.new("UICorner", logBox)

    local function addLog(txt)
        local l = Instance.new("TextLabel", logBox)
        l.Size = UDim2.new(1, -5, 0, 18); l.BackgroundTransparency = 1
        l.Text = "> " .. txt; l.TextColor3 = Color3.fromRGB(0, 255, 150); l.TextSize = 11
        l.TextXAlignment = "Left"
        logBox.CanvasPosition = Vector2.new(0, 99999)
    end

    -- Toggle Button (SOLID)
    local isRnd = true
    local tglR = Instance.new("TextButton", main)
    tglR.Size = UDim2.new(0, 205, 0, 34)
    tglR.Position = UDim2.new(0, 225, 0, 202)
    tglR.Text = "Random Weight: ON"; tglR.TextColor3 = Color3.white
    tglR.BackgroundColor3 = Color3.fromRGB(0, 120, 0) -- Solid
    Instance.new("UICorner", tglR)

    tglR.MouseButton1Click:Connect(function()
        isRnd = not isRnd
        tglR.Text = "Random Weight: " .. (isRnd and "ON" or "OFF")
        tglR.BackgroundColor3 = isRnd and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(150, 0, 0)
    end)

    -- Launch Button (SOLID)
    local spamming = false
    local startBtn = Instance.new("TextButton", main)
    startBtn.Size = UDim2.new(1, -20, 0, 38)
    startBtn.Position = UDim2.new(0, 10, 1, -45)
    startBtn.Text = "LAUNCH MASS ATTACK"; startBtn.Font = Enum.Font.GothamBold
    startBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 230) -- Solid
    startBtn.TextColor3 = Color3.white
    Instance.new("UICorner", startBtn)

    startBtn.MouseButton1Click:Connect(function()
        if spamming then spamming = false startBtn.Text = "LAUNCH MASS ATTACK" return end
        spamming = true; startBtn.Text = "STOPPING SPAM..."
        addLog("Attack Started.")
        
        local amt = tonumber(inA.Text) or 1
        for i = 1, amt do
            if not spamming then break end
            local w = isRnd and math.random(3000, 8000) or tonumber(inW.Text)
            pcall(function()
                ev[_S](ev, {hookPosition = pos, name = inN.Text, rarity = inR.Text, weight = w})
            end)
            if i % 10 == 0 then addLog("Spammed: " .. i) end
            task.wait(tonumber(inD.Text) or 0.05)
        end
        spamming = false; startBtn.Text = "LAUNCH MASS ATTACK"; addLog("Finished.")
    end)

    -- Close Button
    local cl = Instance.new("TextButton", main)
    cl.Size = UDim2.new(0, 26, 0, 26); cl.Position = UDim2.new(1, -30, 0, 3)
    cl.Text = "✕"; cl.BackgroundColor3 = Color3.fromRGB(180, 0, 0); cl.TextColor3 = Color3.white
    Instance.new("UICorner", cl).CornerRadius = UDim.new(1, 0)
    cl.MouseButton1Click:Connect(function() sg:Destroy() end)

    -- Toggle Panel Logic (Fixed for Mobile)
    tglBtn.MouseButton1Click:Connect(function()
        main.Visible = not main.Visible
    end)
    
    addLog("System Initialized.")
end

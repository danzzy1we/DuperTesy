-- [[ ADMIN MASS SPAMMER V11 - IMAGE BUTTON EDITION ]] --
return function()
    if game.CoreGui:FindFirstChild("AdminV11") then game.CoreGui.AdminV11:Destroy() end

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

    local sg = Instance.new("ScreenGui", game.CoreGui); sg.Name = "AdminV11"
    
    -- TOMBOL SHOW/HIDE MENGGUNAKAN GAMBAR (ImageButton)
    local tglBtn = Instance.new("ImageButton", sg)
    tglBtn.Size = UDim2.new(0, 55, 0, 55)
    tglBtn.Position = UDim2.new(0, 15, 0.5, -27)
    tglBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tglBtn.BackgroundTransparency = 0.2
    
    -- GANTI ID DI BAWAH INI JIKA INGIN FOTO LAIN
    tglBtn.Image = "rbxassetid://6031280882" -- Ikon Shield/Admin
    
    tglBtn.ScaleType = Enum.ScaleType.Fit
    tglBtn.Draggable = true
    local corner = Instance.new("UICorner", tglBtn)
    corner.CornerRadius = UDim.new(1, 0) -- Membuat tombol jadi bulat sempurna
    
    local stroke = Instance.new("UIStroke", tglBtn)
    stroke.Color = Color3.fromRGB(0, 120, 255)
    stroke.Thickness = 2

    -- PANEL UTAMA (TRANSPARENT LANDSCAPE)
    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0, 460, 0, 290)
    main.Position = UDim2.new(0.5, -230, 0.5, -145)
    main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    main.BackgroundTransparency = 0.4
    main.Visible = true
    main.Active = true
    main.Draggable = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

    -- Header
    local header = Instance.new("TextLabel", main)
    header.Size = UDim2.new(1, 0, 0, 35)
    header.Text = "   ADMIN PANEL V11 - STABLE IMAGE"
    header.TextColor3 = Color3.new(1, 1, 1)
    header.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    header.BackgroundTransparency = 0.3
    header.TextXAlignment = "Left"
    header.Font = Enum.Font.GothamBold
    Instance.new("UICorner", header)

    -- Input & Log Area (Sama seperti V10 namun lebih presisi)
    local function createInp(ph, def, x, y)
        local i = Instance.new("TextBox", main)
        i.Size = UDim2.new(0, 215, 0, 35)
        i.Position = UDim2.new(0, x, 0, y)
        i.Text = def
        i.PlaceholderText = ph
        i.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        i.BackgroundTransparency = 0.5
        i.TextColor3 = Color3.new(1, 1, 1)
        i.ClearTextOnFocus = false
        Instance.new("UICorner", i)
        return i
    end

    local inN = createInp("Fish Name", "Goldfish", 10, 50)
    local inR = createInp("Rarity", "Common", 10, 90)
    local inW = createInp("Manual Weight", "2500", 10, 130)
    local inA = createInp("Amount", "100", 10, 170)
    local inD = createInp("Delay", "0.05", 10, 210)

    local logBox = Instance.new("ScrollingFrame", main)
    logBox.Size = UDim2.new(0, 215, 0, 155)
    logBox.Position = UDim2.new(0, 235, 0, 50)
    logBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    logBox.BackgroundTransparency = 0.6
    logBox.CanvasSize = UDim2.new(0, 0, 10, 0)
    logBox.ScrollBarThickness = 2
    Instance.new("UICorner", logBox)

    local logList = Instance.new("UIListLayout", logBox)
    
    local function addLog(txt)
        local l = Instance.new("TextLabel", logBox)
        l.Size = UDim2.new(1, -5, 0, 20)
        l.BackgroundTransparency = 1
        l.Text = " " .. txt
        l.TextColor3 = Color3.fromRGB(0, 200, 255)
        l.TextSize = 11
        l.TextXAlignment = "Left"
        logBox.CanvasPosition = Vector2.new(0, 99999)
    end

    -- Toggle & Start
    local isRnd = true
    local tglR = Instance.new("TextButton", main)
    tglR.Size = UDim2.new(0, 215, 0, 35)
    tglR.Position = UDim2.new(0, 235, 0, 210)
    tglR.Text = "Random Weight: ON"
    tglR.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    tglR.BackgroundTransparency = 0.4
    tglR.TextColor3 = Color3.white
    Instance.new("UICorner", tglR)

    tglR.MouseButton1Click:Connect(function()
        isRnd = not isRnd
        tglR.Text = "Random Weight: " .. (isRnd and "ON" or "OFF")
        tglR.BackgroundColor3 = isRnd and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(120, 0, 0)
    end)

    local spamming = false
    local startBtn = Instance.new("TextButton", main)
    startBtn.Size = UDim2.new(1, -20, 0, 35)
    startBtn.Position = UDim2.new(0, 10, 1, -40)
    startBtn.Text = "LAUNCH FISH ATTACK"
    startBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    startBtn.TextColor3 = Color3.white
    startBtn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", startBtn)

    startBtn.MouseButton1Click:Connect(function()
        if spamming then spamming = false startBtn.Text = "LAUNCH FISH ATTACK" return end
        spamming = true
        startBtn.Text = "🛑 STOPPING..."
        
        local amt = tonumber(inA.Text) or 1
        addLog("Attack Started: " .. amt .. "x")
        
        for i = 1, amt do
            if not spamming then break end
            local w = isRnd and (math.random(1000, 8000)) or tonumber(inW.Text)
            pcall(function()
                ev[_S](ev, {hookPosition = pos, name = inN.Text, rarity = inR.Text, weight = w})
            end)
            if i % 10 == 0 then addLog("Sent: " .. i .. " " .. inN.Text) end
            task.wait(tonumber(inD.Text) or 0.05)
        end
        spamming = false
        startBtn.Text = "LAUNCH FISH ATTACK"
        addLog("Attack Finished.")
    end)

    tglBtn.MouseButton1Click:Connect(function()
        main.Visible = not main.Visible
    end)

    local close = Instance.new("TextButton", main)
    close.Size = UDim2.new(0, 25, 0, 25)
    close.Position = UDim2.new(1, -30, 0, 5)
    close.Text = "X"
    close.BackgroundColor3 = Color3.new(0.6, 0, 0)
    close.TextColor3 = Color3.white
    Instance.new("UICorner", close).CornerRadius = UDim.new(1, 0)
    close.MouseButton1Click:Connect(function() sg:Destroy() end)

    addLog("System Initialized.")
end

-- [[ ADMIN MASS SPAMMER V12 - SOLID BUTTON FIX ]] --
return function()
    if game.CoreGui:FindFirstChild("AdminV12") then game.CoreGui.AdminV12:Destroy() end

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

    local sg = Instance.new("ScreenGui", game.CoreGui); sg.Name = "AdminV12"
    sg.DisplayOrder = 999 -- Memastikan di atas segalanya
    
    -- TOMBOL SHOW/HIDE (SOLID - TIDAK INVIS)
    local tglBtn = Instance.new("ImageButton", sg)
    tglBtn.Size = UDim2.new(0, 60, 0, 60)
    tglBtn.Position = UDim2.new(0, 20, 0.5, -30)
    tglBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255) -- Biru Terang Solid
    tglBtn.Image = "rbxassetid://6031280882" -- Ikon Shield
    tglBtn.ZIndex = 1000 -- Paling depan
    tglBtn.Active = true
    tglBtn.Draggable = true
    Instance.new("UICorner", tglBtn).CornerRadius = UDim.new(1, 0)
    local stroke = Instance.new("UIStroke", tglBtn); stroke.Color = Color3.new(1,1,1); stroke.Thickness = 2

    -- PANEL UTAMA
    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0, 460, 0, 300)
    main.Position = UDim2.new(0.5, -230, 0.5, -150)
    main.BackgroundColor3 = Color3.new(0, 0, 0)
    main.BackgroundTransparency = 0.4 -- Panel tetap invis dikit biar keren
    main.Visible = true
    main.Active = true
    main.Draggable = true
    Instance.new("UICorner", main)

    -- Header
    local header = Instance.new("TextLabel", main)
    header.Size = UDim2.new(1, 0, 0, 35)
    header.Text = "  ADMIN CONTROL V12 (STABLE)"
    header.TextColor3 = Color3.new(1,1,1)
    header.BackgroundColor3 = Color3.fromRGB(30,30,30)
    header.Font = Enum.Font.GothamBold
    header.TextXAlignment = "Left"

    -- Inputs (Solid Background agar teks jelas)
    local function createInp(ph, def, x, y)
        local i = Instance.new("TextBox", main)
        i.Size = UDim2.new(0, 215, 0, 38)
        i.Position = UDim2.new(0, x, 0, y)
        i.Text = def; i.PlaceholderText = ph
        i.BackgroundColor3 = Color3.fromRGB(45, 45, 45) -- Solid
        i.TextColor3 = Color3.new(1,1,1); i.Font = Enum.Font.SourceSans
        i.ClearTextOnFocus = false
        Instance.new("UICorner", i)
        return i
    end

    local inN = createInp("Fish Name", "Goldfish", 10, 45)
    local inR = createInp("Rarity", "Common", 10, 90)
    local inW = createInp("Weight", "5000", 10, 135)
    local inA = createInp("Amount", "100", 10, 180)
    local inD = createInp("Delay", "0.05", 10, 225)

    -- Log Area
    local logBox = Instance.new("ScrollingFrame", main)
    logBox.Size = UDim2.new(0, 215, 0, 175)
    logBox.Position = UDim2.new(0, 235, 0, 45)
    logBox.BackgroundColor3 = Color3.new(0,0,0); logBox.BackgroundTransparency = 0.5
    logBox.CanvasSize = UDim2.new(0,0,10,0)
    Instance.new("UICorner", logBox)

    local function addLog(txt)
        local l = Instance.new("TextLabel", logBox)
        l.Size = UDim2.new(1, 0, 0, 20); l.BackgroundTransparency = 1
        l.Text = "> " .. txt; l.TextColor3 = Color3.new(0,1,0.7); l.TextSize = 12
        l.TextXAlignment = "Left"
        logBox.CanvasPosition = Vector2.new(0, 9999)
    end

    -- Buttons (SOLID - TIDAK INVIS)
    local isRnd = true
    local tglR = Instance.new("TextButton", main)
    tglR.Size = UDim2.new(0, 215, 0, 38)
    tglR.Position = UDim2.new(0, 235, 0, 225)
    tglR.Text = "Random Weight: ON"; tglR.TextColor3 = Color3.new(1,1,1)
    tglR.BackgroundColor3 = Color3.fromRGB(0, 120, 0) -- Solid Hijau
    Instance.new("UICorner", tglR)

    tglR.MouseButton1Click:Connect(function()
        isRnd = not isRnd
        tglR.Text = "Random Weight: " .. (isRnd and "ON" or "OFF")
        tglR.BackgroundColor3 = isRnd and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(150, 0, 0)
    end)

    local spamming = false
    local startBtn = Instance.new("TextButton", main)
    startBtn.Size = UDim2.new(1, -20, 0, 40)
    startBtn.Position = UDim2.new(0, 10, 1, -45)
    startBtn.Text = "START MASS SPAM"; startBtn.Font = Enum.Font.GothamBold
    startBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255) -- Solid Biru
    startBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", startBtn)

    startBtn.MouseButton1Click:Connect(function()
        if spamming then spamming = false startBtn.Text = "START MASS SPAM" return end
        spamming = true; startBtn.Text = "STOP SPAMMING"
        
        local amt = tonumber(inA.Text) or 1
        addLog("Launching spam...")
        
        for i = 1, amt do
            if not spamming then break end
            local w = isRnd and math.random(2000, 9000) or tonumber(inW.Text)
            pcall(function()
                ev[_S](ev, {hookPosition = pos, name = inN.Text, rarity = inR.Text, weight = w})
            end)
            if i % 10 == 0 then addLog("Sent " .. i .. " items") end
            task.wait(tonumber(inD.Text) or 0.05)
        end
        spamming = false; startBtn.Text = "START MASS SPAM"; addLog("Done!")
    end)

    -- Logika Toggle Panel
    tglBtn.MouseButton1Click:Connect(function()
        main.Visible = not main.Visible
        print("Toggle Clicked: " .. tostring(main.Visible)) -- Debugging
    end)

    local cl = Instance.new("TextButton", main)
    cl.Size = UDim2.new(0, 28, 0, 28); cl.Position = UDim2.new(1, -32, 0, 3.5)
    cl.Text = "X"; cl.BackgroundColor3 = Color3.new(0.7,0,0); cl.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", cl).CornerRadius = UDim.new(1,0)
    cl.MouseButton1Click:Connect(function() sg:Destroy() end)

    addLog("System V12 Ready.")
end

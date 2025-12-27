-- [[ ADMIN MASS SPAMMER V9 - LANDSCAPE & LOG EDITION ]] --
return function()
    if game.CoreGui:FindFirstChild("AdminV9") then game.CoreGui.AdminV9:Destroy() end

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

    local sg = Instance.new("ScreenGui", game.CoreGui); sg.Name = "AdminV9"
    
    -- TOMBOL SHOW/HIDE (Floating)
    local tglBtn = Instance.new("TextButton", sg)
    tglBtn.Size = UDim2.new(0, 50, 0, 50)
    tglBtn.Position = UDim2.new(0, 10, 0.5, -25)
    tglBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    tglBtn.Text = "ADM"
    tglBtn.TextColor3 = Color3.new(1, 1, 1)
    tglBtn.Font = Enum.Font.GothamBold
    tglBtn.Draggable = true
    Instance.new("UICorner", tglBtn).CornerRadius = UDim.new(0, 10)

    -- PANEL UTAMA (MODE LANDSCAPE / MELEBAR)
    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0, 450, 0, 280) -- Melebar ke samping
    main.Position = UDim2.new(0.5, -225, 0.5, -140)
    main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    main.Active = true
    main.Draggable = true
    main.Visible = true

    local header = Instance.new("TextLabel", main)
    header.Size = UDim2.new(1, 0, 0, 30)
    header.Text = "  ADMIN PANEL V9 - LANDSCAPE MODE"
    header.TextColor3 = Color3.new(1, 1, 1)
    header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    header.TextXAlignment = "Left"

    -- INPUT AREA (KIRI)
    local function createInp(ph, def, x, y)
        local i = Instance.new("TextBox", main)
        i.Size = UDim2.new(0, 210, 0, 35)
        i.Position = UDim2.new(0, x, 0, y)
        i.Text = def
        i.PlaceholderText = ph
        i.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        i.TextColor3 = Color3.new(1, 1, 1)
        i.ClearTextOnFocus = false
        return i
    end

    local inN = createInp("Fish Name", "Goldfish", 10, 40)
    local inR = createInp("Rarity", "Common", 10, 80)
    local inW = createInp("Manual Weight", "1000", 10, 120)
    local inA = createInp("Amount", "50", 10, 160)
    local inD = createInp("Delay", "0.05", 10, 200)

    -- LOG AREA (KANAN)
    local logBox = Instance.new("ScrollingFrame", main)
    logBox.Size = UDim2.new(0, 210, 0, 155)
    logBox.Position = UDim2.new(0, 230, 0, 40)
    logBox.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    logBox.CanvasSize = UDim2.new(0, 0, 5, 0)
    logBox.ScrollBarThickness = 2

    local logList = Instance.new("UIListLayout", logBox)
    logList.SortOrder = Enum.SortOrder.LayoutOrder

    local function addLog(txt)
        local l = Instance.new("TextLabel", logBox)
        l.Size = UDim2.new(1, 0, 0, 20)
        l.BackgroundTransparency = 1
        l.Text = "> " .. txt
        l.TextColor3 = Color3.fromRGB(0, 255, 150)
        l.TextSize = 12
        l.TextXAlignment = "Left"
        logBox.CanvasPosition = Vector2.new(0, 9999)
    end

    -- TOGGLE & BUTTON (BAWAH KANAN)
    local isRnd = true
    local tglR = Instance.new("TextButton", main)
    tglR.Size = UDim2.new(0, 210, 0, 35)
    tglR.Position = UDim2.new(0, 230, 0, 200)
    tglR.Text = "Random Weight: ON"
    tglR.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    tglR.TextColor3 = Color3.new(1, 1, 1)

    tglR.MouseButton1Click:Connect(function()
        isRnd = not isRnd
        tglR.Text = "Random Weight: " .. (isRnd and "ON" or "OFF")
        tglR.BackgroundColor3 = isRnd and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(120, 0, 0)
    end)

    local spamming = false
    local startBtn = Instance.new("TextButton", main)
    startBtn.Size = UDim2.new(1, -20, 0, 35)
    startBtn.Position = UDim2.new(0, 10, 1, -40)
    startBtn.Text = "START MASS ATTACK"
    startBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 200)
    startBtn.TextColor3 = Color3.new(1, 1, 1)
    startBtn.Font = Enum.Font.GothamBold

    startBtn.MouseButton1Click:Connect(function()
        if spamming then 
            spamming = false
            startBtn.Text = "START MASS ATTACK"
            startBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 200)
            return 
        end
        spamming = true
        startBtn.Text = "🛑 STOP SPAMMING"
        startBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        
        local amt = tonumber(inA.Text) or 1
        local delay = tonumber(inD.Text) or 0.05
        
        addLog("Starting spam: " .. amt .. " fish")
        
        for i = 1, amt do
            if not spamming then break end
            local weightVal = isRnd and (math.random(10000, 50000)/100) or tonumber(inW.Text)
            
            pcall(function()
                ev[_S](ev, {
                    hookPosition = pos,
                    name = inN.Text,
                    rarity = inR.Text,
                    weight = weightVal
                })
            end)
            
            if i % 5 == 0 then addLog("Sent " .. i .. " " .. inN.Text) end
            task.wait(delay)
        end
        
        addLog("Spam Finished!")
        spamming = false
        startBtn.Text = "START MASS ATTACK"
        startBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 200)
    end)

    -- CONTROLS
    tglBtn.MouseButton1Click:Connect(function()
        main.Visible = not main.Visible
    end)

    local close = Instance.new("TextButton", main)
    close.Size = UDim2.new(0, 30, 0, 30)
    close.Position = UDim2.new(1, -30, 0, 0)
    close.Text = "X"
    close.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    close.TextColor3 = Color3.new(1, 1, 1)
    close.MouseButton1Click:Connect(function() sg:Destroy() end)
    
    addLog("Admin V9 Ready.")
end

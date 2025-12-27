-- [[ ADMIN MASS SPAMMER V18 - NO CONSOLE LOGS ]] --
return function()
    -- Hapus UI lama
    local oldUI = game.CoreGui:FindFirstChild("DupeV1")
    if oldUI then oldUI:Destroy() end

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

    local sg = Instance.new("ScreenGui", game.CoreGui)
    sg.Name = "DupeV1"
    sg.DisplayOrder = 999

    -- TOMBOL BUKA/TUTUP (ADM)
    local tglBtn = Instance.new("TextButton", sg)
    tglBtn.Size = UDim2.new(0, 45, 0, 45)
    tglBtn.Position = UDim2.new(0, 15, 0, 120)
    tglBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
    tglBtn.Text = "ADM"
    tglBtn.TextColor3 = Color3.new(1, 1, 1)
    tglBtn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", tglBtn).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", tglBtn).Thickness = 2

    -- PANEL UTAMA
    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0, 440, 0, 280)
    main.Position = UDim2.new(0.5, -220, 0.5, -140)
    main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    main.Visible = true
    main.Active = true
    Instance.new("UICorner", main)

    -- Header
    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, 0, 0, 35)
    title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    title.Text = "  DUPE PANEL- OPTIMIZED"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = "Left"
    Instance.new("UICorner", title)

    -- Fungsi Input
    local function createInp(ph, def, x, y)
        local i = Instance.new("TextBox", main)
        i.Size = UDim2.new(0, 200, 0, 32)
        i.Position = UDim2.new(0, x, 0, y)
        i.Text = def
        i.PlaceholderText = ph
        i.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        i.TextColor3 = Color3.new(1, 1, 1)
        i.ClearTextOnFocus = false
        Instance.new("UICorner", i)
        return i
    end

    local inN = createInp("Name", "El Maja", 15, 45)
    local inR = createInp("Rarity", "Secret", 15, 85)
    local inW = createInp("Manual Weight", "676.7", 15, 125)
    local inA = createInp("Amount", "100", 15, 165)
    local inD = createInp("Delay", "0.05", 15, 205)

    -- Log Area (UI Only, No Console)
    local logBox = Instance.new("ScrollingFrame", main)
    logBox.Size = UDim2.new(0, 200, 0, 152)
    logBox.Position = UDim2.new(0, 225, 0, 45)
    logBox.BackgroundColor3 = Color3.new(0, 0, 0)
    logBox.CanvasSize = UDim2.new(0, 0, 15, 0)
    logBox.ScrollBarThickness = 2
    Instance.new("UICorner", logBox)

    local function addLog(msg)
        local l = Instance.new("TextLabel", logBox)
        l.Size = UDim2.new(1, 0, 0, 18)
        l.BackgroundTransparency = 1
        l.Text = "> " .. msg
        l.TextColor3 = Color3.fromRGB(0, 255, 180)
        l.TextSize = 10
        l.TextXAlignment = "Left"
        logBox.CanvasPosition = Vector2.new(0, 9999)
    end

    -- Toggle Random Weight
    local isRandom = true
    local rndBtn = Instance.new("TextButton", main)
    rndBtn.Size = UDim2.new(0, 200, 0, 32)
    rndBtn.Position = UDim2.new(0, 225, 0, 205)
    rndBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
    rndBtn.Text = "Random Weight: ON"
    rndBtn.TextColor3 = Color3.white
    rndBtn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", rndBtn)

    rndBtn.MouseButton1Click:Connect(function()
        isRandom = not isRandom
        rndBtn.Text = "Random Weight: " .. (isRandom and "ON" or "OFF")
        rndBtn.BackgroundColor3 = isRandom and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0)
        inW.Visible = not isRandom
    end)
    inW.Visible = false

    -- Attack Button
    local spamming = false
    local startBtn = Instance.new("TextButton", main)
    startBtn.Size = UDim2.new(1, -20, 0, 35)
    startBtn.Position = UDim2.new(0, 10, 1, -40)
    startBtn.BackgroundColor3 = Color3.fromRGB(0, 110, 220)
    startBtn.Text = "LAUNCH ATTACK"
    startBtn.TextColor3 = Color3.white
    startBtn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", startBtn)

    startBtn.MouseButton1Click:Connect(function()
        if spamming then spamming = false startBtn.Text = "LAUNCH ATTACK" return end
        spamming = true
        startBtn.Text = "STOPPING..."
        
        local amt = tonumber(inA.Text) or 1
        addLog("Attack Started...")

        for i = 1, amt do
            if not spamming then break end
            
            local finalWeight
            if isRandom then
                local base = math.random(200, 750) 
                local decimal = math.random(1, 9)
                finalWeight = base + (decimal / 10)
            else
                finalWeight = tonumber(inW.Text) or 676.7
            end
            
            -- Pcall digunakan untuk menangkap error tanpa merusak game
            pcall(function()
                ev[_S](ev, {
                    hookPosition = pos,
                    name = inN.Text,
                    rarity = inR.Text,
                    weight = finalWeight
                })
            end)
            
            -- Hanya update log di UI setiap 10 item untuk hemat tenaga HP
            if i % 10 == 0 then addLog("Sent: " .. i .. " [" .. finalWeight .. "]") end
            task.wait(tonumber(inD.Text) or 0.05)
        end
        
        spamming = false
        startBtn.Text = "LAUNCH ATTACK"
        addLog("Done.")
    end)

    tglBtn.MouseButton1Click:Connect(function()
        main.Visible = not main.Visible
    end)

    local cls = Instance.new("TextButton", main)
    cls.Size = UDim2.new(0, 30, 0, 30)
    cls.Position = UDim2.new(1, -35, 0, 2.5)
    cls.Text = "X"
    cls.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    cls.TextColor3 = Color3.white
    Instance.new("UICorner", cls).CornerRadius = UDim.new(1, 0)
    cls.MouseButton1Click:Connect(function() sg:Destroy() end)

    addLog("DUPE Ready (Silent Console)")
end

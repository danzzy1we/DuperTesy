-- [[ ADMIN MASS SPAMMER V8 - ULTRA MINIMALIST ]] --
return function()
    if game.CoreGui:FindFirstChild("AdminV8") then game.CoreGui.AdminV8:Destroy() end

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

    local sg = Instance.new("ScreenGui", game.CoreGui); sg.Name = "AdminV8"
    
    -- Panel Utama (Sangat Sederhana)
    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0, 250, 0, 350)
    main.Position = UDim2.new(0.5, -125, 0.5, -175)
    main.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1) -- Abu-abu gelap polos
    main.Active = true
    main.Draggable = true

    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Text = "ADMIN SPAMMER V8"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)

    -- Fungsi bantu buat Input agar pasti muncul
    local function createInp(txt, def, y)
        local i = Instance.new("TextBox", main)
        i.Size = UDim2.new(0.9, 0, 0, 30)
        i.Position = UDim2.new(0.05, 0, 0, y)
        i.Text = def
        i.PlaceholderText = txt
        i.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
        i.TextColor3 = Color3.new(1, 1, 1)
        i.ClearTextOnFocus = false
        return i
    end

    local inN = createInp("Name", "Goldfish", 40)
    local inR = createInp("Rarity", "Common", 80)
    local inW = createInp("Weight", "1000", 120)
    local inA = createInp("Amount", "50", 160)
    local inD = createInp("Delay", "0.05", 200)

    -- Toggle Sederhana
    local isRnd = true
    local tglR = Instance.new("TextButton", main)
    tglR.Size = UDim2.new(0.9, 0, 0, 30)
    tglR.Position = UDim2.new(0.05, 0, 0, 240)
    tglR.Text = "Random Weight: ON"
    tglR.BackgroundColor3 = Color3.new(0, 0.4, 0)
    tglR.TextColor3 = Color3.new(1, 1, 1)

    tglR.MouseButton1Click:Connect(function()
        isRnd = not isRnd
        tglR.Text = "Random Weight: " .. (isRnd and "ON" or "OFF")
        tglR.BackgroundColor3 = isRnd and Color3.new(0, 0.4, 0) or Color3.new(0.4, 0, 0)
    end)

    -- Start Button
    local spamming = false
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, 280)
    btn.Text = "START SPAM"
    btn.BackgroundColor3 = Color3.new(0, 0.5, 1)
    btn.TextColor3 = Color3.new(1, 1, 1)

    btn.MouseButton1Click:Connect(function()
        if spamming then 
            spamming = false
            btn.Text = "START SPAM"
            return 
        end
        spamming = true
        btn.Text = "STOP"
        
        local count = tonumber(inA.Text) or 1
        local waitT = tonumber(inD.Text) or 0.05
        
        for i = 1, count do
            if not spamming then break end
            local weight = isRnd and (math.random(1000, 5000)) or tonumber(inW.Text)
            
            pcall(function()
                ev[_S](ev, {
                    hookPosition = pos,
                    name = inN.Text,
                    rarity = inR.Text,
                    weight = weight
                })
            end)
            task.wait(waitT)
        end
        spamming = false
        btn.Text = "START SPAM"
    end)

    -- Close
    local ex = Instance.new("TextButton", main)
    ex.Size = UDim2.new(0, 30, 0, 30)
    ex.Position = UDim2.new(1, -30, 0, 0)
    ex.Text = "X"
    ex.BackgroundColor3 = Color3.new(0.8, 0, 0)
    ex.TextColor3 = Color3.new(1, 1, 1)
    ex.MouseButton1Click:Connect(function() sg:Destroy() end)
end

-- [[ DUPEPANEL V20 - TOUCH STABLE EDITION ]] --
return function()
    local player = game:GetService("Players").LocalPlayer
    local pg = player:WaitForChild("PlayerGui")
    
    -- Hapus yang lama agar tidak tumpang tindih
    if pg:FindFirstChild("DupePanelV20") then pg.DupePanelV20:Destroy() end

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

    local sg = Instance.new("ScreenGui", pg)
    sg.Name = "DupePanelV20"
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 99999

    -- TOMBOL BUKA/TUTUP (DIBUAT BESAR & SOLID)
    local tglBtn = Instance.new("TextButton", sg)
    tglBtn.Name = "MainToggle"
    tglBtn.Size = UDim2.new(0, 70, 0, 45) -- Lebih lebar agar mudah dipencet
    tglBtn.Position = UDim2.new(0, 10, 0, 160)
    tglBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Warna Merah agar mencolok
    tglBtn.Text = "DUPE"
    tglBtn.TextColor3 = Color3.new(1, 1, 1)
    tglBtn.Font = Enum.Font.GothamBold
    tglBtn.ZIndex = 100
    Instance.new("UICorner", tglBtn).CornerRadius = UDim.new(0, 5)

    -- PANEL UTAMA
    local main = Instance.new("Frame", sg)
    main.Name = "Panel"
    main.Size = UDim2.new(0, 440, 0, 260)
    main.Position = UDim2.new(0.5, -220, 0.5, -130)
    main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    main.Active = true -- Biar klik tidak tembus ke game
    main.Visible = true 
    Instance.new("UICorner", main)

    -- Header
    local header = Instance.new("TextLabel", main)
    header.Size = UDim2.new(1, 0, 0, 35)
    header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    header.Text = "  DUPEPANEL V20 - LANDSCAPE"
    header.TextColor3 = Color3.new(1, 1, 1)
    header.Font = Enum.Font.GothamBold
    header.TextXAlignment = "Left"

    -- Input Fields
    local function mkInp(ph, def, x, y)
        local i = Instance.new("TextBox", main)
        i.Size = UDim2.new(0, 200, 0, 35)
        i.Position = UDim2.new(0, x, 0, y)
        i.Text = def; i.PlaceholderText = ph
        i.BackgroundColor3 = Color3.fromRGB(45, 45, 45); i.TextColor3 = Color3.new(1,1,1)
        i.ClearTextOnFocus = false; Instance.new("UICorner", i)
        return i
    end

    local inN = mkInp("Fish Name", "Goldfish", 10, 45)
    local inR = mkInp("Rarity", "Common", 10, 85)
    local inW = mkInp("Weight", "5000.2", 10, 125)
    local inA = mkInp("Amount", "100", 10, 165)
    local inD = mkInp("Delay", "0.05", 10, 205)

    -- Log Area
    local logBox = Instance.new("ScrollingFrame", main)
    logBox.Size = UDim2.new(0, 205, 0, 155)
    logBox.Position = UDim2.new(0, 220, 0, 45)
    logBox.BackgroundColor3 = Color3.new(0, 0, 0)
    logBox.ScrollBarThickness = 2
    Instance.new("UICorner", logBox)

    local function addLog(t)
        local l = Instance.new("TextLabel", logBox)
        l.Size = UDim2.new(1, 0, 0, 20); l.BackgroundTransparency = 1
        l.Text = "> " .. t; l.TextColor3 = Color3.new(1, 0.8, 0); l.TextSize = 11
        l.TextXAlignment = "Left"
        logBox.CanvasPosition = Vector2.new(0, 9999)
    end

    -- Random Weight Logic
    local isRnd = true
    local rndBtn = Instance.new("TextButton", main)
    rndBtn.Size = UDim2.new(0, 205, 0, 35); rndBtn.Position = UDim2.new(0, 220, 0, 205)
    rndBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50); rndBtn.Text = "RANDOM: ON"
    rndBtn.TextColor3 = Color3.white; Instance.new("UICorner", rndBtn)

    rndBtn.MouseButton1Click:Connect(function()
        isRnd = not isRnd
        rndBtn.Text = "RANDOM: " .. (isRnd and "ON" or "OFF")
        rndBtn.BackgroundColor3 = isRnd and Color3.fromRGB(0, 150, 50) or Color3.fromRGB(150, 0, 0)
    end)

    -- START BUTTON (DUPE SPAWNER)
    local active = false
    local startBtn = Instance.new("TextButton", main)
    startBtn.Size = UDim2.new(1, -20, 0, 40); startBtn.Position = UDim2.new(0, 10, 1, -45)
    startBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0); startBtn.Text = "START DUPE"
    startBtn.TextColor3 = Color3.white; startBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", startBtn)

    startBtn.MouseButton1Click:Connect(function()
        if active then active = false; startBtn.Text = "START DUPE" return end
        active = true; startBtn.Text = "STOPPING..."
        
        local amt = tonumber(inA.Text) or 1
        addLog("Dupe Started: " .. amt)
        
        for i = 1, amt do
            if not active then break end
            local w = isRnd and (math.random(1000, 9000) + (math.random(1,9)/10)) or tonumber(inW.Text)
            
            pcall(function()
                ev[_S](ev, {
                    hookPosition = pos,
                    name = inN.Text,
                    rarity = inR.Text,
                    weight = w
                })
            end)
            
            if i % 10 == 0 then addLog("Duplicated: " .. i) end
            task.wait(tonumber(inD.Text) or 0.05)
        end
        active = false; startBtn.Text = "START DUPE"; addLog("Finished.")
    end)

    -- Logic Toggle
    tglBtn.Activated:Connect(function() -- Menggunakan Activated bukan MouseButton1Click agar lebih responsif di HP
        main.Visible = not main.Visible
        tglBtn.Text = main.Visible and "CLOSE" or "DUPE"
    end)

    -- Close (X)
    local xBtn = Instance.new("TextButton", main)
    xBtn.Size = UDim2.new(0, 30, 0, 30); xBtn.Position = UDim2.new(1, -35, 0, 3)
    xBtn.Text = "X"; xBtn.BackgroundColor3 = Color3.new(0.5, 0, 0); xBtn.TextColor3 = Color3.white
    Instance.new("UICorner", xBtn).CornerRadius = UDim.new(1, 0)
    xBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

    addLog("DupePanel V20 Ready.")
end

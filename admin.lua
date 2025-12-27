-- [[ ADMIN MASS SPAMMER V19 - EMERGENCY FIX ]] --
return function()
    local player = game:GetService("Players").LocalPlayer
    local function getFolder()
        -- Mencoba CoreGui (Terbaik), kalau gagal pakai PlayerGui
        local success, core = pcall(function() return game:GetService("CoreGui") end)
        if success and core then return core end
        return player:WaitForChild("PlayerGui")
    end

    local parent = getFolder()
    if parent:FindFirstChild("AdminV19") then parent.AdminV19:Destroy() end

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

    -- GUI Dasar
    local sg = Instance.new("ScreenGui")
    sg.Name = "AdminV19"
    sg.ResetOnSpawn = false
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Global
    sg.DisplayOrder = 9999
    sg.Parent = parent

    -- TOMBOL ADM (Dibuat Lebih Tebal & Terlihat)
    local tglBtn = Instance.new("TextButton", sg)
    tglBtn.Size = UDim2.new(0, 50, 0, 50)
    tglBtn.Position = UDim2.new(0, 10, 0, 150)
    tglBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    tglBtn.Text = "OPEN"
    tglBtn.TextColor3 = Color3.new(1, 1, 1)
    tglBtn.Font = Enum.Font.GothamBold
    tglBtn.ZIndex = 10000
    Instance.new("UICorner", tglBtn).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", tglBtn).Thickness = 3

    -- PANEL UTAMA (SOLID & ANTI BUG)
    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0, 420, 0, 260)
    main.Position = UDim2.new(0.5, -210, 0.5, -130)
    main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    main.Visible = true -- Langsung muncul pas di-load
    main.Active = true
    Instance.new("UICorner", main)

    -- Label Header
    local header = Instance.new("TextLabel", main)
    header.Size = UDim2.new(1, 0, 0, 35)
    header.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    header.Text = "  ADMIN PANEL V19 - FIXED"
    header.TextColor3 = Color3.new(1,1,1)
    header.Font = Enum.Font.GothamBold
    header.TextXAlignment = "Left"

    -- Inputs & Buttons
    local function mkInp(ph, def, x, y)
        local i = Instance.new("TextBox", main)
        i.Size = UDim2.new(0, 195, 0, 35)
        i.Position = UDim2.new(0, x, 0, y)
        i.Text = def; i.PlaceholderText = ph
        i.BackgroundColor3 = Color3.fromRGB(50, 50, 50); i.TextColor3 = Color3.new(1,1,1)
        i.ClearTextOnFocus = false; Instance.new("UICorner", i)
        return i
    end

    local inN = mkInp("Fish Name", "El Maja", 10, 45)
    local inR = mkInp("Rarity", "Secret", 10, 85)
    local inW = mkInp("Weight", "500.5", 10, 125)
    local inA = mkInp("Amount", "100", 10, 165)
    local inD = mkInp("Delay", "0.05", 10, 205)

    local logBox = Instance.new("ScrollingFrame", main)
    logBox.Size = UDim2.new(0, 195, 0, 155)
    logBox.Position = UDim2.new(0, 215, 0, 45)
    logBox.BackgroundColor3 = Color3.new(0,0,0)
    Instance.new("UICorner", logBox)

    local function addLog(t)
        local l = Instance.new("TextLabel", logBox)
        l.Size = UDim2.new(1, 0, 0, 20); l.BackgroundTransparency = 1
        l.Text = "> "..t; l.TextColor3 = Color3.new(0,1,0.6); l.TextSize = 10
        l.TextXAlignment = "Left"
        logBox.CanvasPosition = Vector2.new(0, 9999)
    end

    local isRnd = true
    local rnd = Instance.new("TextButton", main)
    rnd.Size = UDim2.new(0, 195, 0, 35); rnd.Position = UDim2.new(0, 215, 0, 205)
    rnd.BackgroundColor3 = Color3.fromRGB(0, 150, 0); rnd.Text = "RND Weight: ON"
    rnd.TextColor3 = Color3.white; Instance.new("UICorner", rnd)

    rnd.MouseButton1Click:Connect(function()
        isRnd = not isRnd
        rnd.Text = "RND Weight: "..(isRnd and "ON" or "OFF")
        rnd.BackgroundColor3 = isRnd and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    end)

    local spam = false
    local start = Instance.new("TextButton", main)
    start.Size = UDim2.new(1, -20, 0, 38); start.Position = UDim2.new(0, 10, 1, -45)
    start.BackgroundColor3 = Color3.fromRGB(0, 100, 255); start.Text = "LAUNCH ATTACK"
    start.TextColor3 = Color3.white; start.Font = Enum.Font.GothamBold; Instance.new("UICorner", start)

    start.MouseButton1Click:Connect(function()
        if spam then spam = false; start.Text = "LAUNCH ATTACK" return end
        spam = true; start.Text = "STOPPING..."
        local a = tonumber(inA.Text) or 1
        for i = 1, a do
            if not spam then break end
            local w = isRnd and (math.random(200, 750) + (math.random(1,9)/10)) or tonumber(inW.Text)
            pcall(function() ev[_S](ev, {hookPosition = pos, name = inN.Text, rarity = inR.Text, weight = w}) end)
            if i % 10 == 0 then addLog("Sent: "..i) end
            task.wait(tonumber(inD.Text) or 0.05)
        end
        spam = false; start.Text = "LAUNCH ATTACK"; addLog("Finished.")
    end)

    -- Toggle Logic Fix
    tglBtn.MouseButton1Click:Connect(function()
        main.Visible = not main.Visible
        tglBtn.Text = main.Visible and "CLOSE" or "OPEN"
    end)

    local x = Instance.new("TextButton", main)
    x.Size = UDim2.new(0, 30, 0, 30); x.Position = UDim2.new(1, -35, 0, 2)
    x.Text = "X"; x.BackgroundColor3 = Color3.new(0.6,0,0); x.TextColor3 = Color3.white
    Instance.new("UICorner", x).CornerRadius = UDim.new(1,0)
    x.MouseButton1Click:Connect(function() sg:Destroy() end)

    addLog("System Fixed V19.")
end

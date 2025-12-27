-- [[ ADMIN MASS SPAMMER V15 - FINAL STABLE ]] --
return function()
    -- Clear UI lama agar tidak menumpuk
    local oldUI = game.CoreGui:FindFirstChild("AdminV15")
    if oldUI then oldUI:Destroy() end

    local _d = function(h)
        local s = ""
        for i in h:gmatch("..") do s = s .. string.char(tonumber(i, 16)) end
        return s
    end

    -- Data Remote
    local _R = _d("5265706c69636174656453746f72616765")
    local _F = _d("46697368696e6753797374656d")
    local _G = _d("466973684769766572")
    local _S = _d("46697265536572766572")

    local ev = game:GetService(_R):WaitForChild(_F):WaitForChild(_G)
    local pos = Vector3.new(1988.84, 450.69, 184.16)

    -- Container Utama
    local sg = Instance.new("ScreenGui")
    sg.Name = "AdminV15"
    sg.Parent = game.CoreGui
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Global
    sg.DisplayOrder = 999

    -- TOMBOL OPEN/CLOSE (Posisi Statis agar tidak Bug)
    local tglBtn = Instance.new("TextButton", sg)
    tglBtn.Name = "Toggle"
    tglBtn.Size = UDim2.new(0, 45, 0, 45)
    tglBtn.Position = UDim2.new(0, 15, 0, 120) -- Di bawah area chat
    tglBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
    tglBtn.Text = "ADM"
    tglBtn.TextColor3 = Color3.new(1, 1, 1)
    tglBtn.Font = Enum.Font.GothamBold
    tglBtn.ZIndex = 100
    tglBtn.Active = true
    Instance.new("UICorner", tglBtn).CornerRadius = UDim.new(0, 10)
    local st = Instance.new("UIStroke", tglBtn)
    st.Color = Color3.new(1,1,1)
    st.Thickness = 2

    -- PANEL UTAMA
    local main = Instance.new("Frame", sg)
    main.Name = "Main"
    main.Size = UDim2.new(0, 420, 0, 250)
    main.Position = UDim2.new(0.5, -210, 0.5, -125)
    main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    main.BorderSizePixel = 0
    main.Visible = true
    main.Active = true
    Instance.new("UICorner", main)

    -- Title
    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, 0, 0, 35)
    title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    title.Text = "  ADMIN PANEL V15 - FIXED"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", title)

    -- Inputs
    local function createInp(ph, def, x, y)
        local i = Instance.new("TextBox", main)
        i.Size = UDim2.new(0, 190, 0, 32)
        i.Position = UDim2.new(0, x, 0, y)
        i.Text = def
        i.PlaceholderText = ph
        i.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        i.TextColor3 = Color3.new(1, 1, 1)
        i.ClearTextOnFocus = false
        Instance.new("UICorner", i).CornerRadius = UDim.new(0, 5)
        return i
    end

    local inN = createInp("Name", "Goldfish", 15, 45)
    local inR = createInp("Rarity", "Common", 15, 85)
    local inW = createInp("Weight", "5000", 15, 125)
    local inA = createInp("Amount", "100", 15, 165)
    local inD = createInp("Delay", "0.05", 15, 205)

    -- Log
    local logBox = Instance.new("ScrollingFrame", main)
    logBox.Size = UDim2.new(0, 190, 0, 152)
    logBox.Position = UDim2.new(0, 215, 0, 45)
    logBox.BackgroundColor3 = Color3.new(0, 0, 0)
    logBox.CanvasSize = UDim2.new(0, 0, 10, 0)
    Instance.new("UICorner", logBox)

    local function addLog(msg)
        local l = Instance.new("TextLabel", logBox)
        l.Size = UDim2.new(1, 0, 0, 18)
        l.BackgroundTransparency = 1
        l.Text = "> " .. msg
        l.TextColor3 = Color3.fromRGB(0, 255, 150)
        l.TextSize = 10
        l.TextXAlignment = Enum.TextXAlignment.Left
        logBox.CanvasPosition = Vector2.new(0, 9999)
    end

    -- Spam Logic
    local spamming = false
    local startBtn = Instance.new("TextButton", main)
    startBtn.Size = UDim2.new(0, 190, 0, 35)
    startBtn.Position = UDim2.new(0, 215, 0, 202)
    startBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    startBtn.Text = "START SPAM"
    startBtn.TextColor3 = Color3.new(1, 1, 1)
    startBtn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", startBtn)

    startBtn.MouseButton1Click:Connect(function()
        if spamming then 
            spamming = false
            startBtn.Text = "START SPAM"
            startBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
            return 
        end
        spamming = true
        startBtn.Text = "STOP"
        startBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        
        local amt = tonumber(inA.Text) or 1
        addLog("Running: " .. amt)
        
        for i = 1, amt do
            if not spamming then break end
            pcall(function()
                ev[_S](ev, {
                    hookPosition = pos,
                    name = inN.Text,
                    rarity = inR.Text,
                    weight = tonumber(inW.Text) or 1000
                })
            end)
            task.wait(tonumber(inD.Text) or 0.05)
        end
        spamming = false
        startBtn.Text = "START SPAM"
        addLog("Finished.")
    end)

    -- Toggle Logic
    tglBtn.MouseButton1Click:Connect(function()
        main.Visible = not main.Visible
    end)

    -- Close Button
    local cls = Instance.new("TextButton", main)
    cls.Size = UDim2.new(0, 30, 0, 30)
    cls.Position = UDim2.new(1, -35, 0, 2.5)
    cls.Text = "X"
    cls.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    cls.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", cls).CornerRadius = UDim.new(1, 0)
    cls.MouseButton1Click:Connect(function() sg:Destroy() end)

    addLog("V15 Loaded.")
end

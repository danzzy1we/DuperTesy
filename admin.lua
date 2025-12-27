-- [[ ADMIN MASS FISH SPAMMER - ENCRYPTED GITHUB EDITION ]] --
return function()
    -- Anti-Duplikasi GUI
    if game.CoreGui:FindFirstChild("AdminSpammerV3") then game.CoreGui.AdminSpammerV3:Destroy() end

    -- [ HEX DECODER ENGINE ]
    local _d = function(h)
        local s = ""
        for i in h:gmatch("..") do s = s .. string.char(tonumber(i, 16)) end
        return s
    end

    -- [ DATA ENKRIPSI ]
    local _R = _d("5265706c69636174656453746f72616765") -- ReplicatedStorage
    local _F = _d("46697368696e6753797374656d")        -- FishingSystem
    local _G = _d("466973684769766572")              -- FishGiver
    local _S = _d("46697265536572766572")              -- FireServer

    -- Koneksi Remote dengan Obfuscated Path
    local st = game:GetService(_R)
    local fd = st:WaitForChild(_F)
    local ev = fd:WaitForChild(_G)
    local pos = Vector3.new(1988.84, 450.69, 184.16)

    -- [ GUI CONSTRUCTION ]
    local sg = Instance.new("ScreenGui", game.CoreGui); sg.Name = "AdminSpammerV3"
    
    local minBtn = Instance.new("TextButton", sg)
    minBtn.Size = UDim2.new(0, 100, 0, 30); minBtn.Position = UDim2.new(0, 10, 0, 10)
    minBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35); minBtn.Text = "SHOW/HIDE"; minBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", minBtn)

    local main = Instance.new("Frame", sg)
    main.Name = "Main"; main.Size = UDim2.new(0, 420, 0, 500); main.Position = UDim2.new(0.5, -210, 0.5, -250)
    main.BackgroundColor3 = Color3.fromRGB(15, 15, 15); main.Active = true; main.Draggable = true
    Instance.new("UICorner", main)

    local header = Instance.new("TextLabel", main)
    header.Size = UDim2.new(1, 0, 0, 45); header.Text = "🛡️ ADMIN SPAMMER (ENCRYPTED)"; header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    header.TextColor3 = Color3.new(1,1,1); header.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", header)

    local scroll = Instance.new("ScrollingFrame", main)
    scroll.Size = UDim2.new(1, -20, 1, -120); scroll.Position = UDim2.new(0, 10, 0, 55)
    scroll.BackgroundTransparency = 1; scroll.CanvasSize = UDim2.new(0,0,1.5,0); scroll.ScrollBarThickness = 2

    local function createBox(ph, def, y)
        local b = Instance.new("TextBox", scroll)
        b.Size = UDim2.new(0.9, 0, 0, 35); b.Position = UDim2.new(0.05, 0, 0, y)
        b.PlaceholderText = ph; b.Text = def; b.BackgroundColor3 = Color3.fromRGB(30, 30, 30); b.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", b); return b
    end

    -- Inputs
    local inN = createBox("Fish Name...", "Goldfish", 10)
    local inR = createBox("Rarity...", "Common", 55)
    local inW = createBox("Manual Weight...", "666.66", 100)
    local inA = createBox("Spam Amount...", "50", 145)
    local inD = createBox("Delay (Sec)...", "0.05", 190)
    local inK = createBox("Keybind (e.g. Q)...", "Q", 235)

    -- Toggles
    local function createTgl(txt, y, def)
        local btn = Instance.new("TextButton", scroll)
        btn.Size = UDim2.new(0.9, 0, 0, 35); btn.Position = UDim2.new(0.05, 0, 0, y)
        btn.Text = txt .. (def and ": ON" or ": OFF")
        btn.BackgroundColor3 = def and Color3.fromRGB(0, 80, 0) or Color3.fromRGB(80, 0, 0)
        btn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", btn); return btn
    end

    local isRnd = true; local tR = createTgl("Random Weight", 280, true)
    tR.MouseButton1Click:Connect(function() isRnd = not isRnd; tR.Text = "Random Weight: "..(isRnd and "ON" or "OFF"); tR.BackgroundColor3 = isRnd and Color3.fromRGB(0,80,0) or Color3.fromRGB(80,0,0) end)

    local isDly = true; local tD = createTgl("Use Delay", 325, true)
    tD.MouseButton1Click:Connect(function() isDly = not isDly; tD.Text = "Use Delay: "..(isDly and "ON" or "OFF"); tD.BackgroundColor3 = isDly and Color3.fromRGB(0,80,0) or Color3.fromRGB(80,0,0) end)

    -- Info Display
    local iD = Instance.new("TextLabel", main)
    iD.Size = UDim2.new(0.8, 0, 0.4, 0); iD.Position = UDim2.new(0.1, 0, 0.3, 0)
    iD.BackgroundColor3 = Color3.fromRGB(5, 5, 5); iD.TextColor3 = Color3.new(0, 1, 0); iD.TextSize = 12; iD.BorderSizePixel = 1
    iD.Text = "ADMIN INFO:\n- Masukkan Nama/Rarity ikan.\n- Keybind berfungsi saat panel terlihat/tersembunyi.\n- Gunakan delay 0.05+ untuk stabilitas.\n- Mode Encrypted aktif."; iD.Visible = false; iD.ZIndex = 10
    Instance.new("UICorner", iD)

    local iB = createTgl("View Information", 370, false); iB.BackgroundColor3 = Color3.fromRGB(50,50,50)
    iB.MouseButton1Click:Connect(function() iD.Visible = not iD.Visible end)

    -- EXECUTION ENGINE
    local start = Instance.new("TextButton", main)
    start.Size = UDim2.new(1, -20, 0, 45); start.Position = UDim2.new(0, 10, 1, -55)
    start.Text = "START MASS ATTACK"; start.BackgroundColor3 = Color3.fromRGB(0, 100, 200); start.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", start)

    local function runSpam()
        local amt = tonumber(inA.Text) or 1
        local waitT = tonumber(inD.Text) or 0.05
        start.Text = "EXECUTING..."; start.BackgroundColor3 = Color3.fromRGB(150, 50, 0)
        
        for i = 1, amt do
            local wV = isRnd and (math.random(10000, 80000)/100) or (tonumber(inW.Text) or 100)
            
            -- Pemanggilan Remote Terenkripsi
            ev[_S](ev, {
                hookPosition = pos,
                name = inN.Text,
                rarity = inR.Text,
                weight = wV
            })
            
            if isDly then task.wait(waitT) end
        end
        start.Text = "START MASS ATTACK"; start.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    end

    start.MouseButton1Click:Connect(runSpam)

    -- Keyboard Keybind Listener
    game:GetService("UserInputService").InputBegan:Connect(function(inp, p)
        if not p and inp.KeyCode.Name == inK.Text:upper() then runSpam() end
    end)

    -- Controls
    minBtn.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
    local cl = Instance.new("TextButton", main); cl.Size = UDim2.new(0, 30, 0, 30); cl.Position = UDim2.new(1, -35, 0, 5); cl.Text = "X"; cl.BackgroundColor3 = Color3.new(0.5,0,0); cl.TextColor3 = Color3.new(1,1,1); cl.ZIndex = 6
    cl.MouseButton1Click:Connect(function() sg:Destroy() end)
end

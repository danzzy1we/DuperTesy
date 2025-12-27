-- [[ ADMIN MASS FISH SPAMMER - GITHUB EDITION ]] --
return function()
    -- Pembersihan GUI lama
    if game.CoreGui:FindFirstChild("AdminSpammer") then game.CoreGui.AdminSpammer:Destroy() end

    -- [ ENKRIPSI REMOTES ]
    local _d = function(h)
        local s = ""
        for i in h:gmatch("..") do s = s .. string.char(tonumber(i, 16)) end
        return s
    end

    local _RS = _d("5265706c69636174656453746f72616765")
    local _FY = _d("46697368696e6753797374656d")
    local _YG = _d("32333436323334374738323335")
    local _FS = _d("46697265536572766572")

    local Event = game:GetService(_RS):WaitForChild(_FY):WaitForChild(_YG)
    local pos = Vector3.new(1988.84, 450.69, 184.16)

    -- [ GUI MAIN WINDOW ]
    local sg = Instance.new("ScreenGui", game.CoreGui); sg.Name = "AdminSpammer"
    
    local minBtn = Instance.new("TextButton", sg)
    minBtn.Size = UDim2.new(0, 100, 0, 30); minBtn.Position = UDim2.new(0, 10, 0, 10)
    minBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); minBtn.Text = "SHOW/HIDE"; minBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", minBtn)

    local main = Instance.new("Frame", sg)
    main.Name = "Main"; main.Size = UDim2.new(0, 400, 0, 480); main.Position = UDim2.new(0.5, -200, 0.5, -240)
    main.BackgroundColor3 = Color3.fromRGB(25, 25, 25); main.Active = true; main.Draggable = true
    Instance.new("UICorner", main)

    -- HEADER
    local header = Instance.new("TextLabel", main)
    header.Size = UDim2.new(1, 0, 0, 40); header.Text = "🐟 ADMIN MASS SPAMMER"; header.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    header.TextColor3 = Color3.new(1,1,1); header.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", header)

    -- CONTAINER SCROLL (Agar muat banyak input)
    local scroll = Instance.new("ScrollingFrame", main)
    scroll.Size = UDim2.new(1, -20, 1, -100); scroll.Position = UDim2.new(0, 10, 0, 50)
    scroll.BackgroundTransparency = 1; scroll.CanvasSize = UDim2.new(0,0,1.2,0); scroll.ScrollBarThickness = 4

    local function createInput(name, placeholder, default, pos)
        local txt = Instance.new("TextBox", scroll)
        txt.Name = name; txt.Size = UDim2.new(0.9, 0, 0, 35); txt.Position = pos
        txt.PlaceholderText = placeholder; txt.Text = default
        txt.BackgroundColor3 = Color3.fromRGB(35, 35, 35); txt.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", txt)
        return txt
    end

    -- INPUTS
    local inName = createInput("Name", "Fish Name...", "Goldfish", UDim2.new(0.05, 0, 0, 10))
    local inRarity = createInput("Rarity", "Rarity...", "Common", UDim2.new(0.05, 0, 0, 55))
    local inWeight = createInput("Weight", "Custom Weight...", "500.00", UDim2.new(0.05, 0, 0, 100))
    local inAmount = createInput("Amount", "Spam Amount...", "100", UDim2.new(0.05, 0, 0, 145))
    local inWait = createInput("Wait", "Jeda (detik)...", "0.05", UDim2.new(0.05, 0, 0, 190))

    -- TOGGLES
    local function createToggle(text, pos, default)
        local btn = Instance.new("TextButton", scroll)
        btn.Size = UDim2.new(0.9, 0, 0, 35); btn.Position = pos
        btn.Text = text .. (default and ": ON" or ": OFF")
        btn.BackgroundColor3 = default and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(100, 0, 0)
        btn.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", btn)
        return btn
    end

    local tglRandom = createToggle("Random Weight", UDim2.new(0.05, 0, 0, 235), true)
    local isRandom = true
    tglRandom.MouseButton1Click:Connect(function()
        isRandom = not isRandom
        tglRandom.Text = "Random Weight: " .. (isRandom and "ON" or "OFF")
        tglRandom.BackgroundColor3 = isRandom and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(100, 0, 0)
    end)

    local tglWait = createToggle("Use Jeda", UDim2.new(0.05, 0, 0, 280), true)
    local useWait = true
    tglWait.MouseButton1Click:Connect(function()
        useWait = not useWait
        tglWait.Text = "Use Jeda: " .. (useWait and "ON" or "OFF")
        tglWait.BackgroundColor3 = useWait and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(100, 0, 0)
    end)

    -- INFO BUTTON
    local infoBtn = createToggle("ℹ️ View Information", UDim2.new(0.05, 0, 0, 325), false)
    infoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    
    infoBtn.MouseButton1Click:Connect(function()
        local info = Instance.new("MessageDialog", sg) -- Simple alert for info
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ADMIN INFO",
            Text = "Gunakan jeda minimal 0.05 agar tidak crash. Spam Global tidak ada di sini.",
            Duration = 5
        })
    end)

    -- KEYBINDS (Fungsi agar user bisa menekan tombol tertentu)
    local keyInput = createInput("Key", "Activation Key (e.g. K)", "K", UDim2.new(0.05, 0, 0, 370))

    -- EXECUTE BUTTON
    local startBtn = Instance.new("TextButton", main)
    startBtn.Size = UDim2.new(1, -20, 0, 40); startBtn.Position = UDim2.new(0, 10, 1, -50)
    startBtn.Text = "🚀 START MASS SPAM"; startBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    startBtn.TextColor3 = Color3.new(1,1,1); startBtn.Font = "SourceSansBold"
    Instance.new("UICorner", startBtn)

    local function doSpam()
        local amount = tonumber(inAmount.Text) or 10
        local delayTime = tonumber(inWait.Text) or 0.05
        
        startBtn.Text = "SPAMMING..."; startBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
        
        for i = 1, amount do
            local finalWeight = isRandom and (math.random(10000, 60000) / 100) or tonumber(inWeight.Text)
            
            Event[_FS](Event, {
                hookPosition = pos,
                name = inName.Text,
                rarity = inRarity.Text,
                weight = finalWeight
            })
            
            if useWait then task.wait(delayTime) end
        end
        
        startBtn.Text = "🚀 START MASS SPAM"; startBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    end

    startBtn.MouseButton1Click:Connect(doSpam)

    -- KEY ACTIVATION LOGIC
    game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode.Name == keyInput.Text:upper() then
            doSpam()
        end
    end)

    -- MINIMIZE & CLOSE
    minBtn.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
    
    local cl = Instance.new("TextButton", main); cl.Size = UDim2.new(0, 30, 0, 30); cl.Position = UDim2.new(1, -35, 0, 5)
    cl.Text = "X"; cl.BackgroundColor3 = Color3.new(0.6,0,0); cl.TextColor3 = Color3.new(1,1,1)
    cl.MouseButton1Click:Connect(function() sg:Destroy() end)
end

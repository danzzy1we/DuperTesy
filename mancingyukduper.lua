-- [[ INDEPENDENT CONTROL PANEL - ULTIMATE EDITION ]] --
return function()
    -- Pembersihan GUI lama jika ada
    if game.CoreGui:FindFirstChild("AdminUltimate") then game.CoreGui.AdminUltimate:Destroy() end

    local _d = function(h)
        local s = ""
        for i in h:gmatch("..") do s = s .. string.char(tonumber(i, 16)) end
        return s
    end

    -- [ KONFIGURASI ]
    local WebhookURL = "https://discord.com/api/webhooks/1454338348117131402/Q_t7s4SYXv0szW5-XlKajMkX7cCbMn9efYDAxFWMTksZLaeoKEHG_iIVCb9R1fDtdkSP" 
    local CooldownTime = 3 

    -- [ ENKRIPSI REMOTES ]
    local _RS = _d("5265706c69636174656453746f72616765") -- ReplicatedStorage
    local _FY = _d("46697368696e6753797374656d")        -- FishingSystem
    local _YG = _d("32333436323334374738323335")        -- 23462347G8235
    local _PF = _d("5075626c697368466973684361746368")    -- PublishFishCatch
    local _FS = _d("46697265536572766572")              -- FireServer

    local st = game:GetService(_RS)
    local Folder = st:WaitForChild(_FY)
    local pos = Vector3.new(1988.84, 450.69, 184.16)

    -- [ FUNGSI WEBHOOK ]
    local function sendLog(mode, name, weight, rarity)
        if WebhookURL == "" or WebhookURL:find("URL_WEBHOOK") then return end
        local requestFunc = (syn and syn.request) or (http and http.request) or http_request or request
        if requestFunc then
            task.spawn(function()
                pcall(function()
                    requestFunc({
                        Url = WebhookURL, Method = "POST",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = game:GetService("HttpService"):JSONEncode({
                            ["embeds"] = {{
                                ["title"] = "🎣 Mancing Yuk Log: " .. mode,
                                ["color"] = mode == "PRIVATE" and 0x00AAFF or 0xFF0000,
                                ["fields"] = {
                                    {["name"] = "Ikan", ["value"] = name, ["inline"] = true},
                                    {["name"] = "Berat", ["value"] = weight .. " kg", ["inline"] = true},
                                    {["name"] = "Rarity", ["value"] = rarity, ["inline"] = true}
                                },
                                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
                            }}
                        })
                    })
                end)
            end)
        end
    end

    -- [ GUI MAIN WINDOW ]
    local sg = Instance.new("ScreenGui", game.CoreGui); sg.Name = "AdminUltimate"
    
    -- Tombol Minimize
    local minBtn = Instance.new("TextButton", sg)
    minBtn.Size = UDim2.new(0, 100, 0, 30); minBtn.Position = UDim2.new(0, 10, 0, 10)
    minBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); minBtn.Text = "HIDE PANEL"; minBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 8)

    local main = Instance.new("Frame", sg)
    main.Name = "Main"; main.Size = UDim2.new(0, 500, 0, 380)
    main.Position = UDim2.new(0.5, -250, 0.5, -190); main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    main.Active = true; main.Draggable = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

    -- HEADER
    local header = Instance.new("TextLabel", main)
    header.Size = UDim2.new(1, 0, 0, 35); header.Text = " ADMIN ALL-IN-ONE PANEL"; header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    header.TextColor3 = Color3.new(1,1,1); header.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

    -- INPUT AREA
    local inputFrame = Instance.new("Frame", main)
    inputFrame.Size = UDim2.new(1, -20, 0, 110); inputFrame.Position = UDim2.new(0, 10, 0, 45)
    inputFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30); inputFrame.BorderSizePixel = 0

    local inName = Instance.new("TextBox", inputFrame)
    inName.Size = UDim2.new(0.3, 0, 0, 35); inName.Position = UDim2.new(0.02, 0, 0.1, 0)
    inName.Text = "El Maja"; inName.BackgroundColor3 = Color3.fromRGB(45,45,45); inName.TextColor3 = Color3.new(1,1,1)

    local inWeight = Instance.new("TextBox", inputFrame)
    inWeight.Size = UDim2.new(0.3, 0, 0, 35); inWeight.Position = UDim2.new(0.35, 0, 0.1, 0)
    inWeight.Text = "669.48"; inWeight.BackgroundColor3 = Color3.fromRGB(45,45,45); inWeight.TextColor3 = Color3.new(1,1,1)

    local inRarity = Instance.new("TextBox", inputFrame)
    inRarity.Size = UDim2.new(0.3, 0, 0, 35); inRarity.Position = UDim2.new(0.68, 0, 0.1, 0)
    inRarity.Text = "Secret"; inRarity.BackgroundColor3 = Color3.fromRGB(45,45,45); inRarity.TextColor3 = Color3.new(1,1,1)

    local randomCheck = Instance.new("TextButton", inputFrame)
    randomCheck.Size = UDim2.new(0.96, 0, 0, 30); randomCheck.Position = UDim2.new(0.02, 0, 0.55, 0)
    randomCheck.Text = "Randomize Weight: ON"; randomCheck.BackgroundColor3 = Color3.fromRGB(0, 120, 0); randomCheck.TextColor3 = Color3.new(1,1,1)
    
    local isRandom = true
    randomCheck.MouseButton1Click:Connect(function()
        isRandom = not isRandom
        randomCheck.Text = isRandom and "Randomize Weight: ON" or "Randomize Weight: OFF"
        randomCheck.BackgroundColor3 = isRandom and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(120, 0, 0)
    end)

    -- LOG AREAS
    local function createScroll(pos)
        local s = Instance.new("ScrollingFrame", main)
        s.Size = UDim2.new(0.48, -5, 0, 180); s.Position = pos
        s.BackgroundColor3 = Color3.new(0,0,0); s.BackgroundTransparency = 0.6; s.BorderSizePixel = 0
        local l = Instance.new("UIListLayout", s); l.Padding = UDim.new(0, 5)
        return s
    end

    local leftLog = createScroll(UDim2.new(0, 10, 0, 190))
    local rightLog = createScroll(UDim2.new(0.5, 5, 0, 190))

    -- BUTTONS
    local spawnBtn = Instance.new("TextButton", main)
    spawnBtn.Size = UDim2.new(0.48, -5, 0, 30); spawnBtn.Position = UDim2.new(0, 10, 0, 155)
    spawnBtn.Text = "PRIVATE SPAWN"; spawnBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 150); spawnBtn.TextColor3 = Color3.new(1,1,1)

    local pubBtn = Instance.new("TextButton", main)
    pubBtn.Size = UDim2.new(0.48, -5, 0, 30); pubBtn.Position = UDim2.new(0.5, 5, 0, 155)
    pubBtn.Text = "PUBLISH GLOBAL"; pubBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0); pubBtn.TextColor3 = Color3.new(1,1,1)

    local function addCard(parent, color)
        local w = isRandom and string.format("%.2f", (math.random(30000, 60000)/100)) or inWeight.Text
        local card = Instance.new("TextLabel", parent)
        card.Size = UDim2.new(1, -5, 0, 50); card.BackgroundColor3 = Color3.new(1,1,1); card.BackgroundTransparency = 0.85
        card.TextColor3 = color; card.TextSize = 11; card.Font = "SourceSansBold"; card.TextXAlignment = "Left"
        card.Text = string.format("  IKAN: %s\n  UKURAN: %s kg\n  RARITY: %s", inName.Text, w, inRarity.Text)
        
        parent.CanvasSize = UDim2.new(0, 0, 0, parent.UIListLayout.AbsoluteContentSize.Y)
        return w
    end

    -- COOLDOWN LOGIC & EXECUTION
    local function checkCD()
        if _G.AdminCD and tick() - _G.AdminCD < CooldownTime then return false end
        _G.AdminCD = tick()
        return true
    end

    spawnBtn.MouseButton1Click:Connect(function()
        if not checkCD() then return end
        local w = addCard(leftLog, Color3.fromRGB(100, 200, 255))
        Folder[_YG][_FS](Folder[_YG], {hookPosition = pos, name = inName.Text, rarity = inRarity.Text, weight = tonumber(w)})
        sendLog("PRIVATE", inName.Text, w, inRarity.Text)
    end)

    pubBtn.MouseButton1Click:Connect(function()
        if not checkCD() then return end
        local w = addCard(rightLog, Color3.fromRGB(255, 150, 150))
        Folder[_PF][_FS](Folder[_PF], unpack({inName.Text, tonumber(w), inRarity.Text}))
        sendLog("GLOBAL", inName.Text, w, inRarity.Text)
    end)

    -- MINIMIZE LOGIC
    minBtn.MouseButton1Click:Connect(function()
        main.Visible = not main.Visible
        minBtn.Text = main.Visible and "HIDE PANEL" or "SHOW PANEL"
    end)
    
    -- CLOSE BUTTON
    local cl = Instance.new("TextButton", main); cl.Size = UDim2.new(0, 25, 0, 25); cl.Position = UDim2.new(1, -25, 0, 0); cl.Text = "X"; cl.BackgroundColor3 = Color3.new(0.6,0,0); cl.TextColor3 = Color3.new(1,1,1); cl.ZIndex = 5
    cl.MouseButton1Click:Connect(function() sg:Destroy() end)
end

-- [[ PRIVATE SPAWN - FIX GUI NOT SHOWING ]] --
return function()
    -- Pembersihan otomatis jika GUI sudah ada (agar tidak double/nyangkut)
    if game.CoreGui:FindFirstChild("AdminPanel") then
        game.CoreGui.AdminPanel:Destroy()
    end

    local _d = function(h)
        local s = ""
        for i in h:gmatch("..") do s = s .. string.char(tonumber(i, 16)) end
        return s
    end

    -- [ KONFIGURASI ]
    local WebhookURL = "https://discord.com/api/webhooks/1454133282072690843/aQWzcsHi777qThK7qAyRVYkUY02fNXgfd7UehXwfHVQMPfWbv-OO2c2dYuToE1FwCFXP" 
    local CooldownTime = 1 

    -- [ ENKRIPSI REMOTES ]
    local _RS, _FY, _YG, _FS = _d("5265706c69636174656453746f72616765"), _d("46697368696e67596168696b6f"), _d("596168696b6f4769766572"), _d("46697265536572766572")
    local st = game:GetService(_RS)
    local Folder = st:WaitForChild(_FY)
    local pos = Vector3.new(1988.84, 450.69, 184.16)

    -- [ WEBHOOK LOGIC ]
    local function sendWebhook(name, weight, rarity)
        if WebhookURL == "" or WebhookURL:find("URL_WEBHOOK") then return end
        local requestFunc = (syn and syn.request) or (http and http.request) or http_request or request
        if requestFunc then
            task.spawn(function()
                pcall(function()
                    requestFunc({
                        Url = WebhookURL,
                        Method = "POST",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = game:GetService("HttpService"):JSONEncode({
                            ["embeds"] = {{
                                ["title"] = "🎣 **Private Spawn Success**",
                                ["color"] = 0x00AAFF,
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

    -- [ GUI MAIN ]
    local sg = Instance.new("ScreenGui")
    sg.Name = "AdminPanel"
    sg.Parent = (game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
    sg.ResetOnSpawn = false

    local main = Instance.new("Frame", sg)
    main.Name = "Main"; main.Size = UDim2.new(0, 320, 0, 480)
    main.Position = UDim2.new(0.5, -160, 0.5, -240)
    main.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
    main.BorderSizePixel = 0
    main.Active = true; main.Draggable = true

    local cMain = Instance.new("UICorner", main); cMain.CornerRadius = UDim.new(0, 15)
    local sMain = Instance.new("UIStroke", main); sMain.Color = Color3.fromRGB(0, 170, 255); sMain.Thickness = 2

    -- Minimize Button
    local toggle = Instance.new("TextButton", sg)
    toggle.Size = UDim2.new(0, 100, 0, 30); toggle.Position = UDim2.new(0, 20, 0, 20)
    toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 255); toggle.Text = "HIDE PANEL"; toggle.TextColor3 = Color3.new(1,1,1)
    toggle.Font = "SourceSansBold"; toggle.ZIndex = 10
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 8)

    -- Header
    local head = Instance.new("TextLabel", main)
    head.Size = UDim2.new(1, 0, 0, 50); head.Text = "PREMIUM SPAWNER"; head.TextColor3 = Color3.new(1,1,1)
    head.Font = "SourceSansBold"; head.TextSize = 18; head.BackgroundTransparency = 1

    -- Input Area
    local function createInput(placeholder, text, pos)
        local box = Instance.new("TextBox", main)
        box.Size = UDim2.new(1, -40, 0, 35); box.Position = UDim2.new(0, 20, 0, pos)
        box.PlaceholderText = placeholder; box.Text = text
        box.BackgroundColor3 = Color3.fromRGB(25, 25, 30); box.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
        return box
    end

    local inName = createInput("Fish Name...", "El Maja", 60)
    local inRarity = createInput("Rarity...", "Secret", 105)
    local inWeight = createInput("Weight...", "669.48", 150)
    inWeight.Visible = false

    local randBtn = Instance.new("TextButton", main)
    randBtn.Size = UDim2.new(1, -40, 0, 35); randBtn.Position = UDim2.new(0, 20, 0, 195)
    randBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100); randBtn.Text = "RANDOM WEIGHT: ON"; randBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", randBtn).CornerRadius = UDim.new(0, 8)

    local isRandom = true
    randBtn.MouseButton1Click:Connect(function()
        isRandom = not isRandom
        randBtn.Text = isRandom and "RANDOM WEIGHT: ON" or "RANDOM WEIGHT: OFF"
        randBtn.BackgroundColor3 = isRandom and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(180, 50, 50)
        inWeight.Visible = not isRandom
    end)

    local spawnBtn = Instance.new("TextButton", main)
    spawnBtn.Size = UDim2.new(1, -40, 0, 50); spawnBtn.Position = UDim2.new(0, 20, 0, 260)
    spawnBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255); spawnBtn.Text = "SPAWN FISH"; spawnBtn.TextColor3 = Color3.new(1,1,1)
    spawnBtn.Font = "SourceSansBold"
    Instance.new("UICorner", spawnBtn).CornerRadius = UDim.new(0, 10)

    local logArea = Instance.new("ScrollingFrame", main)
    logArea.Size = UDim2.new(1, -40, 0, 140); logArea.Position = UDim2.new(0, 20, 0, 320)
    logArea.BackgroundTransparency = 1; logArea.ScrollBarThickness = 0
    local layout = Instance.new("UIListLayout", logArea); layout.Padding = UDim.new(0, 5)

    spawnBtn.MouseButton1Click:Connect(function()
        if _G.AdminCD and tick() - _G.AdminCD < CooldownTime then return end
        _G.AdminCD = tick()

        local weightUsed = isRandom and string.format("%.2f", (math.random(30000, 70000)/100)) or inWeight.Text
        Folder[_YG][_FS](Folder[_YG], {hookPosition = pos, name = inName.Text, rarity = inRarity.Text, weight = tonumber(weightUsed)})
        sendWebhook(inName.Text, weightUsed, inRarity.Text)

        local card = Instance.new("Frame", logArea)
        card.Size = UDim2.new(1, -5, 0, 50); card.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)
        local l = Instance.new("TextLabel", card); l.Size = UDim2.new(1, -10, 1, 0); l.Position = UDim2.new(0, 10, 0, 0)
        l.BackgroundTransparency = 1; l.TextColor3 = Color3.new(1,1,1); l.TextXAlignment = "Left"; l.TextSize = 12
        l.Text = "🐟 " .. inName.Text .. " | " .. weightUsed .. "kg | " .. inRarity.Text
        
        logArea.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
    end)

    toggle.MouseButton1Click:Connect(function()
        main.Visible = not main.Visible
        toggle.Text = main.Visible and "HIDE PANEL" or "SHOW PANEL"
    end)
end

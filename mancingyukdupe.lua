-- [[ PREMIUM PRIVATE - ENCRYPTED ]] --
return function()
    -- Pembersihan otomatis GUI lama
    if game.CoreGui:FindFirstChild("AdminPanel") then game.CoreGui.AdminPanel:Destroy() end

    local _d = function(h)
        local s = ""
        for i in h:gmatch("..") do s = s .. string.char(tonumber(i, 16)) end
        return s
    end

    -- [ KONFIGURASI ]
    local WebhookURL = "https://discord.com/api/webhooks/1454133282072690843/aQWzcsHi777qThK7qAyRVYkUY02fNXgfd7UehXwfHVQMPfWbv-OO2c2dYuToE1FwCFXP" 
    local CooldownTime = 1 

    -- [ ENKRIPSI REMOTES BARU ]
    local _RS = _d("5265706c69636174656453746f72616765") -- ReplicatedStorage
    local _FSY = _d("46697368696e6753797374656d")        -- FishingSystem (Folder)
    local _FGV = _d("466973684769766572")              -- FishGiver (Remote)
    local _SRV = _d("46697265536572766572")              -- FireServer

    local st = game:GetService(_RS)
    local Folder = st:WaitForChild(_FSY)
    local pos = Vector3.new(1988.84, 450.69, 184.16)

    -- [ WEBHOOK SYSTEM ]
    local function sendWebhook(name, weight, rarity)
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
                                ["title"] = "🎣 **Private Fish Spawned**",
                                ["color"] = 0x00CCFF,
                                ["fields"] = {
                                    {["name"] = "Ikan", ["value"] = "```" .. name .. "```", ["inline"] = true},
                                    {["name"] = "Berat", ["value"] = "```" .. weight .. " kg```", ["inline"] = true},
                                    {["name"] = "Rarity", ["value"] = "```" .. rarity .. "```", ["inline"] = true}
                                },
                                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
                            }}
                        })
                    })
                end)
            end)
        end
    end

    -- [ GUI BUILDER - PREMIUM ]
    local sg = Instance.new("ScreenGui", game.CoreGui); sg.Name = "AdminPanel"
    
    -- Minimize Button
    local toggle = Instance.new("TextButton", sg)
    toggle.Size = UDim2.new(0, 100, 0, 30); toggle.Position = UDim2.new(0, 20, 0, 20)
    toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 255); toggle.Text = "HIDE PANEL"; toggle.TextColor3 = Color3.new(1,1,1)
    toggle.Font = "SourceSansBold"; Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 8)

    local main = Instance.new("Frame", sg)
    main.Name = "Main"; main.Size = UDim2.new(0, 300, 0, 420); main.Position = UDim2.new(0.5, -150, 0.5, -210)
    main.BackgroundColor3 = Color3.fromRGB(15, 15, 20); main.Active = true; main.Draggable = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 15)
    local stroke = Instance.new("UIStroke", main); stroke.Color = Color3.fromRGB(0, 200, 255); stroke.Thickness = 2

    local head = Instance.new("TextLabel", main)
    head.Size = UDim2.new(1, 0, 0, 50); head.Text = "ADMIN PRIVATE PANEL"; head.TextColor3 = Color3.new(1,1,1)
    head.Font = "SourceSansBold"; head.TextSize = 18; head.BackgroundTransparency = 1

    -- Input Area
    local function createInput(placeholder, text, pos)
        local box = Instance.new("TextBox", main)
        box.Size = UDim2.new(1, -40, 0, 35); box.Position = UDim2.new(0, 20, 0, pos)
        box.PlaceholderText = placeholder; box.Text = text; box.BackgroundColor3 = Color3.fromRGB(30, 30, 35); box.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
        return box
    end

    local inName = createInput("Fish Name...", "El Maja", 60)
    local inRarity = createInput("Rarity...", "Secret", 105)
    local inWeight = createInput("Manual Weight...", "669.48", 150); inWeight.Visible = false

    local randBtn = Instance.new("TextButton", main)
    randBtn.Size = UDim2.new(1, -40, 0, 35); randBtn.Position = UDim2.new(0, 20, 0, 150)
    randBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100); randBtn.Text = "RANDOM WEIGHT: ON"; randBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", randBtn).CornerRadius = UDim.new(0, 8)

    local isRandom = true
    randBtn.MouseButton1Click:Connect(function()
        isRandom = not isRandom
        randBtn.Text = isRandom and "RANDOM WEIGHT: ON" or "RANDOM WEIGHT: OFF"
        randBtn.BackgroundColor3 = isRandom and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(200, 50, 50)
        inWeight.Visible = not isRandom
        -- Adjust position if manual visible
        if not isRandom then inWeight.Position = UDim2.new(0, 20, 0, 195) end
    end)

    local spawnBtn = Instance.new("TextButton", main)
    spawnBtn.Size = UDim2.new(1, -40, 0, 50); spawnBtn.Position = UDim2.new(0, 20, 0, 240)
    spawnBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255); spawnBtn.Text = "SPAWN FISH"; spawnBtn.TextColor3 = Color3.new(1,1,1); spawnBtn.Font = "SourceSansBold"
    Instance.new("UICorner", spawnBtn).CornerRadius = UDim.new(0, 10)

    local logArea = Instance.new("ScrollingFrame", main)
    logArea.Size = UDim2.new(1, -40, 0, 110); logArea.Position = UDim2.new(0, 20, 0, 300)
    logArea.BackgroundTransparency = 1; logArea.ScrollBarThickness = 2
    local layout = Instance.new("UIListLayout", logArea); layout.Padding = UDim.new(0, 5)

    spawnBtn.MouseButton1Click:Connect(function()
        if _G.AdminCD and tick() - _G.AdminCD < CooldownTime then 
            spawnBtn.Text = "WAIT ("..math.ceil(CooldownTime-(tick()-_G.AdminCD)).."s)"; task.wait(0.5) spawnBtn.Text = "SPAWN FISH"
            return 
        end
        _G.AdminCD = tick()

        local w = isRandom and string.format("%.2f", (math.random(30000, 70000)/100)) or inWeight.Text
        
        -- EXECUTE ENCRYPTED REMOTE
        Folder[_FGV][_SRV](Folder[_FGV], {hookPosition = pos, name = inName.Text, rarity = inRarity.Text, weight = tonumber(w)})
        
        sendWebhook(inName.Text, w, inRarity.Text)

        -- CARD LOG
        local card = Instance.new("Frame", logArea)
        card.Size = UDim2.new(1, -5, 0, 45); card.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)
        local l = Instance.new("TextLabel", card); l.Size = UDim2.new(1, -10, 1, 0); l.Position = UDim2.new(0, 10, 0, 0); l.BackgroundTransparency = 1; l.TextColor3 = Color3.new(1,1,1); l.TextXAlignment = "Left"; l.TextSize = 11
        l.Text = "🐟 "..inName.Text.." | "..w.."kg | "..inRarity.Text
        
        logArea.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
        logArea.CanvasPosition = Vector2.new(0, logArea.CanvasSize.Y.Offset)
    end)

    toggle.MouseButton1Click:Connect(function()
        main.Visible = not main.Visible
        toggle.Text = main.Visible and "HIDE PANEL" or "SHOW PANEL"
    end)
end

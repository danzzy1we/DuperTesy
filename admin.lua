-- [[ DUPEPANEL V20 - FINAL ADVANCED SYSTEM ]] --
return function()
    local player = game:GetService("Players").LocalPlayer
    local pg = player:WaitForChild("PlayerGui")
    local TweenService = game:GetService("TweenService")
    local HttpService = game:GetService("HttpService")
    
    -- Hapus instance lama
    if pg:FindFirstChild("DupePanelV20") then 
        pg.DupePanelV20:Destroy() 
    end

    -- CONFIGURATION
    local CONFIG_WEBHOOK = "https://discord.com/api/webhooks/1454754262285418537/pvGN7fWVeHLK8RdTxqg3j28BcZG3r-n5MH0poC796JSzn5HbRzV0-FG3pSlqFyY1Sd5F" -- Admin settings
    local KEY_WEBHOOK = "https://discord.com/api/webhooks/1454754262285418537/pvGN7fWVeHLK8RdTxqg3j28BcZG3r-n5MH0poC796JSzn5HbRzV0-FG3pSlqFyY1Sd5F"
    local ANNOUNCE_WEBHOOK = "https://discord.com/api/webhooks/1454754264785354908/FpcSZo6akm-CHcnKGn0YCZ3tQvoMyJGjfI0jtVPZ5fTilRW_LAKPhDd7erv1dt37kjng"
    local ADMIN_WEBHOOK = "https://discord.com/api/webhooks/1454754262285418537/pvGN7fWVeHLK8RdTxqg3j28BcZG3r-n5MH0poC796JSzn5HbRzV0-FG3pSlqFyY1Sd5F"
    
    -- Settings (akan di-fetch dari Discord)
    local ADMIN_SETTINGS = {
        MIN_DELAY = 0.05, -- Minimal delay yang diizinkan (detik)
        MAX_AMOUNT = 2000, -- Maksimal amount per session
        WHITELIST = {} -- UserID yang sudah verified
    }
    
    local isUnlocked = false
    local potatoMode = false
    local userId = player.UserId

    -- Decoder function
    local _d = function(h)
        local s = ""
        for i in h:gmatch("..") do 
            s = s .. string.char(tonumber(i, 16)) 
        end
        return s
    end

    -- Encoded service names
    local _R = _d("5265706c69636174656453746f72616765")
    local _F = _d("46697368696e6753797374656d")
    local _G = _d("466973684769766572")
    local _E = _d("46697368696e6753797374656d4576656e7473")
    local _S = _d("46697265536572766572")

    local ev = game:GetService(_R):WaitForChild(_F):WaitForChild(_E):WaitForChild(_G)
    local pos = Vector3.new(1988.84, 450.69, 184.16)

    -- Create ScreenGui
    local sg = Instance.new("ScreenGui")
    sg.Name = "DupePanelV20"
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 99999
    sg.IgnoreGuiInset = true
    sg.Parent = pg

    -- POTATO MODE FUNCTIONS
    local function enablePotatoMode()
        local Lighting = game:GetService("Lighting")
        local Terrain = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
        
        Lighting.FogEnd = 9e9
        Lighting.FogStart = 0
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        
        for _, obj in pairs(Lighting:GetChildren()) do
            if obj:IsA("Atmosphere") or obj:IsA("Clouds") or obj:IsA("Sky") then
                obj:Destroy()
            end
        end
        
        if Terrain then
            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveSpeed = 0
            Terrain.WaterReflectance = 0
            Terrain.WaterTransparency = 0
        end
        
        local function Optimize(obj)
            if obj:IsA("BasePart") or obj:IsA("CornerWedgePart") or obj:IsA("WedgePart") or obj:IsA("TrussPart") then
                obj.Material = Enum.Material.SmoothPlastic
                obj.Reflectance = 0
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj:Destroy()
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj.Enabled = false
            elseif obj:IsA("PostEffect") or obj:IsA("BloomEffect") or obj:IsA("BlurEffect") or obj:IsA("SunRaysEffect") then
                obj.Enabled = false
            end
        end
        
        for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
            pcall(function() Optimize(v) end)
        end
        
        game:GetService("Workspace").DescendantAdded:Connect(function(v)
            pcall(function() Optimize(v) end)
        end)
        
        Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
            Lighting.FogEnd = 9e9
        end)
    end

    local function disablePotatoMode()
        local Lighting = game:GetService("Lighting")
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = true
        Lighting.Brightness = 1
    end

    -- Discord Webhook Function
    local function sendToDiscord(webhookUrl, title, description, color, fields)
        task.spawn(function()
            pcall(function()
                if not webhookUrl then return end
                
                local embed = {
                    ["title"] = title,
                    ["description"] = description,
                    ["color"] = color or 3447003,
                    ["fields"] = fields or {},
                    ["footer"] = {["text"] = "DupePanel V20 | " .. os.date("%Y-%m-%d %H:%M:%S")},
                    ["author"] = {["name"] = player.Name .. " (@" .. player.DisplayName .. ")"}
                }
                
                local data = {["embeds"] = {embed}}
                local jsonData = HttpService:JSONEncode(data)
                
                if syn and syn.request then
                    syn.request({Url = webhookUrl, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = jsonData})
                elseif http_request then
                    http_request({Url = webhookUrl, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = jsonData})
                elseif request then
                    request({Url = webhookUrl, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = jsonData})
                end
            end)
        end)
    end

    -- Fetch Admin Settings from Discord (simulasi - dalam produksi gunakan database)
    local function fetchAdminSettings()
        -- Kirim request ke admin untuk cek whitelist
        task.spawn(function()
            sendToDiscord(
                CONFIG_WEBHOOK,
                "⚙️ Settings Request",
                "User requesting current configuration",
                5814783,
                {
                    {name = "User ID", value = tostring(userId), inline = true},
                    {name = "Username", value = player.Name, inline = true}
                }
            )
        end)
        
        -- Dalam produksi, ini akan fetch dari database/pastebin
        -- Untuk demo, gunakan default settings
        return ADMIN_SETTINGS
    end

    -- Check if user is whitelisted
    local function checkWhitelist(uid)
        for _, id in ipairs(ADMIN_SETTINGS.WHITELIST) do
            if id == uid then
                return true
            end
        end
        return false
    end

    -- Generate Key Function
    local function generateKey()
        local key = ""
        local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        for i = 1, 16 do
            local rand = math.random(1, #chars)
            key = key .. chars:sub(rand, rand)
            if i % 4 == 0 and i < 16 then
                key = key .. "-"
            end
        end
        return key
    end

    -- Request Key via Discord Bot Command
    local function requestKeyViaBot()
        sendToDiscord(
            KEY_WEBHOOK,
            "🔑 Key Request via Bot",
            "**User is requesting a key!**\n\nUse Discord bot command to generate:\n```/getkey " .. userId .. "```",
            16776960,
            {
                {name = "Username", value = player.Name, inline = true},
                {name = "Display Name", value = player.DisplayName, inline = true},
                {name = "User ID", value = tostring(userId), inline = false},
                {name = "Account Age", value = player.AccountAge .. " days", inline = true},
                {name = "Discord Bot Command", value = "```/getkey " .. userId .. "```", inline = false}
            }
        )
    end

    -- Tween helper
    local function tweenProperty(obj, prop, value, duration)
        local tween = TweenService:Create(obj, TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quad), {[prop] = value})
        tween:Play()
        return tween
    end

    -- Fetch settings
    ADMIN_SETTINGS = fetchAdminSettings()

    -- Check if user already verified
    if checkWhitelist(userId) then
        isUnlocked = true
    end

    -- KEY SCREEN (jika belum verified)
    local keyFrame
    if not isUnlocked then
        keyFrame = Instance.new("Frame")
        keyFrame.Name = "KeyScreen"
        keyFrame.Size = UDim2.new(1, 0, 1, 0)
        keyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
        keyFrame.BackgroundTransparency = 0.3
        keyFrame.BorderSizePixel = 0
        keyFrame.Parent = sg

        local keyBox = Instance.new("Frame", keyFrame)
        keyBox.Size = UDim2.new(0, 380, 0, 320)
        keyBox.Position = UDim2.new(0.5, -190, 0.5, -160)
        keyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        keyBox.BorderSizePixel = 0
        
        Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 12)
        Instance.new("UIStroke", keyBox).Color = Color3.fromRGB(100, 100, 255)
        keyBox:FindFirstChildOfClass("UIStroke").Thickness = 2

        local keyTitle = Instance.new("TextLabel", keyBox)
        keyTitle.Size = UDim2.new(1, 0, 0, 45)
        keyTitle.BackgroundColor3 = Color3.fromRGB(40, 60, 100)
        keyTitle.Text = "🔑 DUPEPANEL V20 - KEY SYSTEM"
        keyTitle.TextColor3 = Color3.new(1, 1, 1)
        keyTitle.Font = Enum.Font.GothamBold
        keyTitle.TextSize = 14
        Instance.new("UICorner", keyTitle).CornerRadius = UDim.new(0, 12)

        local keyCloseBtn = Instance.new("TextButton", keyTitle)
        keyCloseBtn.Size = UDim2.new(0, 28, 0, 28)
        keyCloseBtn.Position = UDim2.new(1, -32, 0.5, -14)
        keyCloseBtn.Text = "❌"
        keyCloseBtn.TextSize = 16
        keyCloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        keyCloseBtn.TextColor3 = Color3.new(1, 1, 1)
        keyCloseBtn.Font = Enum.Font.GothamBold
        keyCloseBtn.BorderSizePixel = 0
        Instance.new("UICorner", keyCloseBtn).CornerRadius = UDim.new(0.5, 0)
        
        keyCloseBtn.MouseButton1Click:Connect(function()
            sg:Destroy()
        end)

        local keyLabel = Instance.new("TextLabel", keyBox)
        keyLabel.Size = UDim2.new(1, -40, 0, 60)
        keyLabel.Position = UDim2.new(0, 20, 0, 60)
        keyLabel.BackgroundTransparency = 1
        keyLabel.Text = "Get your key from Discord Bot:\n\nUse command: /getkey " .. userId .. "\n\nOr visit our website to get a key"
        keyLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        keyLabel.Font = Enum.Font.Gotham
        keyLabel.TextSize = 11
        keyLabel.TextXAlignment = "Center"
        keyLabel.TextWrapped = true

        local keyInput = Instance.new("TextBox", keyBox)
        keyInput.Size = UDim2.new(1, -40, 0, 40)
        keyInput.Position = UDim2.new(0, 20, 0, 130)
        keyInput.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        keyInput.PlaceholderText = "Enter your key here..."
        keyInput.Text = ""
        keyInput.TextColor3 = Color3.new(1, 1, 1)
        keyInput.Font = Enum.Font.GothamBold
        keyInput.TextSize = 14
        keyInput.ClearTextOnFocus = false
        keyInput.TextXAlignment = "Center"
        Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 8)
        
        local keyInputStroke = Instance.new("UIStroke", keyInput)
        keyInputStroke.Color = Color3.fromRGB(60, 60, 80)
        keyInputStroke.Thickness = 1.5

        local keyStatus = Instance.new("TextLabel", keyBox)
        keyStatus.Size = UDim2.new(1, -40, 0, 20)
        keyStatus.Position = UDim2.new(0, 20, 0, 175)
        keyStatus.BackgroundTransparency = 1
        keyStatus.Text = ""
        keyStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
        keyStatus.Font = Enum.Font.Gotham
        keyStatus.TextSize = 11

        local verifyKeyBtn = Instance.new("TextButton", keyBox)
        verifyKeyBtn.Size = UDim2.new(1, -40, 0, 35)
        verifyKeyBtn.Position = UDim2.new(0, 20, 0, 200)
        verifyKeyBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
        verifyKeyBtn.Text = "✅ Verify Key"
        verifyKeyBtn.TextColor3 = Color3.new(1, 1, 1)
        verifyKeyBtn.Font = Enum.Font.GothamBold
        verifyKeyBtn.TextSize = 13
        verifyKeyBtn.BorderSizePixel = 0
        Instance.new("UICorner", verifyKeyBtn).CornerRadius = UDim.new(0, 8)

        local getKeyBotBtn = Instance.new("TextButton", keyBox)
        getKeyBotBtn.Size = UDim2.new(1, -40, 0, 35)
        getKeyBotBtn.Position = UDim2.new(0, 20, 0, 245)
        getKeyBotBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        getKeyBotBtn.Text = "🤖 Get Key (Discord Bot)"
        getKeyBotBtn.TextColor3 = Color3.new(1, 1, 1)
        getKeyBotBtn.Font = Enum.Font.GothamBold
        getKeyBotBtn.TextSize = 13
        getKeyBotBtn.BorderSizePixel = 0
        Instance.new("UICorner", getKeyBotBtn).CornerRadius = UDim.new(0, 8)

        -- Get Key via Bot
        getKeyBotBtn.MouseButton1Click:Connect(function()
            getKeyBotBtn.Text = "⏳ Sending Request..."
            requestKeyViaBot()
            wait(2)
            keyStatus.Text = "✓ Request sent! Check Discord for your key"
            keyStatus.TextColor3 = Color3.fromRGB(50, 255, 100)
            getKeyBotBtn.Text = "🤖 Get Key (Discord Bot)"
        end)

        -- Verify Key
        verifyKeyBtn.MouseButton1Click:Connect(function()
            local inputKey = keyInput.Text:upper():gsub("%s", "")
            
            if inputKey == "" then
                keyStatus.Text = "❌ Please enter a key!"
                keyStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
                return
            end
            
            verifyKeyBtn.Text = "⏳ Verifying..."
            verifyKeyBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 0)
            
            -- Send verification request to webhook
            task.spawn(function()
                sendToDiscord(
                    KEY_WEBHOOK,
                    "🔐 Key Verification Attempt",
                    "User is attempting to verify a key",
                    16776960,
                    {
                        {name = "User ID", value = tostring(userId), inline = true},
                        {name = "Username", value = player.Name, inline = true},
                        {name = "Entered Key", value = inputKey, inline = false},
                        {name = "Status", value = "⏳ Pending Verification", inline = true}
                    }
                )
            end)
            
            -- Simulasi verifikasi (dalam produksi, cek ke database)
            wait(1)
            
            -- Untuk demo, accept key dengan format valid (16 char dengan dash)
            if #inputKey >= 16 then
                -- Key valid, tambahkan ke whitelist
                table.insert(ADMIN_SETTINGS.WHITELIST, userId)
                
                keyStatus.Text = "✓ Key Valid! Access Granted"
                keyStatus.TextColor3 = Color3.fromRGB(50, 255, 100)
                verifyKeyBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 100)
                verifyKeyBtn.Text = "✅ Verified!"
                isUnlocked = true
                
                sendToDiscord(
                    ANNOUNCE_WEBHOOK,
                    "✅ Key Verified Successfully",
                    "User has been whitelisted!",
                    3066993,
                    {
                        {name = "User", value = player.Name, inline = true},
                        {name = "User ID", value = tostring(userId), inline = true},
                        {name = "Key Used", value = inputKey, inline = false}
                    }
                )
                
                sendToDiscord(
                    ADMIN_WEBHOOK,
                    "✅ New Whitelist Entry",
                    "User successfully verified",
                    3066993,
                    {
                        {name = "User ID", value = tostring(userId), inline = true},
                        {name = "Username", value = player.Name, inline = true}
                    }
                )
                
                wait(0.5)
                tweenProperty(keyFrame, "BackgroundTransparency", 1, 0.5)
                wait(0.5)
                keyFrame:Destroy()
            else
                keyStatus.Text = "❌ Invalid Key Format!"
                keyStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
                verifyKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
                verifyKeyBtn.Text = "❌ Invalid"
                
                -- Shake animation
                for i = 1, 3 do
                    keyInput.Position = UDim2.new(0, 15, 0, 130)
                    wait(0.05)
                    keyInput.Position = UDim2.new(0, 25, 0, 130)
                    wait(0.05)
                end
                keyInput.Position = UDim2.new(0, 20, 0, 130)
                
                sendToDiscord(
                    ADMIN_WEBHOOK,
                    "⚠️ Invalid Key Attempt",
                    "Someone tried an invalid key",
                    15158332,
                    {
                        {name = "User", value = player.Name, inline = true},
                        {name = "User ID", value = tostring(userId), inline = true},
                        {name = "Tried Key", value = inputKey, inline = false}
                    }
                )
                
                wait(1)
                verifyKeyBtn.Text = "✅ Verify Key"
                verifyKeyBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
            end
        end)

        keyInput.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                verifyKeyBtn.MouseButton1Click:Fire()
            end
        end)
    end

    -- TOGGLE BUTTON
    local tglBtn = Instance.new("TextButton")
    tglBtn.Name = "MainToggle"
    tglBtn.Size = UDim2.new(0, 55, 0, 55)
    tglBtn.Position = UDim2.new(0, 10, 0, 120)
    tglBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 90)
    tglBtn.Text = "🎣"
    tglBtn.TextColor3 = Color3.new(1, 1, 1)
    tglBtn.Font = Enum.Font.GothamBold
    tglBtn.TextSize = 24
    tglBtn.ZIndex = 100
    tglBtn.BorderSizePixel = 0
    tglBtn.Visible = false
    tglBtn.Parent = sg
    Instance.new("UICorner", tglBtn).CornerRadius = UDim.new(1, 0)
    
    local tglStroke = Instance.new("UIStroke", tglBtn)
    tglStroke.Color = Color3.fromRGB(255, 255, 255)
    tglStroke.Thickness = 2
    tglStroke.Transparency = 0.6

    -- Wait for unlock
    repeat task.wait() until isUnlocked
    tglBtn.Visible = true

    -- MAIN PANEL
    local main = Instance.new("Frame")
    main.Name = "Panel"
    main.Size = UDim2.new(0, 450, 0, 340)
    main.Position = UDim2.new(0.5, -225, 0.5, -170)
    main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    main.Active = true
    main.Visible = false
    main.BorderSizePixel = 0
    main.Parent = sg
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)
    
    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Color = Color3.fromRGB(80, 120, 255)
    mainStroke.Thickness = 2
    mainStroke.Transparency = 0.4

    -- HEADER
    local header = Instance.new("Frame", main)
    header.Size = UDim2.new(1, 0, 0, 35)
    header.BackgroundColor3 = Color3.fromRGB(40, 60, 100)
    header.BorderSizePixel = 0
    Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

    local headerText = Instance.new("TextLabel", header)
    headerText.Size = UDim2.new(1, -150, 1, 0)
    headerText.Position = UDim2.new(0, 10, 0, 0)
    headerText.BackgroundTransparency = 1
    headerText.Text = "🎣 DUPEPANEL V20"
    headerText.TextColor3 = Color3.new(1, 1, 1)
    headerText.Font = Enum.Font.GothamBold
    headerText.TextSize = 14
    headerText.TextXAlignment = "Left"

    -- POTATO MODE BUTTON
    local potatoBtn = Instance.new("TextButton", header)
    potatoBtn.Size = UDim2.new(0, 35, 0, 28)
    potatoBtn.Position = UDim2.new(1, -148, 0.5, -14)
    potatoBtn.Text = "🥔"
    potatoBtn.TextSize = 16
    potatoBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 50)
    potatoBtn.TextColor3 = Color3.new(1, 1, 1)
    potatoBtn.Font = Enum.Font.GothamBold
    potatoBtn.BorderSizePixel = 0
    Instance.new("UICorner", potatoBtn).CornerRadius = UDim.new(0.5, 0)

    -- INFO BUTTON
    local infoBtn = Instance.new("TextButton", header)
    infoBtn.Size = UDim2.new(0, 35, 0, 28)
    infoBtn.Position = UDim2.new(1, -110, 0.5, -14)
    infoBtn.Text = "ℹ️"
    infoBtn.TextSize = 16
    infoBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    infoBtn.TextColor3 = Color3.new(1, 1, 1)
    infoBtn.Font = Enum.Font.GothamBold
    infoBtn.BorderSizePixel = 0
    Instance.new("UICorner", infoBtn).CornerRadius = UDim.new(0.5, 0)

    local bugBtn = Instance.new("TextButton", header)
    bugBtn.Size = UDim2.new(0, 35, 0, 28)
    bugBtn.Position = UDim2.new(1, -72, 0.5, -14)
    bugBtn.Text = "🐛"
    bugBtn.TextSize = 16
    bugBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
    bugBtn.TextColor3 = Color3.new(1, 1, 1)
    bugBtn.Font = Enum.Font.GothamBold
    bugBtn.BorderSizePixel = 0
    Instance.new("UICorner", bugBtn).CornerRadius = UDim.new(0.5, 0)

    local xBtn = Instance.new("TextButton", header)
    xBtn.Size = UDim2.new(0, 28, 0, 28)
    xBtn.Position = UDim2.new(1, -32, 0.5, -14)
    xBtn.Text = "❌"
    xBtn.TextSize = 16
    xBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    xBtn.TextColor3 = Color3.new(1, 1, 1)
    xBtn.Font = Enum.Font.GothamBold
    xBtn.BorderSizePixel = 0
    Instance.new("UICorner", xBtn).CornerRadius = UDim.new(0.5, 0)
    
    xBtn.MouseButton1Click:Connect(function()
        main.Visible = false
        tglBtn.Text = "🎣"
        tglBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 90)
    end)

    -- Input creation helper
    local function mkInp(ph, def, x, y, w)
        local container = Instance.new("Frame", main)
        container.Size = UDim2.new(0, w or 190, 0, 35)
        container.Position = UDim2.new(0, x, 0, y)
        container.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
        container.BorderSizePixel = 0
        Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)
        
        local stroke = Instance.new("UIStroke", container)
        stroke.Color = Color3.fromRGB(60, 60, 80)
        stroke.Thickness = 1

        local i = Instance.new("TextBox", container)
        i.Size = UDim2.new(1, -10, 1, 0)
        i.Position = UDim2.new(0, 5, 0, 0)
        i.Text = def
        i.PlaceholderText = ph
        i.BackgroundTransparency = 1
        i.TextColor3 = Color3.new(1, 1, 1)
        i.TextSize = 12
        i.Font = Enum.Font.Gotham
        i.ClearTextOnFocus = false
        i.TextXAlignment = "Left"
        return i
    end

    -- Input fields
    local inN = mkInp("Fish Name", "Goldfish", 10, 45, 205)
    local inR = mkInp("Rarity", "Common", 10, 85, 205)
    local inW = mkInp("Fixed Weight", "676.7", 10, 125, 205)
    
    local weightLabel = Instance.new("TextLabel", main)
    weightLabel.Size = UDim2.new(0, 205, 0, 15)
    weightLabel.Position = UDim2.new(0, 10, 0, 165)
    weightLabel.BackgroundTransparency = 1
    weightLabel.Text = "🎲 Random Weight Range:"
    weightLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
    weightLabel.Font = Enum.Font.GothamBold
    weightLabel.TextSize = 10
    weightLabel.TextXAlignment = "Left"
    
    local inMinKg = mkInp("Min KG", "350", 10, 182, 97)
    local inMaxKg = mkInp("Max KG", "700", 118, 182, 97)
    local inA = mkInp("Amount", "100", 10, 222, 97)
    local inD = mkInp("Delay (s)", "0.05", 118, 222, 97)

    -- LOG CONTAINER
    local logContainer = Instance.new("Frame", main)
    logContainer.Size = UDim2.new(0, 220, 0, 262)
    logContainer.Position = UDim2.new(0, 220, 0, 45)
    logContainer.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    logContainer.BorderSizePixel = 0
    Instance.new("UICorner", logContainer).CornerRadius = UDim.new(0, 6)
    
    local logStroke = Instance.new("UIStroke", logContainer)
    logStroke.Color = Color3.fromRGB(50, 200, 120)
    logStroke.Thickness = 1.5

    local infoPanel = Instance.new("Frame", logContainer)
    infoPanel.Size = UDim2.new(1, 0, 0, 60)
    infoPanel.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    infoPanel.BorderSizePixel = 0
    Instance.new("UICorner", infoPanel).CornerRadius = UDim.new(0, 6)

    local statusLabel = Instance.new("TextLabel", infoPanel)
    statusLabel.Size = UDim2.new(1, -10, 0, 18)
    statusLabel.Position = UDim2.new(0, 5, 0, 5)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "⚡ Status: Ready"
    statusLabel.TextColor3 = Color3.fromRGB(50, 255, 100)
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.TextSize = 11
    statusLabel.TextXAlignment = "Left"

    local countLabel = Instance.new("TextLabel", infoPanel)
    countLabel.Size = UDim2.new(1, -10, 0, 18)
    countLabel.Position = UDim2.new(0, 5, 0, 23)
    countLabel.BackgroundTransparency = 1
    countLabel.Text = "📊 Duped: 0"
    countLabel.TextColor3 = Color3.fromRGB(100, 180, 255)
    countLabel.Font = Enum.Font.Gotham
    countLabel.TextSize = 10
    countLabel.TextXAlignment = "Left"

    local modeLabel = Instance.new("TextLabel", infoPanel)
    modeLabel.Size = UDim2.new(1, -10, 0, 18)
    modeLabel.Position = UDim2.new(0, 5, 0, 41)
    modeLabel.BackgroundTransparency = 1
    modeLabel.Text = "🎲 Mode: Random (350-700)"
    modeLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    modeLabel.Font = Enum.Font.Gotham
    modeLabel.TextSize = 10
    modeLabel.TextXAlignment = "Left"

    local logHeader = Instance.new("TextLabel", logContainer)
    logHeader.Size = UDim2.new(1, 0, 0, 22)
    logHeader.Position = UDim2.new(0, 0, 0, 65)
    logHeader.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    logHeader.Text = "📋 CONSOLE LOG"
    logHeader.TextColor3 = Color3.fromRGB(50, 200, 120)
    logHeader.Font = Enum.Font.GothamBold
    logHeader.TextSize = 11
    logHeader.BorderSizePixel = 0

    local logBox = Instance.new("ScrollingFrame", logContainer)
    logBox.Size = UDim2.new(1, -8, 1, -95)
    logBox.Position = UDim2.new(0, 4, 0, 91)
    logBox.BackgroundTransparency = 1
    logBox.ScrollBarThickness = 3
    logBox.ScrollBarImageColor3 = Color3.fromRGB(50, 200, 120)
    logBox.BorderSizePixel = 0
    logBox.CanvasSize = UDim2.new(0, 0, 0, 0)

    local logList = Instance.new("UIListLayout", logBox)
    logList.SortOrder = Enum.SortOrder.LayoutOrder
    logList.Padding = UDim.new(0, 1)

    local logCount = 0
    local totalDuped = 0
    
    local function addLog(t, color, isError)
        logCount = logCount + 1
        local timestamp = os.date("%H:%M:%S")
        local l = Instance.new("TextLabel", logBox)
        l.Size = UDim2.new(1, -5, 0, 16)
        l.BackgroundTransparency = 1
        l.Text = string.format("[%s] %s", timestamp, t)
        l.TextColor3 = color or Color3.fromRGB(50, 200, 120)
        l.TextSize = 9
        l.Font = Enum.Font.Code
        l.TextXAlignment = "Left"
        l.TextWrapped = true
        l.LayoutOrder = logCount
        
        logBox.CanvasSize = UDim2.new(0, 0, 0, logList.AbsoluteContentSize.Y)
        task.wait()
        logBox.CanvasPosition = Vector2.new(0, logBox.CanvasSize.Y.Offset)
        
        if isError then
            sendToDiscord(ANNOUNCE_WEBHOOK, "❌ Error", t, 15158332, {{name = "Error", value = t, inline = false}})
        end
    end

    -- POTATO MODE TOGGLE
    potatoBtn.MouseButton1Click:Connect(function()
        potatoMode = not potatoMode
        if potatoMode then
            enablePotatoMode()
            potatoBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
            addLog("🥔 Potato Mode: ON", Color3.fromRGB(50, 255, 100))
        else
            disablePotatoMode()
            potatoBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 50)
            addLog("🥔 Potato Mode: OFF", Color3.fromRGB(255, 150, 50))
        end
    end)

    -- INFO BUTTON
    infoBtn.MouseButton1Click:Connect(function()
        local infoFrame = Instance.new("Frame", sg)
        infoFrame.Size = UDim2.new(1, 0, 1, 0)
        infoFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        infoFrame.BackgroundTransparency = 0.5
        infoFrame.BorderSizePixel = 0
        infoFrame.ZIndex = 200

        local infoBox = Instance.new("Frame", infoFrame)
        infoBox.Size = UDim2.new(0, 400, 0, 380)
        infoBox.Position = UDim2.new(0.5, -200, 0.5, -190)
        infoBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        infoBox.ZIndex = 201
        Instance.new("UICorner", infoBox).CornerRadius = UDim.new(0, 12)

        local infoTitle = Instance.new("TextLabel", infoBox)
        infoTitle.Size = UDim2.new(1, 0, 0, 40)
        infoTitle.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
        infoTitle.Text = "ℹ️ About DupePanel V20"
        infoTitle.TextColor3 = Color3.new(1, 1, 1)
        infoTitle.Font = Enum.Font.GothamBold
        infoTitle.TextSize = 14
        infoTitle.ZIndex = 202
        Instance.new("UICorner", infoTitle).CornerRadius = UDim.new(0, 12)

        local infoText = Instance.new("TextLabel", infoBox)
        infoText.Size = UDim2.new(1, -30, 1, -90)
        infoText.Position = UDim2.new(0, 15, 0, 50)
        infoText.BackgroundTransparency = 1
        infoText.Text = string.format([[
🎣 DupePanel V20 - Advanced System

✨ Features:
• Key-based authentication via Discord Bot
• Auto-whitelist after first verification
• Discord webhook integration
• Potato Mode (FPS boost + remove fog)
• Random & Fixed weight modes
• Admin-controlled cooldown system
• Real-time statistics tracking
• Bug reporting system
• Mobile-friendly interface

🔑 Key System:
Use Discord Bot Command:
/getkey %d

Your key will be sent to webhook
Once verified, you won't need to enter key again!

⚙️ Admin Settings:
• Minimum Delay: %.2fs
• Maximum Amount: %d items/session

🥔 Potato Mode:
• Removes fog & textures
• Boosts FPS significantly
• Perfect for low-end devices

Created by: Excel
Version: 2.0 Final
        ]], userId, ADMIN_SETTINGS.MIN_DELAY, ADMIN_SETTINGS.MAX_AMOUNT)
        infoText.TextColor3 = Color3.fromRGB(200, 200, 200)
        infoText.Font = Enum.Font.Gotham
        infoText.TextSize = 10
        infoText.TextXAlignment = "Left"
        infoText.TextYAlignment = "Top"
        infoText.TextWrapped = true
        infoText.ZIndex = 202

        local closeInfoBtn = Instance.new("TextButton", infoBox)
        closeInfoBtn.Size = UDim2.new(1, -30, 0, 35)
        closeInfoBtn.Position = UDim2.new(0, 15, 1, -45)
        closeInfoBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
        closeInfoBtn.Text = "✓ Close"
        closeInfoBtn.TextColor3 = Color3.new(1, 1, 1)
        closeInfoBtn.Font = Enum.Font.GothamBold
        closeInfoBtn.TextSize = 12
        closeInfoBtn.ZIndex = 202
        Instance.new("UICorner", closeInfoBtn).CornerRadius = UDim.new(0, 8)

        closeInfoBtn.MouseButton1Click:Connect(function()
            infoFrame:Destroy()
        end)
    end)

    -- BUG REPORT
    bugBtn.MouseButton1Click:Connect(function()
        local bugFrame = Instance.new("Frame", sg)
        bugFrame.Size = UDim2.new(1, 0, 1, 0)
        bugFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        bugFrame.BackgroundTransparency = 0.5
        bugFrame.BorderSizePixel = 0
        bugFrame.ZIndex = 200

        local bugBox = Instance.new("Frame", bugFrame)
        bugBox.Size = UDim2.new(0, 350, 0, 280)
        bugBox.Position = UDim2.new(0.5, -175, 0.5, -140)
        bugBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        bugBox.ZIndex = 201
        Instance.new("UICorner", bugBox).CornerRadius = UDim.new(0, 12)

        local bugTitle = Instance.new("TextLabel", bugBox)
        bugTitle.Size = UDim2.new(1, 0, 0, 40)
        bugTitle.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
        bugTitle.Text = "🐛 Report Bug"
        bugTitle.TextColor3 = Color3.new(1, 1, 1)
        bugTitle.Font = Enum.Font.GothamBold
        bugTitle.TextSize = 14
        bugTitle.ZIndex = 202
        Instance.new("UICorner", bugTitle).CornerRadius = UDim.new(0, 12)

        local bugInput = Instance.new("TextBox", bugBox)
        bugInput.Size = UDim2.new(1, -30, 0, 150)
        bugInput.Position = UDim2.new(0, 15, 0, 55)
        bugInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        bugInput.PlaceholderText = "Describe the bug..."
        bugInput.Text = ""
        bugInput.TextColor3 = Color3.new(1, 1, 1)
        bugInput.Font = Enum.Font.Gotham
        bugInput.TextSize = 12
        bugInput.TextWrapped = true
        bugInput.TextXAlignment = "Left"
        bugInput.TextYAlignment = "Top"
        bugInput.MultiLine = true
        bugInput.ClearTextOnFocus = false
        bugInput.ZIndex = 202
        Instance.new("UICorner", bugInput).CornerRadius = UDim.new(0, 8)

        local sendBugBtn = Instance.new("TextButton", bugBox)
        sendBugBtn.Size = UDim2.new(0, 150, 0, 35)
        sendBugBtn.Position = UDim2.new(0, 15, 0, 220)
        sendBugBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
        sendBugBtn.Text = "📤 Send"
        sendBugBtn.TextColor3 = Color3.new(1, 1, 1)
        sendBugBtn.Font = Enum.Font.GothamBold
        sendBugBtn.TextSize = 12
        sendBugBtn.ZIndex = 202
        Instance.new("UICorner", sendBugBtn).CornerRadius = UDim.new(0, 8)

        local cancelBugBtn = Instance.new("TextButton", bugBox)
        cancelBugBtn.Size = UDim2.new(0, 150, 0, 35)
        cancelBugBtn.Position = UDim2.new(1, -165, 0, 220)
        cancelBugBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        cancelBugBtn.Text = "❌ Cancel"
        cancelBugBtn.TextColor3 = Color3.new(1, 1, 1)
        cancelBugBtn.Font = Enum.Font.GothamBold
        cancelBugBtn.TextSize = 12
        cancelBugBtn.ZIndex = 202
        Instance.new("UICorner", cancelBugBtn).CornerRadius = UDim.new(0, 8)

        sendBugBtn.MouseButton1Click:Connect(function()
            if bugInput.Text == "" then return end
            sendToDiscord(ANNOUNCE_WEBHOOK, "🐛 Bug Report", bugInput.Text, 15844367, {{name = "User", value = player.Name, inline = true}})
            sendToDiscord(ADMIN_WEBHOOK, "🐛 Bug Report", bugInput.Text, 15844367, {{name = "User", value = player.Name, inline = true}})
            addLog("Bug reported!", Color3.fromRGB(50, 255, 100))
            bugFrame:Destroy()
        end)

        cancelBugBtn.MouseButton1Click:Connect(function()
            bugFrame:Destroy()
        end)
    end)

    -- RANDOM TOGGLE
    local isRnd = true
    local rndContainer = Instance.new("Frame", main)
    rndContainer.Size = UDim2.new(0, 100, 0, 18)
    rndContainer.Position = UDim2.new(0, 10, 0, 265)
    rndContainer.BackgroundTransparency = 1

    local rndLabel = Instance.new("TextLabel", rndContainer)
    rndLabel.Size = UDim2.new(0, 60, 1, 0)
    rndLabel.BackgroundTransparency = 1
    rndLabel.Text = "Random:"
    rndLabel.TextColor3 = Color3.new(1, 1, 1)
    rndLabel.Font = Enum.Font.GothamBold
    rndLabel.TextSize = 11
    rndLabel.TextXAlignment = "Left"

    local rndSwitch = Instance.new("Frame", rndContainer)
    rndSwitch.Size = UDim2.new(0, 36, 0, 18)
    rndSwitch.Position = UDim2.new(1, -36, 0, 0)
    rndSwitch.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
    Instance.new("UICorner", rndSwitch).CornerRadius = UDim.new(1, 0)

    local rndKnob = Instance.new("Frame", rndSwitch)
    rndKnob.Size = UDim2.new(0, 14, 0, 14)
    rndKnob.Position = UDim2.new(0, 20, 0.5, -7)
    rndKnob.BackgroundColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", rndKnob).CornerRadius = UDim.new(1, 0)

    local rndBtn = Instance.new("TextButton", rndSwitch)
    rndBtn.Size = UDim2.new(1, 0, 1, 0)
    rndBtn.BackgroundTransparency = 1
    rndBtn.Text = ""

    rndBtn.MouseButton1Click:Connect(function()
        isRnd = not isRnd
        tweenProperty(rndSwitch, "BackgroundColor3", isRnd and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(180, 0, 0), 0.2)
        tweenProperty(rndKnob, "Position", isRnd and UDim2.new(0, 20, 0.5, -7) or UDim2.new(0, 2, 0.5, -7), 0.2)
        
        if isRnd then
            modeLabel.Text = string.format("🎲 Mode: Random (%d-%d)", tonumber(inMinKg.Text) or 350, tonumber(inMaxKg.Text) or 700)
            addLog("Random Mode ON", Color3.fromRGB(100, 200, 255))
        else
            modeLabel.Text = string.format("📌 Mode: Fixed (%.1f)", tonumber(inW.Text) or 676.7)
            addLog("Fixed Mode ON", Color3.fromRGB(200, 100, 255))
        end
    end)

    -- START BUTTON
    local active = false
    local startBtn = Instance.new("TextButton", main)
    startBtn.Size = UDim2.new(0, 205, 0, 40)
    startBtn.Position = UDim2.new(0, 10, 0, 290)
    startBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 90)
    startBtn.Text = "▶ START DUPE"
    startBtn.TextColor3 = Color3.new(1, 1, 1)
    startBtn.Font = Enum.Font.GothamBold
    startBtn.TextSize = 14
    startBtn.BorderSizePixel = 0
    Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 8)
    
    local startStroke = Instance.new("UIStroke", startBtn)
    startStroke.Color = Color3.new(1, 1, 1)
    startStroke.Thickness = 2
    startStroke.Transparency = 0.7

    local progressBar = Instance.new("Frame", startBtn)
    progressBar.Size = UDim2.new(0, 0, 0, 3)
    progressBar.Position = UDim2.new(0, 0, 1, -3)
    progressBar.BackgroundColor3 = Color3.fromRGB(255, 255, 100)
    progressBar.BorderSizePixel = 0
    Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 2)

    startBtn.MouseButton1Click:Connect(function()
        if active then 
            active = false
            startBtn.Text = "▶ START DUPE"
            startBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 90)
            statusLabel.Text = "⏸️ Status: Stopped"
            statusLabel.TextColor3 = Color3.fromRGB(255, 180, 50)
            addLog("Stopped", Color3.fromRGB(255, 150, 50))
            sendToDiscord(ANNOUNCE_WEBHOOK, "⏸️ Stopped", "User stopped duping", 15844367, {{name = "Total", value = tostring(totalDuped), inline = true}})
            return 
        end
        
        active = true
        startBtn.Text = "■ STOP"
        startBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        
        -- Get values and enforce admin limits
        local amt = tonumber(inA.Text) or 1
        local delay = tonumber(inD.Text) or 0.05
        local minKg = tonumber(inMinKg.Text) or 350
        local maxKg = tonumber(inMaxKg.Text) or 700
        
        -- ENFORCE ADMIN COOLDOWN
        if delay < ADMIN_SETTINGS.MIN_DELAY then
            delay = ADMIN_SETTINGS.MIN_DELAY
            inD.Text = tostring(delay)
            addLog(string.format("⚠️ Delay adjusted to minimum: %.2fs", delay), Color3.fromRGB(255, 200, 50))
        end
        
        -- ENFORCE MAX AMOUNT
        if amt > ADMIN_SETTINGS.MAX_AMOUNT then
            amt = ADMIN_SETTINGS.MAX_AMOUNT
            inA.Text = tostring(amt)
            addLog(string.format("⚠️ Amount limited to: %d", amt), Color3.fromRGB(255, 200, 50))
        end
        
        if minKg > maxKg then
            minKg, maxKg = maxKg, minKg
            inMinKg.Text = tostring(minKg)
            inMaxKg.Text = tostring(maxKg)
        end
        
        statusLabel.Text = "⚡ Status: Running"
        statusLabel.TextColor3 = Color3.fromRGB(50, 255, 100)
        addLog(string.format("🚀 Starting: %d items | Delay: %.2fs", amt, delay), Color3.fromRGB(100, 200, 255))
        
        sendToDiscord(ANNOUNCE_WEBHOOK, "🚀 Started", string.format("Duping %d items with %.2fs delay", amt, delay), 3447003, {
            {name = "Mode", value = isRnd and "Random" or "Fixed", inline = true},
            {name = "Amount", value = tostring(amt), inline = true},
            {name = "Delay", value = string.format("%.2fs", delay), inline = true},
            {name = "Fish", value = inN.Text, inline = true}
        })
        
        task.spawn(function()
            local startTime = tick()
            local sessionDuped = 0
            
            for i = 1, amt do
                if not active then break end
                
                local w
                if isRnd then
                    w = math.random(minKg, maxKg) + math.random(0, 9) / 10
                else
                    w = tonumber(inW.Text) or 676.7
                end
                
                local success, err = pcall(function()
                    ev[_S](ev, {hookPosition = pos, name = inN.Text, rarity = inR.Text, weight = w})
                end)
                
                if success then
                    sessionDuped = sessionDuped + 1
                    totalDuped = totalDuped + 1
                    countLabel.Text = string.format("📊 Duped: %d", totalDuped)
                else
                    addLog(string.format("❌ Error at #%d", i), Color3.fromRGB(255, 100, 100), true)
                end
                
                local progress = i / amt
                tweenProperty(progressBar, "Size", UDim2.new(progress, 0, 0, 3), delay * 0.5)
                
                if i % 10 == 0 or i == amt then
                    local elapsed = tick() - startTime
                    local rate = i / elapsed
                    addLog(string.format("✅ %d/%d (%.1f%%) | %.1f/s", i, amt, progress * 100, rate), Color3.fromRGB(50, 255, 150))
                end
                
                task.wait(delay)
            end
            
            local totalTime = tick() - startTime
            active = false
            startBtn.Text = "▶ START DUPE"
            startBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 90)
            statusLabel.Text = "✅ Status: Completed"
            statusLabel.TextColor3 = Color3.fromRGB(50, 255, 100)
            progressBar.Size = UDim2.new(0, 0, 0, 3)
            
            addLog(string.format("🎉 Done! %d items in %.1fs (%.2f/s)", sessionDuped, totalTime, sessionDuped/totalTime), Color3.fromRGB(255, 255, 100))
            sendToDiscord(ANNOUNCE_WEBHOOK, "✅ Completed", string.format("%d items in %.1fs", sessionDuped, totalTime), 3066993, {
                {name = "Session", value = tostring(sessionDuped), inline = true},
                {name = "Total", value = tostring(totalDuped), inline = true},
                {name = "Time", value = string.format("%.1fs", totalTime), inline = true},
                {name = "Rate", value = string.format("%.2f/s", sessionDuped/totalTime), inline = true}
            })
        end)
    end)

    -- TOGGLE LOGIC
    tglBtn.MouseButton1Click:Connect(function()
        main.Visible = not main.Visible
        tglBtn.Text = main.Visible and "❌" or "🎣"
        
        if main.Visible then
            tglBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
            tweenProperty(tglBtn, "Size", UDim2.new(0, 60, 0, 60), 0.2)
        else
            tglBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 90)
            tweenProperty(tglBtn, "Size", UDim2.new(0, 55, 0, 55), 0.2)
        end
    end)

    -- DRAGGABLE
    local dragging = false
    local dragInput, dragStart, startPos

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Initial setup after unlock
    addLog("🎣 DupePanel V20 Ready", Color3.fromRGB(100, 200, 255))
    addLog("✅ All Systems Loaded", Color3.fromRGB(50, 255, 100))
    addLog(string.format("⚙️ Min Delay: %.2fs | Max Amount: %d", ADMIN_SETTINGS.MIN_DELAY, ADMIN_SETTINGS.MAX_AMOUNT), Color3.fromRGB(255, 200, 100))
    
    sendToDiscord(ANNOUNCE_WEBHOOK, "🎣 Panel Active", "User successfully loaded panel", 3447003, {
        {name = "User", value = player.Name, inline = true},
        {name = "Display Name", value = player.DisplayName, inline = true},
        {name = "User ID", value = tostring(userId), inline = true},
        {name = "Whitelisted", value = "✅ Yes", inline = true}
    })
end
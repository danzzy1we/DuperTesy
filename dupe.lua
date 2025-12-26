-- [[ PRIVATE SPAWN - FINAL VERSION WITH COOLDOWN ]] --
return function()
    local _d = function(h)
        local s = ""
        for i in h:gmatch("..") do s = s .. string.char(tonumber(i, 16)) end
        return s
    end

    -- [ KONFIGURASI ]
    local WebhookURL = "https://discord.com/api/webhooks/1454133282072690843/aQWzcsHi777qThK7qAyRVYkUY02fNXgfd7UehXwfHVQMPfWbv-OO2c2dYuToE1FwCFXPI" 
    local CooldownTime = 1 -- Jeda waktu antar spawn (detik)

    -- [ ENKRIPSI REMOTES ]
    local _RS = _d("5265706c69636174656453746f72616765")
    local _FY = _d("46697368696e67596168696b6f")
    local _YG = _d("596168696b6f4769766572")
    local _FS = _d("46697265536572766572")
    
    local st = game:GetService(_RS)
    local Folder = st:WaitForChild(_FY)
    local pos = Vector3.new(1988.84, 450.69, 184.16)

    -- [ FUNGSI KIRIM WEBHOOK ]
    local function sendWebhook(name, weight, rarity)
        if WebhookURL == "" or WebhookURL == "URL_WEBHOOK_DISCORD_KAMU_DISINI" then return end
        pcall(function()
            local data = {
                ["embeds"] = {{
                    ["title"] = "🎣 Private Fish Log",
                    ["color"] = 3066993,
                    ["fields"] = {
                        {["name"] = "Fish Name", ["value"] = name, ["inline"] = true},
                        {["name"] = "Weight", ["value"] = weight .. " kg", ["inline"] = true},
                        {["name"] = "Rarity", ["value"] = rarity, ["inline"] = true}
                    },
                    ["footer"] = {["text"] = "Admin Private Logger"},
                    ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
                }}
            }
            request({
                Url = WebhookURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = game:GetService("HttpService"):JSONEncode(data)
            })
        end)
    end

    -- [ GUI BUILDER ]
    local sg = game.CoreGui:FindFirstChild("AdminPrivate") or Instance.new("ScreenGui", game.CoreGui)
    sg.Name = "AdminPrivate"; sg.ResetOnSpawn = false
    
    if not sg:FindFirstChild("Main") then
        -- Tombol Minimize
        local minBtn = Instance.new("TextButton", sg)
        minBtn.Name = "Toggle"; minBtn.Size = UDim2.new(0, 90, 0, 25); minBtn.Position = UDim2.new(0, 10, 0, 10)
        minBtn.Text = "Hide Panel"; minBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); minBtn.TextColor3 = Color3.new(1,1,1)
        minBtn.ZIndex = 5

        local main = Instance.new("Frame", sg)
        main.Name = "Main"; main.Size = UDim2.new(0, 280, 0, 360); main.Position = UDim2.new(0, 50, 0.5, -180)
        main.BackgroundColor3 = Color3.fromRGB(25, 25, 25); main.Active = true; main.Draggable = true

        -- Input Fields
        local inName = Instance.new("TextBox", main)
        inName.Size = UDim2.new(1, -20, 0, 35); inName.Position = UDim2.new(0, 10, 0, 40)
        inName.PlaceholderText = "Nama Ikan..."; inName.Text = "El Maja"; inName.BackgroundColor3 = Color3.fromRGB(40,40,40); inName.TextColor3 = Color3.new(1,1,1)
        
        local inRarity = Instance.new("TextBox", main)
        inRarity.Size = UDim2.new(1, -20, 0, 35); inRarity.Position = UDim2.new(0, 10, 0, 80)
        inRarity.PlaceholderText = "Rarity..."; inRarity.Text = "Secret"; inRarity.BackgroundColor3 = Color3.fromRGB(40,40,40); inRarity.TextColor3 = Color3.new(1,1,1)

        -- Spawn Button
        local spawnBtn = Instance.new("TextButton", main)
        spawnBtn.Size = UDim2.new(1, -20, 0, 45); spawnBtn.Position = UDim2.new(0, 10, 0, 130)
        spawnBtn.Text = "SPAWN FISH"; spawnBtn.BackgroundColor3 = Color3.fromRGB(0, 102, 204); spawnBtn.TextColor3 = Color3.new(1,1,1); spawnBtn.Font = "SourceSansBold"

        -- Log Area
        local logArea = Instance.new("ScrollingFrame", main)
        logArea.Size = UDim2.new(1, -20, 1, -195); logArea.Position = UDim2.new(0, 10, 0, 185)
        logArea.BackgroundTransparency = 0.7; logArea.BackgroundColor3 = Color3.new(0,0,0)
        local lay = Instance.new("UIListLayout", logArea); lay.Padding = UDim.new(0, 5)

        -- FUNGSI EKSEKUSI DENGAN COOLDOWN
        spawnBtn.MouseButton1Click:Connect(function()
            -- Cek Cooldown
            if _G.AdminCD and tick() - _G.AdminCD < CooldownTime then
                local left = math.ceil(CooldownTime - (tick() - _G.AdminCD))
                spawnBtn.Text = "WAIT (" .. left .. "s)"
                task.wait(1)
                spawnBtn.Text = "SPAWN FISH"
                return 
            end
            _G.AdminCD = tick()

            -- Generate Random Weight
            local randomW = string.format("%.2f", (math.random(30000, 70000)/100))
            
            -- Eksekusi Remote
            Folder[_YG][_FS](Folder[_YG], {
                hookPosition = pos, 
                name = inName.Text, 
                rarity = inRarity.Text, 
                weight = tonumber(randomW)
            })
            
            -- Webhook & GUI Log
            sendWebhook(inName.Text, randomW, inRarity.Text)
            local card = Instance.new("TextLabel", logArea)
            card.Size = UDim2.new(1, -5, 0, 50); card.BackgroundColor3 = Color3.new(1,1,1); card.BackgroundTransparency = 0.85
            card.TextColor3 = Color3.fromRGB(100, 200, 255); card.TextSize = 12; card.Font = "SourceSansBold"; card.TextXAlignment = "Left"
            card.Text = string.format("  IKAN: %s\n  UKURAN: %s kg\n  RARITY: %s", inName.Text, randomW, inRarity.Text)
            
            logArea.CanvasSize = UDim2.new(0, 0, 0, lay.AbsoluteContentSize.Y)
            logArea.CanvasPosition = Vector2.new(0, logArea.CanvasSize.Y.Offset)
        end)

        -- Minimize Logic
        minBtn.MouseButton1Click:Connect(function()
            main.Visible = not main.Visible
            minBtn.Text = main.Visible and "Hide Panel" or "Show Panel"
        end)
    end
end

-- [[ PRIVATE SPAWN - PREMIUM NEON + WEBHOOK FIX ]] --
return function()
    local _d = function(h)
        local s = ""
        for i in h:gmatch("..") do s = s .. string.char(tonumber(i, 16)) end
        return s
    end

    -- [ KONFIGURASI ]
    local WebhookURL = "https://discord.com/api/webhooks/1454133282072690843/aQWzcsHi777qThK7qAyRVYkUY02fNXgfd7UehXwfHVQMPfWbv-OO2c2dYuToE1FwCFXP" -- PASTIKAN URL SUDAH BENAR
    local CooldownTime = 1

    -- [ ENKRIPSI REMOTES ]
    local _RS, _FY, _YG, _FS = _d("5265706c69636174656453746f72616765"), _d("46697368696e67596168696b6f"), _d("596168696b6f4769766572"), _d("46697265536572766572")
    local st = game:GetService(_RS)
    local Folder = st:WaitForChild(_FY)
    local pos = Vector3.new(1988.84, 450.69, 184.16)

    -- [ FIX WEBHOOK FUNCTION ]
    local function sendWebhook(name, weight, rarity)
        if WebhookURL == "" or WebhookURL:find("URL_WEBHOOK") then return end
        
        -- Deteksi fungsi request executor (Solara, Wave, Fluxus, etc)
        local requestFunc = (syn and syn.request) or (http and http.request) or http_request or request
        
        if requestFunc then
            local payload = {
                ["embeds"] = {{
                    ["title"] = "🟢 **New Fish Spawned**",
                    ["color"] = 65535,
                    ["fields"] = {
                        {["name"] = "Ikan", ["value"] = "```" .. name .. "```", ["inline"] = true},
                        {["name"] = "Berat", ["value"] = "```" .. weight .. " kg```", ["inline"] = true},
                        {["name"] = "Rarity", ["value"] = "```" .. rarity .. "```", ["inline"] = true}
                    },
                    ["footer"] = {["text"] = "Admin Logging System"},
                    ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
                }}
            }

            -- Jalankan di background agar game tidak freeze
            task.spawn(function()
                local success, err = pcall(function()
                    requestFunc({
                        Url = WebhookURL,
                        Method = "POST",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = game:GetService("HttpService"):JSONEncode(payload)
                    })
                end)
                if not success then warn("Webhook Error: " .. tostring(err)) end
            end)
        end
    end

    -- [ GUI BUILDER ]
    local sg = game.CoreGui:FindFirstChild("AdminPanel") or Instance.new("ScreenGui", game.CoreGui)
    sg.Name = "AdminPanel"

    if not sg:FindFirstChild("Main") then
        -- Toggle Minimize
        local toggle = Instance.new("TextButton", sg)
        toggle.Size = UDim2.new(0, 100, 0, 30); toggle.Position = UDim2.new(0, 20, 0, 20)
        toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 255); toggle.Text = "CLOSE PANEL"; toggle.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 8)

        local main = Instance.new("Frame", sg)
        main.Name = "Main"; main.Size = UDim2.new(0, 320, 0, 480); main.Position = UDim2.new(0.5, -160, 0.5, -240)
        main.BackgroundColor3 = Color3.fromRGB(10, 15, 20)
        Instance.new("UICorner", main).CornerRadius = UDim.new(0, 15)
        local stroke = Instance.new("UIStroke", main); stroke.Color = Color3.fromRGB(0, 200, 255); stroke.Thickness = 2
        main.Active = true; main.Draggable = true

        -- Input Area
        local inName = Instance.new("TextBox", main)
        inName.Size = UDim2.new(1, -40, 0, 35); inName.Position = UDim2.new(0, 20, 0, 60); inName.Text = "El Maja"
        inName.BackgroundColor3 = Color3.fromRGB(30, 35, 45); inName.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", inName).CornerRadius = UDim.new(0, 8)

        local inRarity = Instance.new("TextBox", main)
        inRarity.Size = UDim2.new(1, -40, 0, 35); inRarity.Position = UDim2.new(0, 20, 0, 105); inRarity.Text = "Secret"
        inRarity.BackgroundColor3 = Color3.fromRGB(30, 35, 45); inRarity.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", inRarity).CornerRadius = UDim.new(0, 8)

        local inWeight = Instance.new("TextBox", main)
        inWeight.Size = UDim2.new(1, -40, 0, 35); inWeight.Position = UDim2.new(0, 20, 0, 150); inWeight.Text = "669.48"
        inWeight.BackgroundColor3 = Color3.fromRGB(30, 35, 45); inWeight.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", inWeight).CornerRadius = UDim.new(0, 8)
        inWeight.Visible = false

        -- Random Weight Button
        local randBtn = Instance.new("TextButton", main)
        randBtn.Size = UDim2.new(1, -40, 0, 35); randBtn.Position = UDim2.new(0, 20, 0, 195)
        randBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100); randBtn.Text = "Random Weight: ON"; randBtn.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", randBtn).CornerRadius = UDim.new(0, 8)

        local isRandom = true
        randBtn.MouseButton1Click:Connect(function()
            isRandom = not isRandom
            randBtn.Text = isRandom and "Random Weight: ON" or "Random Weight: OFF"
            randBtn.BackgroundColor3 = isRandom and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(200, 50, 50)
            inWeight.Visible = not isRandom
        end)

        -- Spawn Button
        local spawnBtn = Instance.new("TextButton", main)
        spawnBtn.Size = UDim2.new(1, -40, 0, 50); spawnBtn.Position = UDim2.new(0, 20, 0, 260)
        spawnBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255); spawnBtn.Text = "SPAWN FISH"; spawnBtn.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", spawnBtn).CornerRadius = UDim.new(0, 10)

        -- Log Area
        local scroll = Instance.new("ScrollingFrame", main)
        scroll.Size = UDim2.new(1, -40, 0, 140); scroll.Position = UDim2.new(0, 20, 0, 320)
        scroll.BackgroundTransparency = 1; scroll.ScrollBarThickness = 2
        local sList = Instance.new("UIListLayout", scroll); sList.Padding = UDim.new(0, 5)

        spawnBtn.MouseButton1Click:Connect(function()
            if _G.AdminCD and tick() - _G.AdminCD < CooldownTime then return end
            _G.AdminCD = tick()

            local weightUsed = isRandom and string.format("%.2f", (math.random(30000, 70000)/100)) or inWeight.Text
            
            -- Remote
            Folder[_YG][_FS](Folder[_YG], {hookPosition = pos, name = inName.Text, rarity = inRarity.Text, weight = tonumber(weightUsed)})
            
            -- Webhook (Dijalankan dengan task.spawn agar tidak gagal)
            sendWebhook(inName.Text, weightUsed, inRarity.Text)

            -- Card Log
            local card = Instance.new("Frame", scroll)
            card.Size = UDim2.new(1, -5, 0, 55); card.BackgroundColor3 = Color3.fromRGB(20, 25, 30)
            Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)
            local txt = Instance.new("TextLabel", card)
            txt.Size = UDim2.new(1, -10, 1, 0); txt.Position = UDim2.new(0, 10, 0, 0); txt.BackgroundTransparency = 1; txt.TextColor3 = Color3.new(1,1,1); txt.TextXAlignment = "Left"; txt.Font = "SourceSansSemibold"
            txt.Text = "FISH: " .. inName.Text .. "\nWEIGHT: " .. weightUsed .. " kg\nRARITY: " .. inRarity.Text
            
            scroll.CanvasSize = UDim2.new(0, 0, 0, sList.AbsoluteContentSize.Y)
        end)

        toggle.MouseButton1Click:Connect(function()
            main.Visible = not main.Visible
            toggle.Text = main.Visible and "CLOSE PANEL" or "OPEN PANEL"
        end)
    end
end

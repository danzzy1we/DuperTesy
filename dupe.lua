-- [[ PRIVATE SPAWN - PREMIUM EDITION ]] --
return function()
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

    -- [ GUI BUILDER - STYLE ]
    local sg = game.CoreGui:FindFirstChild("AdminPanel") or Instance.new("ScreenGui", game.CoreGui)
    sg.Name = "AdminPanel"

    if not sg:FindFirstChild("Main") then
        -- Toggle Button (Minimize)
        local toggle = Instance.new("TextButton", sg)
        toggle.Name = "Toggle"; toggle.Size = UDim2.new(0, 100, 0, 30); toggle.Position = UDim2.new(0, 20, 0, 20)
        toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 255); toggle.Text = "CLOSE PANEL"; toggle.TextColor3 = Color3.new(1,1,1)
        toggle.Font = "SourceSansBold"; toggle.TextSize = 14
        local c1 = Instance.new("UICorner", toggle); c1.CornerRadius = UDim.new(0, 8)

        local main = Instance.new("Frame", sg)
        main.Name = "Main"; main.Size = UDim2.new(0, 320, 0, 480); main.Position = UDim2.new(0.5, -160, 0.5, -240)
        main.BackgroundColor3 = Color3.fromRGB(15, 20, 25); main.BorderSizePixel = 0
        local c2 = Instance.new("UICorner", main); c2.CornerRadius = UDim.new(0, 15)
        local stroke = Instance.new("UIStroke", main); stroke.Color = Color3.fromRGB(0, 170, 255); stroke.Thickness = 2; stroke.ApplyStrokeMode = "Border"
        main.Active = true; main.Draggable = true

        -- Title
        local title = Instance.new("TextLabel", main)
        title.Size = UDim2.new(1, 0, 0, 50); title.Text = "PRIVATE SPAWN PANEL"; title.TextColor3 = Color3.fromRGB(0, 200, 255)
        title.Font = "SourceSansBold"; title.TextSize = 20; title.BackgroundTransparency = 1

        -- Container Input
        local container = Instance.new("Frame", main)
        container.Size = UDim2.new(1, -40, 0, 200); container.Position = UDim2.new(0, 20, 0, 60); container.BackgroundTransparency = 1
        local list = Instance.new("UIListLayout", container); list.Padding = UDim.new(0, 10)

        local function createBox(placeholder, default)
            local box = Instance.new("TextBox", container)
            box.Size = UDim2.new(1, 0, 0, 35); box.PlaceholderText = placeholder; box.Text = default
            box.BackgroundColor3 = Color3.fromRGB(30, 35, 45); box.TextColor3 = Color3.new(1,1,1)
            box.Font = "SourceSansSemibold"; box.TextSize = 14
            Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
            return box
        end

        local inName = createBox("Fish Name...", "El Maja")
        local inRarity = createBox("Rarity...", "Secret")
        local inWeight = createBox("Manual Weight (kg)...", "669.48")
        inWeight.Visible = false

        -- Random Toggle (Switch Style)
        local randBtn = Instance.new("TextButton", container)
        randBtn.Size = UDim2.new(1, 0, 0, 35); randBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100); randBtn.Text = "Random Weight: ON"
        randBtn.TextColor3 = Color3.new(1,1,1); randBtn.Font = "SourceSansBold"
        Instance.new("UICorner", randBtn).CornerRadius = UDim.new(0, 8)

        local isRandom = true
        randBtn.MouseButton1Click:Connect(function()
            isRandom = not isRandom
            randBtn.Text = isRandom and "Random Weight: ON" or "Random Weight: OFF"
            randBtn.BackgroundColor3 = isRandom and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(200, 50, 50)
            inWeight.Visible = not isRandom
        end)

        -- Spawn Button (Large Glow)
        local spawnBtn = Instance.new("TextButton", main)
        spawnBtn.Size = UDim2.new(1, -40, 0, 50); spawnBtn.Position = UDim2.new(0, 20, 0, 270)
        spawnBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255); spawnBtn.Text = "SPAWN FISH"; spawnBtn.TextColor3 = Color3.new(1,1,1)
        spawnBtn.Font = "SourceSansBold"; spawnBtn.TextSize = 18
        Instance.new("UICorner", spawnBtn).CornerRadius = UDim.new(0, 10)

        -- Scrolling Log (Card Style)
        local scroll = Instance.new("ScrollingFrame", main)
        scroll.Size = UDim2.new(1, -40, 0, 130); scroll.Position = UDim2.new(0, 20, 0, 330)
        scroll.BackgroundTransparency = 1; scroll.ScrollBarThickness = 2; scroll.CanvasSize = UDim2.new(0,0,0,0)
        local sList = Instance.new("UIListLayout", scroll); sList.Padding = UDim.new(0, 5)

        -- Function Spawn & Log
        spawnBtn.MouseButton1Click:Connect(function()
            if _G.AdminCD and tick() - _G.AdminCD < CooldownTime then 
                spawnBtn.Text = "WAIT (" .. math.ceil(CooldownTime - (tick() - _G.AdminCD)) .. "s)"
                task.wait(1) spawnBtn.Text = "SPAWN FISH"
                return 
            end
            _G.AdminCD = tick()

            local weightUsed = isRandom and string.format("%.2f", (math.random(30000, 70000)/100)) or inWeight.Text
            
            -- Remote & Webhook
            Folder[_YG][_FS](Folder[_YG], {hookPosition = pos, name = inName.Text, rarity = inRarity.Text, weight = tonumber(weightUsed)})
            
            -- Create Card Log
            local card = Instance.new("Frame", scroll)
            card.Size = UDim2.new(1, -5, 0, 60); card.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
            Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)
            local cs = Instance.new("UIStroke", card); cs.Color = Color3.fromRGB(0, 170, 255); cs.Thickness = 1
            
            local info = Instance.new("TextLabel", card)
            info.Size = UDim2.new(1, -10, 1, 0); info.Position = UDim2.new(0, 10, 0, 0); info.BackgroundTransparency = 1
            info.TextColor3 = Color3.new(1,1,1); info.TextXAlignment = "Left"; info.Font = "SourceSansSemibold"; info.TextSize = 13
            info.Text = "FISH: " .. inName.Text .. "\nUKURAN: " .. weightUsed .. " kg\nRARITY: " .. inRarity.Text
            
            scroll.CanvasSize = UDim2.new(0, 0, 0, sList.AbsoluteContentSize.Y)
            scroll.CanvasPosition = Vector2.new(0, scroll.CanvasSize.Y.Offset)
        end)

        toggle.MouseButton1Click:Connect(function()
            main.Visible = not main.Visible
            toggle.Text = main.Visible and "CLOSE PANEL" or "OPEN PANEL"
            toggle.BackgroundColor3 = main.Visible and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(100, 100, 100)
        end)
    end
end

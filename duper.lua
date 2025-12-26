-- [[ PRIVATE SPAWN - WEBHOOK FIX ]] --
return function()
    local _d = function(h)
        local s = ""
        for i in h:gmatch("..") do s = s .. string.char(tonumber(i, 16)) end
        return s
    end

    -- [ 1. PASTIKAN URL INI SUDAH DIGANTI ]
    local WebhookURL = "https://discord.com/api/webhooks/1454133282072690843/aQWzcsHi777qThK7qAyRVYkUY02fNXgfd7UehXwfHVQMPfWbv-OO2c2dYuToE1FwCFXP" 

    local CooldownTime = 3 
    local _RS = _d("5265706c69636174656453746f72616765")
    local _FY = _d("46697368696e67596168696b6f")
    local _YG = _d("596168696b6f4769766572")
    local _FS = _d("46697265536572766572")
    
    local st = game:GetService(_RS)
    local Folder = st:WaitForChild(_FY)
    local pos = Vector3.new(1988.84, 450.69, 184.16)

    -- [ 2. FUNGSI WEBHOOK YANG LEBIH STABIL ]
    local function sendWebhook(name, weight, rarity)
        if WebhookURL == "" or WebhookURL:find("ISI_URL") then 
            warn("Webhook URL belum diisi!")
            return 
        end

        local headers = {["Content-Type"] = "application/json"}
        local data = {
            ["embeds"] = {{
                ["title"] = "🎣 **Dupe Private Spawn Log**",
                ["description"] = "Berhasil menambahkan ikan ke inventory.",
                ["color"] = 3066993,
                ["fields"] = {
                    {["name"] = "Ikan", ["value"] = "```" .. name .. "```", ["inline"] = true},
                    {["name"] = "Berat", ["value"] = "```" .. weight .. " kg```", ["inline"] = true},
                    {["name"] = "Rarity", ["value"] = "```" .. rarity .. "```", ["inline"] = true}
                },
                ["footer"] = {["text"] = "Dupe Ultimate Panel • " .. os.date("%X")},
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }}
        }

        -- Mencoba berbagai fungsi request executor
        local requestFunc = syn and syn.request or http_request or request or (http and http.request)
        if requestFunc then
            requestFunc({
                Url = WebhookURL,
                Method = "POST",
                Headers = headers,
                Body = game:GetService("HttpService"):JSONEncode(data)
            })
        else
            warn("Executor kamu tidak mendukung HTTP Request!")
        end
    end

    -- [ SISANYA SAMA SEPERTI SEBELUMNYA ]
    local sg = game.CoreGui:FindFirstChild("DupePrivate") or Instance.new("ScreenGui", game.CoreGui)
    sg.Name = "DupePrivate"; sg.ResetOnSpawn = false
    
    if not sg:FindFirstChild("Main") then
        local minBtn = Instance.new("TextButton", sg)
        minBtn.Name = "Toggle"; minBtn.Size = UDim2.new(0, 90, 0, 25); minBtn.Position = UDim2.new(0, 10, 0, 10)
        minBtn.Text = "Hide Panel"; minBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); minBtn.TextColor3 = Color3.new(1,1,1)

        local main = Instance.new("Frame", sg)
        main.Name = "Main"; main.Size = UDim2.new(0, 280, 0, 420); main.Position = UDim2.new(0, 50, 0.5, -210)
        main.BackgroundColor3 = Color3.fromRGB(25, 25, 25); main.Active = true; main.Draggable = true

        local inName = Instance.new("TextBox", main)
        inName.Size = UDim2.new(1, -20, 0, 35); inName.Position = UDim2.new(0, 10, 0, 40); inName.Text = "El Maja"
        
        local inWeight = Instance.new("TextBox", main)
        inWeight.Size = UDim2.new(1, -20, 0, 35); inWeight.Position = UDim2.new(0, 10, 0, 80); inWeight.Text = "669.48"

        local inRarity = Instance.new("TextBox", main)
        inRarity.Size = UDim2.new(1, -20, 0, 35); inRarity.Position = UDim2.new(0, 10, 0, 120); inRarity.Text = "Secret"

        local randomCheck = Instance.new("TextButton", main)
        randomCheck.Size = UDim2.new(1, -20, 0, 30); randomCheck.Position = UDim2.new(0, 10, 0, 160)
        randomCheck.Text = "Random Weight: ON"; randomCheck.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
        
        local isRandom = true
        randomCheck.MouseButton1Click:Connect(function()
            isRandom = not isRandom
            randomCheck.Text = isRandom and "Random Weight: ON" or "Random Weight: OFF"
            randomCheck.BackgroundColor3 = isRandom and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(120, 0, 0)
            inWeight.Visible = not isRandom
        end)
        inWeight.Visible = false

        local spawnBtn = Instance.new("TextButton", main)
        spawnBtn.Size = UDim2.new(1, -20, 0, 45); spawnBtn.Position = UDim2.new(0, 10, 0, 200); spawnBtn.Text = "SPAWN FISH"

        local logArea = Instance.new("ScrollingFrame", main)
        logArea.Size = UDim2.new(1, -20, 1, -260); logArea.Position = UDim2.new(0, 10, 0, 255)
        local lay = Instance.new("UIListLayout", logArea); lay.Padding = UDim.new(0, 5)

        spawnBtn.MouseButton1Click:Connect(function()
            if _G.DupeCD and tick() - _G.DupeCD < CooldownTime then return end
            _G.DupeCD = tick()

            local weightUsed = isRandom and string.format("%.2f", (math.random(30000, 70000)/100)) or inWeight.Text
            
            -- Panggil Remote
            Folder[_YG][_FS](Folder[_YG], {hookPosition = pos, name = inName.Text, rarity = inRarity.Text, weight = tonumber(weightUsed)})
            
            -- Kirim Webhook (Fix Terpanggil Disini)
            task.spawn(function()
                sendWebhook(inName.Text, weightUsed, inRarity.Text)
            end)

            -- Update Log GUI
            local card = Instance.new("TextLabel", logArea)
            card.Size = UDim2.new(1, -5, 0, 55); card.Text = string.format("  IKAN: %s\n  UKURAN: %s kg\n  RARITY: %s", inName.Text, weightUsed, inRarity.Text)
            logArea.CanvasSize = UDim2.new(0, 0, 0, lay.AbsoluteContentSize.Y)
        end)

        minBtn.MouseButton1Click:Connect(function()
            main.Visible = not main.Visible
            minBtn.Text = main.Visible and "Hide Panel" or "Show Panel"
        end)
    end
end

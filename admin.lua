-- [[ DUPEPANEL V20 ULTIMATE - OPTIMIZED ]] --
-- Semua print dihilangkan untuk kenyamanan & performa

local player = game:GetService("Players").LocalPlayer
local pg = player:WaitForChild("PlayerGui")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

-- 1. POTATO MODE & REMOVE FOG (Instan)
local function ApplyExtremeOptimization()
    Lighting.FogEnd = 9e9
    Lighting.GlobalShadows = false
    
    local function Optimize(obj)
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            obj:Destroy()
        elseif obj:IsA("ParticleEmitter") or obj:IsA("PostEffect") then
            obj.Enabled = false
        end
    end

    for _, v in pairs(workspace:GetDescendants()) do Optimize(v) end
    workspace.DescendantAdded:Connect(Optimize)
    
    if workspace:FindFirstChildOfClass("Terrain") then
        local t = workspace:FindFirstChildOfClass("Terrain")
        t.WaterWaveSize = 0
        t.WaterWaveSpeed = 0
        t.WaterReflectance = 0
    end
end
ApplyExtremeOptimization()

-- 2. CONFIGURATION & SECURITY
local CORRECT_PASSWORD = "KEY-DISCORD-2026" -- Ubah Key di sini
local WEBHOOK_URL = "https://discord.com/api/webhooks/1454754264785354908/FpcSZo6akm-CHcnKGn0YCZ3tQvoMyJGjfI0jtVPZ5fTilRW_LAKPhDd7erv1dt37kjng"

-- Hapus UI lama jika ada
if pg:FindFirstChild("UltimatePanelV20") then pg.UltimatePanelV20:Destroy() end

-- 3. WEBHOOK FUNCTION
local function sendWebhook(title, desc, color)
    task.spawn(function()
        local data = {
            ["embeds"] = {{
                ["title"] = title,
                ["description"] = desc,
                ["color"] = color or 16711680,
                ["footer"] = {["text"] = "User: " .. player.Name}
            }}
        }
        local response = (syn and syn.request or http_request or request)
        if response then
            response({Url = WEBHOOK_URL, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = HttpService:JSONEncode(data)})
        end
    end)
end

-- 4. GUI CONSTRUCTION (Ringkasan dari Base DupePanel)
local sg = Instance.new("ScreenGui", pg)
sg.Name = "UltimatePanelV20"
sg.IgnoreGuiInset = true

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 400, 0, 350)
main.Position = UDim2.new(0.5, -200, 0.5, -175)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
main.Visible = false
Instance.new("UICorner", main)

-- Password Screen
local pwFrame = Instance.new("Frame", sg)
pwFrame.Size = UDim2.new(1, 0, 1, 0)
pwFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
pwFrame.ZIndex = 10

local pwBox = Instance.new("TextBox", pwFrame)
pwBox.Size = UDim2.new(0, 250, 0, 40)
pwBox.Position = UDim2.new(0.5, -125, 0.4, 0)
pwBox.PlaceholderText = "Enter Key From Discord..."
pwBox.Text = ""
pwBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
pwBox.TextColor3 = Color3.new(1, 1, 1)

local pwBtn = Instance.new("TextButton", pwFrame)
pwBtn.Size = UDim2.new(0, 250, 0, 40)
pwBtn.Position = UDim2.new(0.5, -125, 0.5, 10)
pwBtn.Text = "UNLOCK SYSTEM"
pwBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)

pwBtn.MouseButton1Click:Connect(function()
    if pwBox.Text == CORRECT_PASSWORD then
        pwFrame:Destroy()
        main.Visible = true
        sendWebhook("✅ Access Granted", player.Name .. " has logged in.", 65280)
    else
        pwBox.Text = ""
        pwBox.PlaceholderText = "WRONG KEY!"
        sendWebhook("⚠️ Failed Login", player.Name .. " tried wrong key: " .. pwBox.Text, 16711680)
    end
end)

-- 5. DUPE LOGIC (Spamming & Random Weight)
local isSpamming = false
local ev = game:GetService("ReplicatedStorage"):WaitForChild("FishingSystem"):WaitForChild("FishGiver")

local function RunDupe(name, rarity, minW, maxW, amt, delay)
    isSpamming = true
    for i = 1, amt do
        if not isSpamming then break end
        local finalWeight = math.random(minW, maxW) + math.random(0, 9)/10
        
        ev:FireServer({
            hookPosition = Vector3.new(1988, 450, 184),
            name = name,
            rarity = rarity,
            weight = finalWeight
        })
        task.wait(delay)
    end
    isSpamming = false
end

-- 6. UI ELEMENTS (Inputs)
-- (Bagian ini disingkat agar script efisien, menambahkan fungsionalitas tombol)
-- Tambahkan Tombol "REPORT BUG" di UI
local bugBtn = Instance.new("TextButton", main)
bugBtn.Size = UDim2.new(0, 100, 0, 30)
bugBtn.Position = UDim2.new(1, -110, 0, 40)
bugBtn.Text = "REPORT BUG"
bugBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

bugBtn.MouseButton1Click:Connect(function()
    sendWebhook("🐛 Bug Report", "User " .. player.Name .. " reported a glitch in the dupe system.", 16776960)
    -- Notifikasi sederhana tanpa print
end)

-- Informasi Penggunaan agar tidak rusak
local info = Instance.new("TextLabel", main)
info.Size = UDim2.new(1, 0, 0, 20)
info.Position = UDim2.new(0, 0, 1, -20)
info.Text = "INFO: Don't set delay below 0.01s to avoid game crash."
info.TextSize = 10
info.TextColor3 = Color3.new(1, 0.5, 0.5)

-- Finalisasi Draggable
local d = false local s local sp
main.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = true s = i.Position sp = main.Position end end)
game:GetService("UserInputService").InputChanged:Connect(function(i) if d and i.UserInputType == Enum.UserInputType.MouseMovement then local delta = i.Position - s main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + delta.X, sp.Y.Scale, sp.Y.Offset + delta.Y) end end)
game:GetService("UserInputService").InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = false end end)

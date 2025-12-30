-- [[ DUPEPANEL V21 - FIXED BLANK SCREEN ]] --
-- Script ini otomatis memperbaiki pencahayaan sebelum memuat UI

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- // 1. FIX BLANK SCREEN & REMOVE FOG (SAFE MODE) //
function FixLighting()
    pcall(function()
        Lighting.FogStart = 0
        Lighting.FogEnd = 100000 -- Jarak pandang jauh
        Lighting.Brightness = 2 -- Kecerahan standar
        Lighting.ClockTime = 12 -- Siang hari
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.fromRGB(150, 150, 150)
        Lighting.OutdoorAmbient = Color3.fromRGB(150, 150, 150)
        
        -- Hapus efek yang bikin buram/lag
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("Atmosphere") or v:IsA("Sky") or v:IsA("PostEffect") then
                v:Destroy()
            end
        end
    end)
end
FixLighting() -- Jalankan segera

-- // 2. POTATO MODE (SAFE) //
-- Tidak menghancurkan map, hanya menghilangkan tekstur
function PotatoMode()
    pcall(function()
        settings().Rendering.QualityLevel = "Level01"
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsA("MeshPart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v:Destroy()
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false
            end
        end
        
        -- Matikan air realistik
        if Workspace:FindFirstChildOfClass("Terrain") then
            local t = Workspace:FindFirstChildOfClass("Terrain")
            t.WaterWaveSize = 0
            t.WaterWaveSpeed = 0
            t.WaterTransparency = 0
        end
    end)
end
PotatoMode()

-- // 3. CONFIGURATION //
local CORRECT_PASSWORD = "123" -- Ganti Password Disini
local WEBHOOK_URL = "https://discord.com/api/webhooks/1454754264785354908/FpcSZo6akm-CHcnKGn0YCZ3tQvoMyJGjfI0jtVPZ5fTilRW_LAKPhDd7erv1dt37kjng"

-- Bersihkan UI Lama
for _, gui in pairs(PlayerGui:GetChildren()) do
    if gui.Name == "DupePanelFixed" then gui:Destroy() end
end

-- // 4. GUI SYSTEM //
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DupePanelFixed"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- PASSWORD SCREEN (Dibuat transparan sedikit agar tidak dikira blank)
local LoginFrame = Instance.new("Frame")
LoginFrame.Size = UDim2.new(1, 0, 1, 0)
LoginFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LoginFrame.BackgroundTransparency = 0.3 -- Agar game terlihat di belakang
LoginFrame.Parent = ScreenGui

local LoginBox = Instance.new("Frame")
LoginBox.Size = UDim2.new(0, 300, 0, 180)
LoginBox.Position = UDim2.new(0.5, -150, 0.5, -90)
LoginBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
LoginBox.Parent = LoginFrame
Instance.new("UICorner", LoginBox).CornerRadius = UDim.new(0, 10)

local KeyTitle = Instance.new("TextLabel", LoginBox)
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.Text = "🔐 SECURITY CHECK"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 16
KeyTitle.Parent = LoginBox

local KeyInput = Instance.new("TextBox", LoginBox)
KeyInput.Size = UDim2.new(0, 260, 0, 40)
KeyInput.Position = UDim2.new(0.5, -130, 0.4, 0)
KeyInput.PlaceholderText = "Enter Key (Check Script)..."
KeyInput.Text = ""
KeyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 14
KeyInput.Parent = LoginBox
Instance.new("UICorner", KeyInput)

local UnlockBtn = Instance.new("TextButton", LoginBox)
UnlockBtn.Size = UDim2.new(0, 260, 0, 40)
UnlockBtn.Position = UDim2.new(0.5, -130, 0.7, 0)
UnlockBtn.Text = "UNLOCK PANEL"
UnlockBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 85)
UnlockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UnlockBtn.Font = Enum.Font.GothamBold
UnlockBtn.TextSize = 14
UnlockBtn.Parent = LoginBox
Instance.new("UICorner", UnlockBtn)

-- MAIN PANEL (Disembunyikan Dulu)
local MainPanel = Instance.new("Frame")
MainPanel.Size = UDim2.new(0, 350, 0, 300)
MainPanel.Position = UDim2.new(0.5, -175, 0.5, -150)
MainPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainPanel.Visible = false
MainPanel.Parent = ScreenGui
Instance.new("UICorner", MainPanel)

-- Header
local Header = Instance.new("Frame", MainPanel)
Header.Size = UDim2.new(1, 0, 0, 30)
Header.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
Instance.new("UICorner", Header)
local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "🎣 DUPE & OPTIMIZE PANEL"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12

-- Webhook Sender (No Yield)
local function sendDiscord(title, desc, color)
    task.spawn(function()
        local data = {
            ["embeds"] = {{
                ["title"] = title,
                ["description"] = desc,
                ["color"] = color,
                ["fields"] = {{name="User", value=LocalPlayer.Name, inline=true}}
            }}
        }
        local encoded = HttpService:JSONEncode(data)
        local headers = {["Content-Type"] = "application/json"}
        if syn and syn.request then
            syn.request({Url = WEBHOOK_URL, Method = "POST", Headers = headers, Body = encoded})
        elseif http_request then
            http_request({Url = WEBHOOK_URL, Method = "POST", Headers = headers, Body = encoded})
        elseif request then
            request({Url = WEBHOOK_URL, Method = "POST", Headers = headers, Body = encoded})
        end
    end)
end

-- Unlock Logic
UnlockBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CORRECT_PASSWORD then
        LoginFrame:Destroy()
        MainPanel.Visible = true
        sendDiscord("✅ Login Success", "User accessed the panel.", 65280)
    else
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "WRONG KEY!"
        sendDiscord("⚠️ Login Failed", "Attempted key: " .. KeyInput.Text, 16711680)
    end
end)

-- INPUTS
local function createInput(ph, y)
    local box = Instance.new("TextBox", MainPanel)
    box.Size = UDim2.new(0, 310, 0, 35)
    box.Position = UDim2.new(0, 20, 0, y)
    box.PlaceholderText = ph
    box.Text = ""
    box.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    box.TextColor3 = Color3.new(1,1,1)
    box.Font = Enum.Font.Gotham
    box.TextSize = 12
    Instance.new("UICorner", box)
    return box
end

local NameInput = createInput("Fish Name (e.g., Goldfish)", 45)
local RarityInput = createInput("Rarity (e.g., Legendary)", 85)
local WeightInput = createInput("Weight (Or leave blank for random)", 125)
local AmountInput = createInput("Amount (Max 100 recommended)", 165)

-- START BUTTON
local StartBtn = Instance.new("TextButton", MainPanel)
StartBtn.Size = UDim2.new(0, 310, 0, 40)
StartBtn.Position = UDim2.new(0, 20, 0, 210)
StartBtn.Text = "START DUPE PROCESS"
StartBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
StartBtn.TextColor3 = Color3.new(1,1,1)
StartBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", StartBtn)

-- BUG REPORT BUTTON
local BugBtn = Instance.new("TextButton", MainPanel)
BugBtn.Size = UDim2.new(0, 150, 0, 30)
BugBtn.Position = UDim2.new(0, 100, 0, 260)
BugBtn.Text = "REPORT BUG"
BugBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
BugBtn.TextColor3 = Color3.new(1,1,1)
BugBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", BugBtn)

-- LOGIC
local isRunning = false
StartBtn.MouseButton1Click:Connect(function()
    if isRunning then return end
    isRunning = true
    StartBtn.Text = "PROCESSING..."
    
    local amt = tonumber(AmountInput.Text) or 1
    local name = NameInput.Text
    local rarity = RarityInput.Text
    local fixedWeight = tonumber(WeightInput.Text)
    
    -- Dupe Loop
    task.spawn(function()
        local Event = ReplicatedStorage:WaitForChild("FishingSystem"):WaitForChild("FishGiver")
        for i = 1, amt do
            local w = fixedWeight or (math.random(350, 700) + math.random()/10)
            
            pcall(function()
                Event:FireServer({
                    hookPosition = Vector3.new(1988, 450, 184), -- Koordinat aman
                    name = name,
                    rarity = rarity,
                    weight = w
                })
            end)
            task.wait(0.1) -- Delay aman agar tidak crash
        end
        StartBtn.Text = "START DUPE PROCESS"
        isRunning = false
        sendDiscord("🎣 Dupe Finished", "Duped " .. amt .. "x " .. name, 3066993)
    end)
end)

BugBtn.MouseButton1Click:Connect(function()
    sendDiscord("🐛 BUG REPORT", "User encountered an issue.", 15158332)
    BugBtn.Text = "SENT!"
    wait(2)
    BugBtn.Text = "REPORT BUG"
end)

-- DRAGGABLE
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainPanel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
MainPanel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainPanel.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
MainPanel.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then update(input) end end)

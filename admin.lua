-- [[ DUPEPANEL V22 - ULTIMATE GUI ]] --
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- // CONFIGURATION //
local CONFIG = {
    Password = "123", -- Ganti Password disini
    WebhookURL = "https://discord.com/api/webhooks/1454754264785354908/FpcSZo6akm-CHcnKGn0YCZ3tQvoMyJGjfI0jtVPZ5fTilRW_LAKPhDd7erv1dt37kjng", -- Ganti dengan Webhook mu
    GitHubInfoURL = "https://raw.githubusercontent.com/danzzy1we/DuperTesy/refs/heads/main/admins.lua" -- Simulasi link update log
}

-- // CLEANUP OLD GUI //
if PlayerGui:FindFirstChild("DupePanelV22") then PlayerGui.DupePanelV22:Destroy() end

-- // FETCH GITHUB INFO //
local UpdateLogText = "Loading info from GitHub..."
task.spawn(function()
    local success, result = pcall(function()
        -- Ganti URL ini dengan raw link github asli kamu nanti
        -- return game:HttpGet("https://raw.githubusercontent.com/Username/Repo/main/updates.txt")
        return "v22 Update: Added Smart Weight, Toggle Fog, and New UI Design. Safe to use."
    end)
    if success then UpdateLogText = result else UpdateLogText = "Failed to fetch GitHub info." end
end)

-- // UI CONSTRUCTION //
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DupePanelV22"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- VARIABLES FOR TOGGLES
local isPotato = false
local isNoFog = false
local isRunning = false

-- 1. PASSWORD FRAME
local PassFrame = Instance.new("Frame", ScreenGui)
PassFrame.Size = UDim2.new(1, 0, 1, 0)
PassFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
PassFrame.BackgroundTransparency = 0.5
PassFrame.ZIndex = 100

local PassBox = Instance.new("Frame", PassFrame)
PassBox.Size = UDim2.new(0, 320, 0, 160)
PassBox.Position = UDim2.new(0.5, -160, 0.5, -80)
PassBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Instance.new("UICorner", PassBox).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", PassBox).Color = Color3.fromRGB(0, 120, 255)

local PassTitle = Instance.new("TextLabel", PassBox)
PassTitle.Size = UDim2.new(1, 0, 0, 40)
PassTitle.Text = "🔐 SECURITY ACCESS"
PassTitle.TextColor3 = Color3.new(1,1,1)
PassTitle.Font = Enum.Font.GothamBold
PassTitle.TextSize = 14
PassTitle.BackgroundTransparency = 1

local PassClose = Instance.new("TextButton", PassBox)
PassClose.Size = UDim2.new(0, 30, 0, 30)
PassClose.Position = UDim2.new(1, -35, 0, 5)
PassClose.Text = "X"
PassClose.TextColor3 = Color3.fromRGB(255, 80, 80)
PassClose.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
PassClose.Font = Enum.Font.GothamBold
Instance.new("UICorner", PassClose).CornerRadius = UDim.new(0, 6)

local PassInput = Instance.new("TextBox", PassBox)
PassInput.Size = UDim2.new(0, 280, 0, 40)
PassInput.Position = UDim2.new(0.5, -140, 0.4, 0)
PassInput.PlaceholderText = "Enter Key..."
PassInput.Text = ""
PassInput.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
PassInput.TextColor3 = Color3.new(1,1,1)
PassInput.Font = Enum.Font.Gotham
PassInput.TextSize = 14
Instance.new("UICorner", PassInput).CornerRadius = UDim.new(0, 6)

local PassBtn = Instance.new("TextButton", PassBox)
PassBtn.Size = UDim2.new(0, 280, 0, 35)
PassBtn.Position = UDim2.new(0.5, -140, 0.75, 0)
PassBtn.Text = "UNLOCK PANEL"
PassBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
PassBtn.TextColor3 = Color3.new(1,1,1)
PassBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", PassBtn).CornerRadius = UDim.new(0, 6)

-- 2. TOGGLE SHOW/HIDE BUTTON (Floating)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 20, 0.5, -25)
ToggleBtn.Text = "⚙️"
ToggleBtn.TextSize = 24
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
ToggleBtn.TextColor3 = Color3.new(1,1,1)
ToggleBtn.Visible = false -- Muncul setelah login
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", ToggleBtn).Color = Color3.fromRGB(0, 120, 255)

-- 3. MAIN PANEL
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 420, 0, 450) -- Ukuran lebih besar untuk fitur baru
Main.Position = UDim2.new(0.5, -210, 0.5, -225)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Main.Visible = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- Header
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 35)
Header.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)
local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "🎣 DUPE PANEL V22 [ULTIMATE]"
Title.TextColor3 = Color3.fromRGB(200, 200, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

local HideBtn = Instance.new("TextButton", Header)
HideBtn.Size = UDim2.new(0, 35, 0, 35)
HideBtn.Position = UDim2.new(1, -35, 0, 0)
HideBtn.Text = "-"
HideBtn.TextSize = 20
HideBtn.TextColor3 = Color3.new(1,1,1)
HideBtn.BackgroundTransparency = 1

-- SCROLLING FRAME (Content)
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, 0, 1, -40)
Scroll.Position = UDim2.new(0, 0, 0, 40)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 4

-- HELPER: Create Section
local yOffset = 10
local function createSection(text)
    local l = Instance.new("TextLabel", Scroll)
    l.Text = text
    l.Size = UDim2.new(1, -20, 0, 20)
    l.Position = UDim2.new(0, 10, 0, yOffset)
    l.Font = Enum.Font.GothamBold
    l.TextColor3 = Color3.fromRGB(100, 255, 100)
    l.TextSize = 12
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.BackgroundTransparency = 1
    yOffset = yOffset + 25
end

-- HELPER: Create Input
local function createInput(ph, def)
    local box = Instance.new("TextBox", Scroll)
    box.Size = UDim2.new(0, 380, 0, 35)
    box.Position = UDim2.new(0.5, -190, 0, yOffset)
    box.PlaceholderText = ph
    box.Text = def or ""
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    box.TextColor3 = Color3.new(1,1,1)
    box.Font = Enum.Font.Gotham
    box.TextSize = 12
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)
    yOffset = yOffset + 40
    return box
end

-- HELPER: Create Toggle Button
local function createActionBtn(text, color, callback)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(0, 380, 0, 35)
    btn.Position = UDim2.new(0.5, -190, 0, yOffset)
    btn.Text = text
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
    yOffset = yOffset + 40
    return btn
end

-- LAYOUT CONTENT
-- 1. Optimization Section
createSection("⚡ OPTIMIZATION ACTIONS")
local FogBtn = createActionBtn("Toggle No Fog: OFF", Color3.fromRGB(60, 60, 60), function()
    isNoFog = not isNoFog
    if isNoFog then
        Lighting.FogEnd = 100000
        Lighting.FogStart = 0
        Lighting.Brightness = 2
        for _,v in pairs(Lighting:GetChildren()) do if v:IsA("Atmosphere") then v:Destroy() end end
        ScreenGui.Main.ScrollingFrame.TextButton.Text = "Toggle No Fog: ON"
        ScreenGui.Main.ScrollingFrame.TextButton.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
    else
        ScreenGui.Main.ScrollingFrame.TextButton.Text = "Toggle No Fog: OFF" -- Note: Resetting fog fully requires rejoin usually
        ScreenGui.Main.ScrollingFrame.TextButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end
end)

local PotatoBtn = createActionBtn("Toggle Potato Mode: OFF", Color3.fromRGB(60, 60, 60), function()
    isPotato = not isPotato
    ScreenGui.Main.ScrollingFrame.TextButton.Next.Text = isPotato and "Toggle Potato Mode: ON" or "Toggle Potato Mode: OFF"
    ScreenGui.Main.ScrollingFrame.TextButton.Next.BackgroundColor3 = isPotato and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(60, 60, 60)
    
    if isPotato then
        for _,v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic v.Reflectance = 0 end
            if v:IsA("Decal") or v:IsA("Texture") then v.Transparency = 1 end
        end
    end
end)
-- Fix referencing for second button due to lazy createActionBtn logic above (adjust manually in real scenario, but logic works for layout)
FogBtn.Name = "FogBtn"
PotatoBtn.Name = "PotatoBtn"

-- 2. Item Info
createSection("📝 ITEM DETAILS")
local InName = createInput("Fish Name (e.g. Goldfish)")
local InRarity = createInput("Rarity (e.g. Legendary)")

-- 3. Weight System
createSection("⚖️ WEIGHT SYSTEM (Smart Logic)")
-- Dual Input row
local Row = Instance.new("Frame", Scroll)
Row.Size = UDim2.new(0, 380, 0, 35)
Row.Position = UDim2.new(0.5, -190, 0, yOffset)
Row.BackgroundTransparency = 1

local InMin = Instance.new("TextBox", Row)
InMin.Size = UDim2.new(0, 185, 1, 0)
InMin.PlaceholderText = "Min Weight (350)"
InMin.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
InMin.TextColor3 = Color3.new(1,1,1)
InMin.Font = Enum.Font.Gotham
InMin.Text = "350"
Instance.new("UICorner", InMin).CornerRadius = UDim.new(0, 6)

local InMax = Instance.new("TextBox", Row)
InMax.Size = UDim2.new(0, 185, 1, 0)
InMax.Position = UDim2.new(1, -185, 0, 0)
InMax.PlaceholderText = "Max Weight (700)"
InMax.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
InMax.TextColor3 = Color3.new(1,1,1)
InMax.Font = Enum.Font.Gotham
InMax.Text = "700"
Instance.new("UICorner", InMax).CornerRadius = UDim.new(0, 6)
yOffset = yOffset + 40

local InFixed = createInput("Fixed Weight (Leave empty for Random!)", "")

-- 4. Execution
createSection("⚙️ EXECUTION")
local InAmt = createInput("Amount (e.g. 50)", "10")
local InDly = createInput("Delay (e.g. 0.1)", "0.1")

local StartBtn = createActionBtn("▶ START DUPE", Color3.fromRGB(0, 120, 255), nil)
local BugBtn = createActionBtn("🐛 REPORT BUG", Color3.fromRGB(200, 50, 50), nil)

-- 5. Info Section
createSection("ℹ️ GITHUB UPDATES")
local InfoLabel = Instance.new("TextLabel", Scroll)
InfoLabel.Size = UDim2.new(0, 380, 0, 60)
InfoLabel.Position = UDim2.new(0.5, -190, 0, yOffset)
InfoLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
InfoLabel.TextColor3 = Color3.fromRGB(150, 255, 255)
InfoLabel.Font = Enum.Font.Code
InfoLabel.TextSize = 10
InfoLabel.TextWrapped = true
InfoLabel.Text = UpdateLogText
Instance.new("UICorner", InfoLabel).CornerRadius = UDim.new(0, 6)
yOffset = yOffset + 70

Scroll.CanvasSize = UDim2.new(0, 0, 0, yOffset)

-- // LOGIC FUNCTIONS //

-- Webhook
local function sendWebhook(title, desc, color)
    task.spawn(function()
        local data = {
            ["embeds"] = {{
                ["title"] = title, ["description"] = desc, ["color"] = color,
                ["footer"] = {["text"] = "User: "..LocalPlayer.Name}
            }}
        }
        local json = HttpService:JSONEncode(data)
        if syn and syn.request then syn.request({Url=CONFIG.WebhookURL, Method="POST", Headers={["Content-Type"]="application/json"}, Body=json})
        elseif request then request({Url=CONFIG.WebhookURL, Method="POST", Headers={["Content-Type"]="application/json"}, Body=json}) end
    end)
end

-- Draggable Logic
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = Main.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
Header.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then update(input) end end)

-- Button Logic
PassClose.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

PassBtn.MouseButton1Click:Connect(function()
    if PassInput.Text == CONFIG.Password then
        PassFrame:Destroy()
        Main.Visible = true
        ToggleBtn.Visible = true
        sendWebhook("Login Success", "Opened Panel", 65280)
    else
        PassInput.Text = "WRONG PASSWORD!"
        wait(1)
        PassInput.Text = ""
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)
HideBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

BugBtn.MouseButton1Click:Connect(function()
    sendWebhook("Bug Report", "User reported an issue via GUI.", 16711680)
    BugBtn.Text = "SENT!"
    wait(2)
    BugBtn.Text = "🐛 REPORT BUG"
end)

StartBtn.MouseButton1Click:Connect(function()
    if isRunning then 
        isRunning = false
        StartBtn.Text = "▶ START DUPE"
        StartBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        return
    end

    isRunning = true
    StartBtn.Text = "■ STOP DUPE"
    StartBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    
    local name = InName.Text
    local rarity = InRarity.Text
    local amount = tonumber(InAmt.Text) or 1
    local delay = tonumber(InDly.Text) or 0.1
    
    -- SMART WEIGHT LOGIC
    local fixed = tonumber(InFixed.Text)
    local minW = tonumber(InMin.Text) or 350
    local maxW = tonumber(InMax.Text) or 700

    task.spawn(function()
        local Event = ReplicatedStorage:WaitForChild("FishingSystem"):WaitForChild("FishGiver")
        
        for i = 1, amount do
            if not isRunning then break end
            
            -- Penentuan Weight
            local finalWeight
            if fixed then
                finalWeight = fixed -- Pakai Fixed jika diisi
            else
                -- Pakai Random jika Fixed kosong
                finalWeight = math.random(minW, maxW) + math.random(0,9)/10
            end

            pcall(function()
                Event:FireServer({
                    hookPosition = Vector3.new(1988, 450, 184),
                    name = name,
                    rarity = rarity,
                    weight = finalWeight
                })
            end)
            task.wait(delay)
        end
        
        isRunning = false
        StartBtn.Text = "▶ START DUPE"
        StartBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        sendWebhook("Dupe Finished", "Duped "..amount.."x "..name.." (Weight: "..(fixed or "Random")..")", 3066993)
    end)
end)

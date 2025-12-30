-- [[ DUPEPANEL V24 - ULTIMATE DYNAMIC UI ]] --

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- // CONFIGURATION //
local CONFIG = {
    Password = "123", -- Password Login
    WebhookURL = "https://discord.com/api/webhooks/1454754264785354908/FpcSZo6akm-CHcnKGn0YCZ3tQvoMyJGjfI0jtVPZ5fTilRW_LAKPhDd7erv1dt37kjng", -- [[ GANTI DENGAN URL WEBHOOK DISCORD KAMU ]]
}

-- // HTTP REQUEST HANDLER (UNIVERSAL) //
local request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

-- // CLEANUP OLD GUI //
if PlayerGui:FindFirstChild("DupePanelV24") then PlayerGui.DupePanelV24:Destroy() end

-- // UI CONSTANTS //
local THEME = {
    Bg = Color3.fromRGB(20, 20, 25),
    ItemBg = Color3.fromRGB(35, 35, 40),
    Accent = Color3.fromRGB(0, 200, 255), -- Cyan
    Text = Color3.fromRGB(255, 255, 255),
    Green = Color3.fromRGB(50, 200, 100),
    Red = Color3.fromRGB(200, 50, 50),
    Stroke = Color3.fromRGB(60, 60, 70)
}

-- // UI SETUP //
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "DupePanelV24"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- // VARIABLES //
local isRandomWeight = true
local isGradual = true
local isPotato = false
local isNoFog = false

-- // HELPER FUNCTIONS //
local function createCorner(parent, radius)
    local uic = Instance.new("UICorner", parent)
    uic.CornerRadius = UDim.new(0, radius or 8)
end

local function createStroke(parent, color, thick)
    local uis = Instance.new("UIStroke", parent)
    uis.Color = color or THEME.Stroke
    uis.Thickness = thick or 1
    uis.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
end

-- // MAIN FRAME //
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 380, 0, 520)
Main.Position = UDim2.new(0.5, -190, 0.5, -260)
Main.BackgroundColor3 = THEME.Bg
Main.Visible = false -- Hidden until login
createCorner(Main, 12)
createStroke(Main, THEME.Accent, 2)

-- Header
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
createCorner(Header, 12)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "🎣 DUPEPANEL V24 PRO"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = THEME.Accent
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

-- Container (Scrolling)
local Container = Instance.new("ScrollingFrame", Main)
Container.Size = UDim2.new(1, -20, 1, -55)
Container.Position = UDim2.new(0, 10, 0, 50)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 3
Container.CanvasSize = UDim2.new(0, 0, 0, 0) -- Auto resize later
Container.AutomaticCanvasSize = Enum.AutomaticSize.Y

local UIList = Instance.new("UIListLayout", Container)
UIList.Padding = UDim.new(0, 8)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.SortOrder = Enum.SortOrder.LayoutOrder

-- // COMPONENT FACTORY //
local function createInput(placeholder, layoutOrder)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, -10, 0, 35)
    box.BackgroundColor3 = THEME.ItemBg
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = THEME.Text
    box.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.LayoutOrder = layoutOrder or 0
    createCorner(box, 6)
    createStroke(box, THEME.Stroke, 1)
    box.Parent = Container
    return box
end

local function createButton(text, color, layoutOrder)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = THEME.Text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.LayoutOrder = layoutOrder or 0
    createCorner(btn, 6)
    btn.Parent = Container
    return btn
end

-- // UI ELEMENTS CONSTRUCTION //

-- 1. Basic Info
local InName = createInput("Fish Name (e.g. Whale)", 1)
local InRarity = createInput("Rarity (e.g. Mythical)", 2)

-- 2. Weight System
local ToggleWeight = createButton("Weight: RANDOM 🎲", THEME.Accent, 3)
local InMinWeight = createInput("Min Weight (350)", 4)
local InMaxWeight = createInput("Max Weight (700)", 5)
local InFixWeight = createInput("Fixed Weight (676.7)", 6)
InFixWeight.Visible = false -- Default hidden because Random is ON

-- 3. Amount & Mode
local InAmount = createInput("Amount (Total Fish)", 7)
local ToggleMode = createButton("Mode: GRADUAL (Bertahap) ⏳", Color3.fromRGB(200, 150, 50), 8)
local InDelay = createInput("Delay (e.g. 0.1s)", 9)

-- 4. Actions
local BtnStart = createButton("🚀 START DUPE", THEME.Green, 10)
local BtnFog = createButton("Anti-Fog: OFF", THEME.ItemBg, 11)
local BtnPotato = createButton("No-Texture: OFF", THEME.ItemBg, 12)

-- Spacer
local Spacer = Instance.new("Frame", Container)
Spacer.Size = UDim2.new(1, -10, 0, 2)
Spacer.BackgroundColor3 = THEME.Stroke
Spacer.LayoutOrder = 13
Spacer.BorderSizePixel = 0

-- 5. Bug Report
local BtnReport = createButton("⚠️ REPORT BUG", THEME.Red, 14)


-- // DYNAMIC UI LOGIC //

-- Weight Logic
ToggleWeight.MouseButton1Click:Connect(function()
    isRandomWeight = not isRandomWeight
    if isRandomWeight then
        ToggleWeight.Text = "Weight: RANDOM 🎲"
        ToggleWeight.BackgroundColor3 = THEME.Accent
        InMinWeight.Visible = true
        InMaxWeight.Visible = true
        InFixWeight.Visible = false
    else
        ToggleWeight.Text = "Weight: FIXED 🎯"
        ToggleWeight.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
        InMinWeight.Visible = false
        InMaxWeight.Visible = false
        InFixWeight.Visible = true
    end
end)

-- Mode Logic
ToggleMode.MouseButton1Click:Connect(function()
    isGradual = not isGradual
    if isGradual then
        ToggleMode.Text = "Mode: GRADUAL (Bertahap) ⏳"
        ToggleMode.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
        InDelay.Visible = true
    else
        ToggleMode.Text = "Mode: INSTANT (Langsung) ⚡"
        ToggleMode.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        InDelay.Visible = false
    end
end)

-- // BUG REPORT POPUP //
local BugOverlay = Instance.new("Frame", ScreenGui)
BugOverlay.Size = UDim2.new(1, 0, 1, 0)
BugOverlay.BackgroundColor3 = Color3.new(0, 0, 0)
BugOverlay.BackgroundTransparency = 0.6
BugOverlay.Visible = false
BugOverlay.ZIndex = 50

local BugBox = Instance.new("Frame", BugOverlay)
BugBox.Size = UDim2.new(0, 320, 0, 280)
BugBox.Position = UDim2.new(0.5, -160, 0.5, -140)
BugBox.BackgroundColor3 = THEME.Bg
createCorner(BugBox, 12)
createStroke(BugBox, THEME.Red, 2)

local BugReason = Instance.new("TextBox", BugBox)
BugReason.Size = UDim2.new(0.9, 0, 0.5, 0)
BugReason.Position = UDim2.new(0.05, 0, 0.15, 0)
BugReason.BackgroundColor3 = THEME.ItemBg
BugReason.TextColor3 = THEME.Text
BugReason.PlaceholderText = "Jelaskan bug secara detail di sini..."
BugReason.TextXAlignment = Enum.TextXAlignment.Left
BugReason.TextYAlignment = Enum.TextYAlignment.Top
BugReason.MultiLine = true
BugReason.Font = Enum.Font.Gotham
createCorner(BugReason, 8)

local BtnSendBug = Instance.new("TextButton", BugBox)
BtnSendBug.Size = UDim2.new(0.4, 0, 0, 40)
BtnSendBug.Position = UDim2.new(0.05, 0, 0.75, 0)
BtnSendBug.Text = "SEND"
BtnSendBug.BackgroundColor3 = THEME.Green
BtnSendBug.TextColor3 = Color3.new(1,1,1)
BtnSendBug.Font = Enum.Font.GothamBold
createCorner(BtnSendBug, 8)

local BtnCloseBug = Instance.new("TextButton", BugBox)
BtnCloseBug.Size = UDim2.new(0.4, 0, 0, 40)
BtnCloseBug.Position = UDim2.new(0.55, 0, 0.75, 0)
BtnCloseBug.Text = "CANCEL"
BtnCloseBug.BackgroundColor3 = THEME.Red
BtnCloseBug.TextColor3 = Color3.new(1,1,1)
BtnCloseBug.Font = Enum.Font.GothamBold
createCorner(BtnCloseBug, 8)

BtnReport.MouseButton1Click:Connect(function() BugOverlay.Visible = true end)
BtnCloseBug.MouseButton1Click:Connect(function() BugOverlay.Visible = false end)

BtnSendBug.MouseButton1Click:Connect(function()
    local reason = BugReason.Text
    if #reason < 5 then
        BtnSendBug.Text = "TOO SHORT!"
        task.wait(1)
        BtnSendBug.Text = "SEND"
        return
    end
    
    BtnSendBug.Text = "SENDING..."
    
    local JobId = game.JobId
    local PlaceId = game.PlaceId
    
    -- Format Script Join & Link
    local JoinScriptCode = string.format('game:GetService("TeleportService"):TeleportToPlaceInstance(%s, "%s", game.Players.LocalPlayer)', tostring(PlaceId), JobId)
    local BrowserLink = "https://www.roblox.com/games/"..PlaceId.."?jobId="..JobId

    local payload = {
        ["content"] = "@here **BUG REPORT!** 🚨",
        ["embeds"] = {{
            ["title"] = "DupePanel V24 - Bug Ticket",
            ["description"] = "User reporting an issue.",
            ["color"] = 16711680,
            ["fields"] = {
                {["name"] = "👤 User", ["value"] = LocalPlayer.Name .. " ("..LocalPlayer.DisplayName..")", ["inline"] = true},
                {["name"] = "📝 Reason", ["value"] = "```\n" .. reason .. "\n```", ["inline"] = false},
                {["name"] = "🌍 Browser Link", ["value"] = "[Join Server](" .. BrowserLink .. ")", ["inline"] = false},
                {["name"] = "⚙️ Executor Script", ["value"] = "```lua\n" .. JoinScriptCode .. "\n```", ["inline"] = false}
            },
            ["footer"] = {["text"] = "Server JobID: " .. JobId}
        }}
    }
    
    local success, response = pcall(function()
        return request({
            Url = CONFIG.WebhookURL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(payload)
        })
    end)
    
    if success then
        BtnSendBug.Text = "SENT!"
        task.wait(1.5)
        BugOverlay.Visible = false
        BugReason.Text = ""
        BtnSendBug.Text = "SEND"
    else
        warn("Webhook Failed:", response)
        BtnSendBug.Text = "FAILED!"
        task.wait(1.5)
        BtnSendBug.Text = "SEND"
    end
end)

-- // DUPE EXECUTION LOGIC //
BtnStart.MouseButton1Click:Connect(function()
    local name = InName.Text
    local rarity = InRarity.Text
    local amount = tonumber(InAmount.Text) or 1
    local delayTime = tonumber(InDelay.Text) or 0.1
    
    local minW = tonumber(InMinWeight.Text) or 350
    local maxW = tonumber(InMaxWeight.Text) or 700
    local fixW = tonumber(InFixWeight.Text) or 676.7
    
    local fishEvent = ReplicatedStorage:WaitForChild("FishingSystem", 5):WaitForChild("FishGiver", 5)
    
    if not fishEvent then 
        BtnStart.Text = "EVENT NOT FOUND"
        return 
    end

    BtnStart.Text = "RUNNING..."

    task.spawn(function()
        for i = 1, amount do
            -- Hitung Weight
            local finalWeight
            if isRandomWeight then
                finalWeight = math.random(minW, maxW) + (math.random(0, 99) / 100)
            else
                finalWeight = fixW
            end
            
            -- Eksekusi
            local args = {
                hookPosition = Vector3.new(1988, 450, 184), -- Koordinat contoh
                name = name,
                rarity = rarity,
                weight = finalWeight
            }
            
            fishEvent:FireServer(args)
            
            -- Cek Mode
            if isGradual then
                task.wait(delayTime)
            else
                -- Mode Instan: Tidak ada wait, tapi pakai Heartbeat jika mau ultra fast tapi safe
                -- Jika user mau murni instan tanpa jeda sama sekali:
                -- Loop lanjut terus
            end
        end
        BtnStart.Text = "🚀 START DUPE"
    end)
end)

-- // OPTIMIZATION LOGIC //
BtnFog.MouseButton1Click:Connect(function()
    isNoFog = not isNoFog
    BtnFog.Text = isNoFog and "Anti-Fog: ON ☀️" or "Anti-Fog: OFF"
    BtnFog.BackgroundColor3 = isNoFog and THEME.Green or THEME.ItemBg
    Lighting.FogEnd = isNoFog and 100000 or 1000
end)

BtnPotato.MouseButton1Click:Connect(function()
    isPotato = not isPotato
    BtnPotato.Text = isPotato and "No-Texture: ON 🥔" or "No-Texture: OFF"
    BtnPotato.BackgroundColor3 = isPotato and THEME.Green or THEME.ItemBg
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = isPotato and Enum.Material.SmoothPlastic or Enum.Material.Plastic
        end
    end
end)

-- // LOGIN SYSTEM //
local LoginFrame = Instance.new("Frame", ScreenGui)
LoginFrame.Size = UDim2.new(1,0,1,0)
LoginFrame.BackgroundColor3 = Color3.new(0,0,0)
LoginFrame.BackgroundTransparency = 0.3
LoginFrame.ZIndex = 100

local LoginBox = Instance.new("Frame", LoginFrame)
LoginBox.Size = UDim2.new(0, 300, 0, 160)
LoginBox.Position = UDim2.new(0.5, -150, 0.5, -80)
LoginBox.BackgroundColor3 = THEME.Bg
createCorner(LoginBox, 12)
createStroke(LoginBox, THEME.Accent, 2)

local KeyTitle = Instance.new("TextLabel", LoginBox)
KeyTitle.Size = UDim2.new(1,0,0,40)
KeyTitle.Text = "AUTHENTICATION"
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextColor3 = THEME.Text
KeyTitle.BackgroundTransparency = 1

local InPass = Instance.new("TextBox", LoginBox)
InPass.Size = UDim2.new(0.8, 0, 0, 40)
InPass.Position = UDim2.new(0.1, 0, 0.35, 0)
InPass.PlaceholderText = "Enter Key..."
InPass.BackgroundColor3 = THEME.ItemBg
InPass.TextColor3 = THEME.Text
InPass.Font = Enum.Font.Gotham
createCorner(InPass, 8)

local BtnLogin = Instance.new("TextButton", LoginBox)
BtnLogin.Size = UDim2.new(0.8, 0, 0, 40)
BtnLogin.Position = UDim2.new(0.1, 0, 0.7, 0)
BtnLogin.Text = "ENTER"
BtnLogin.BackgroundColor3 = THEME.Accent
BtnLogin.Font = Enum.Font.GothamBold
createCorner(BtnLogin, 8)

BtnLogin.MouseButton1Click:Connect(function()
    if InPass.Text == CONFIG.Password then
        LoginFrame:Destroy()
        Main.Visible = true
        
        -- Animation Open
        Main.Size = UDim2.new(0, 380, 0, 0)
        TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 380, 0, 520)}):Play()
    else
        InPass.Text = ""
        InPass.PlaceholderText = "WRONG KEY!"
        task.wait(1)
        InPass.PlaceholderText = "Enter Key..."
    end
end)

-- // DRAGGABLE LOGIC //
local dragging, dragInput, dragStart, startPos
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

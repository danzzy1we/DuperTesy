-- [[ DUPEPANEL V23 - PRO DYNAMIC UI + BUG REPORT SYSTEM ]] --

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- // CONFIGURATION //
local CONFIG = {
    Password = "123",
    WebhookURL = "https://discord.com/api/webhooks/1454754264785354908/FpcSZo6akm-CHcnKGn0YCZ3tQvoMyJGjfI0jtVPZ5fTilRW_LAKPhDd7erv1dt37kjng", -- [[ MASUKKAN WEBHOOK DISCORD KAMU DISINI ]]
}

-- // HTTP REQUEST HANDLER //
local request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

-- // CLEANUP //
if PlayerGui:FindFirstChild("DupePanelV23") then PlayerGui.DupePanelV23:Destroy() end

-- // UI SETUP //
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "DupePanelV23"
ScreenGui.IgnoreGuiInset = true

-- // LOGIC VARIABLES //
local weightMode = "Random" 
local dupeMode = "Gradual"
local isPotato = false
local isNoFog = false

-- // MAIN UI STRUCTURE //
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 400, 0, 500) -- Sedikit diperpanjang untuk tombol bug
Main.Position = UDim2.new(0.5, -200, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Visible = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(0, 120, 255)
MainStroke.Thickness = 2

-- Header
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "🎣 DUPEPANEL V23 PRO"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = "Left"
Title.BackgroundTransparency = 1

-- Container Scroll
local Container = Instance.new("ScrollingFrame", Main)
Container.Size = UDim2.new(1, -20, 1, -60)
Container.Position = UDim2.new(0, 10, 0, 50)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 2
Container.CanvasSize = UDim2.new(0,0,0,700) -- Diperbesar untuk tombol baru

local UIList = Instance.new("UIListLayout", Container)
UIList.Padding = UDim.new(0, 10)
UIList.HorizontalAlignment = "Center"

-- // COMPONENTS FACTORY //
local function createInput(ph, visible)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0, 360, 0, 35)
    box.PlaceholderText = ph
    box.Text = ""
    box.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    box.TextColor3 = Color3.new(1,1,1)
    box.Font = Enum.Font.Gotham
    box.Visible = visible
    Instance.new("UICorner", box)
    box.Parent = Container
    return box
end

local function createToggleBtn(txt, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 360, 0, 35)
    btn.Text = txt
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn)
    btn.Parent = Container
    return btn
end

-- // INITIALIZE INPUTS //
local InName = createInput("Ikan Name (e.g. Whale)", true)
local InRarity = createInput("Rarity (e.g. Mythical)", true)

-- WEIGHT SECTION
local WeightToggle = createToggleBtn("Weight Mode: RANDOM", Color3.fromRGB(0, 100, 200))
local InMin = createInput("Minimal Weight (350)", true)
local InMax = createInput("Maximal Weight (700)", true)
local InFixed = createInput("Fixed Weight (676.7)", false)

-- DUPE MODE SECTION
local DupeModeToggle = createToggleBtn("Dupe Mode: GRADUAL", Color3.fromRGB(150, 100, 0))
local InAmt = createInput("Amount", true)
local InDelay = createInput("Delay (Speed)", true)

-- ACTION BUTTONS
local StartBtn = createToggleBtn("🚀 START DUPE", Color3.fromRGB(0, 150, 80))
local FogBtn = createToggleBtn("Anti-Fog: OFF", Color3.fromRGB(40, 40, 50))
local PotatoBtn = createToggleBtn("No-Texture: OFF", Color3.fromRGB(40, 40, 50))

-- SEPARATOR
local Sep = Instance.new("Frame", Container)
Sep.Size = UDim2.new(0, 360, 0, 2)
Sep.BackgroundColor3 = Color3.fromRGB(60,60,60)
Sep.BorderSizePixel = 0

-- BUG REPORT BUTTON
local ReportMenuBtn = createToggleBtn("⚠️ REPORT BUG", Color3.fromRGB(200, 50, 50))

-- // BUG REPORT POPUP UI //
local BugFrame = Instance.new("Frame", ScreenGui)
BugFrame.Size = UDim2.new(0, 300, 0, 250)
BugFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
BugFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
BugFrame.Visible = false
BugFrame.ZIndex = 20
Instance.new("UICorner", BugFrame)
local BugStroke = Instance.new("UIStroke", BugFrame)
BugStroke.Color = Color3.fromRGB(200, 50, 50)
BugStroke.Thickness = 2

local BugTitle = Instance.new("TextLabel", BugFrame)
BugTitle.Size = UDim2.new(1, 0, 0, 30)
BugTitle.Text = "REPORT BUG DETAIL"
BugTitle.Font = Enum.Font.GothamBold
BugTitle.TextColor3 = Color3.new(1,1,1)
BugTitle.BackgroundTransparency = 1

local ReasonBox = Instance.new("TextBox", BugFrame)
ReasonBox.Size = UDim2.new(0.9, 0, 0.5, 0)
ReasonBox.Position = UDim2.new(0.05, 0, 0.15, 0)
ReasonBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ReasonBox.TextColor3 = Color3.new(1,1,1)
ReasonBox.PlaceholderText = "Explain the bug here..."
ReasonBox.TextXAlignment = Enum.TextXAlignment.Left
ReasonBox.TextYAlignment = Enum.TextYAlignment.Top
ReasonBox.MultiLine = true
ReasonBox.Font = Enum.Font.Gotham
Instance.new("UICorner", ReasonBox)

local SendBugBtn = Instance.new("TextButton", BugFrame)
SendBugBtn.Size = UDim2.new(0.4, 0, 0, 35)
SendBugBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
SendBugBtn.Text = "SEND"
SendBugBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
SendBugBtn.TextColor3 = Color3.new(1,1,1)
SendBugBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SendBugBtn)

local CancelBugBtn = Instance.new("TextButton", BugFrame)
CancelBugBtn.Size = UDim2.new(0.4, 0, 0, 35)
CancelBugBtn.Position = UDim2.new(0.55, 0, 0.75, 0)
CancelBugBtn.Text = "CANCEL"
CancelBugBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
CancelBugBtn.TextColor3 = Color3.new(1,1,1)
CancelBugBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CancelBugBtn)

-- // BUG REPORT LOGIC //
ReportMenuBtn.MouseButton1Click:Connect(function()
    BugFrame.Visible = true
end)

CancelBugBtn.MouseButton1Click:Connect(function()
    BugFrame.Visible = false
end)

SendBugBtn.MouseButton1Click:Connect(function()
    local reason = ReasonBox.Text
    if reason == "" or string.len(reason) < 3 then
        SendBugBtn.Text = "EMPTY!"
        task.wait(1)
        SendBugBtn.Text = "SEND"
        return
    end
    
    SendBugBtn.Text = "SENDING..."
    
    local JobId = game.JobId
    local PlaceId = game.PlaceId
    
    -- Script Join Executor
    local JoinScriptCode = string.format('game:GetService("TeleportService"):TeleportToPlaceInstance(%s, "%s", game.Players.LocalPlayer)', tostring(PlaceId), JobId)
    -- Link Join Browser
    local BrowserLink = "https://www.roblox.com/games/"..PlaceId.."?jobId="..JobId

    local data = {
        ["content"] = "@here **BUG REPORT RECEIVED!** 🚨",
        ["embeds"] = {{
            ["title"] = "DupePanel V23 - Bug Report",
            ["description"] = "A user has reported an issue while using the script.",
            ["color"] = 16724530,
            ["fields"] = {
                {["name"] = "👤 Reporter", ["value"] = LocalPlayer.Name, ["inline"] = true},
                {["name"] = "🆔 User ID", ["value"] = tostring(LocalPlayer.UserId), ["inline"] = true},
                {["name"] = "📄 Description/Reason", ["value"] = "```\n" .. reason .. "\n```", ["inline"] = false},
                {["name"] = "🔗 Browser Join", ["value"] = "[Click to Join Server](" .. BrowserLink .. ")", ["inline"] = false},
                {["name"] = "⚙️ Executor Script", ["value"] = "Copy & Paste in Executor:\n```lua\n" .. JoinScriptCode .. "\n```", ["inline"] = false}
            },
            ["footer"] = {["text"] = "Job ID: " .. JobId}
        }}
    }
    
    local success, err = pcall(function()
        request({
            Url = CONFIG.WebhookURL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(data)
        })
    end)
    
    if success then
        SendBugBtn.Text = "SENT!"
        task.wait(1)
        BugFrame.Visible = false
        SendBugBtn.Text = "SEND"
        ReasonBox.Text = ""
    else
        SendBugBtn.Text = "ERROR"
        warn("Webhook Error:", err)
        task.wait(1)
        SendBugBtn.Text = "SEND"
    end
end)

-- // DYNAMIC LOGIC (ORIGINAL) //
WeightToggle.MouseButton1Click:Connect(function()
    if weightMode == "Random" then
        weightMode = "Fixed"
        WeightToggle.Text = "Weight Mode: FIXED"
        WeightToggle.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
        InMin.Visible = false
        InMax.Visible = false
        InFixed.Visible = true
    else
        weightMode = "Random"
        WeightToggle.Text = "Weight Mode: RANDOM"
        WeightToggle.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        InMin.Visible = true
        InMax.Visible = true
        InFixed.Visible = false
    end
end)

DupeModeToggle.MouseButton1Click:Connect(function()
    if dupeMode == "Gradual" then
        dupeMode = "Instant"
        DupeModeToggle.Text = "Dupe Mode: INSTANT"
        DupeModeToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        InDelay.Visible = false
    else
        dupeMode = "Gradual"
        DupeModeToggle.Text = "Dupe Mode: GRADUAL"
        DupeModeToggle.BackgroundColor3 = Color3.fromRGB(150, 100, 0)
        InDelay.Visible = true
    end
end)

-- // PASSWORD SYSTEM //
local PassFrame = Instance.new("Frame", ScreenGui)
PassFrame.Size = UDim2.new(1,0,1,0)
PassFrame.BackgroundColor3 = Color3.new(0,0,0)
PassFrame.BackgroundTransparency = 0.4
PassFrame.ZIndex = 30

local LoginBox = Instance.new("Frame", PassFrame)
LoginBox.Size = UDim2.new(0, 300, 0, 150)
LoginBox.Position = UDim2.new(0.5, -150, 0.5, -75)
LoginBox.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", LoginBox)

local PassIn = Instance.new("TextBox", LoginBox)
PassIn.Size = UDim2.new(0, 240, 0, 35)
PassIn.Position = UDim2.new(0.5, -120, 0.3, 0)
PassIn.PlaceholderText = "Key Here..."
PassIn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
PassIn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", PassIn)

local PassBtn = Instance.new("TextButton", LoginBox)
PassBtn.Size = UDim2.new(0, 240, 0, 35)
PassBtn.Position = UDim2.new(0.5, -120, 0.65, 0)
PassBtn.Text = "LOGIN"
PassBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
PassBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", PassBtn)

local PassClose = Instance.new("TextButton", LoginBox)
PassClose.Size = UDim2.new(0, 25, 0, 25)
PassClose.Position = UDim2.new(1, -30, 0, 5)
PassClose.Text = "X"
PassClose.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
PassClose.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", PassClose)

PassBtn.MouseButton1Click:Connect(function()
    if PassIn.Text == CONFIG.Password then
        PassFrame:Destroy()
        Main.Visible = true
    else
        PassIn.Text = ""
        PassIn.PlaceholderText = "WRONG!"
    end
end)
PassClose.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- // START DUPE LOGIC //
StartBtn.MouseButton1Click:Connect(function()
    local name = InName.Text
    local rarity = InRarity.Text
    local amt = tonumber(InAmt.Text) or 1
    local delay = tonumber(InDelay.Text) or 0.1
    local minW = tonumber(InMin.Text) or 350
    local maxW = tonumber(InMax.Text) or 700
    local fixW = tonumber(InFixed.Text) or 676.7
    
    local event = ReplicatedStorage:WaitForChild("FishingSystem"):WaitForChild("FishGiver")
    
    if dupeMode == "Instant" then
        for i = 1, amt do
            local w = (weightMode == "Random" and (math.random(minW, maxW) + math.random()/10)) or fixW
            task.spawn(function()
                event:FireServer({hookPosition = Vector3.new(1988, 450, 184), name = name, rarity = rarity, weight = w})
            end)
        end
    else
        task.spawn(function()
            for i = 1, amt do
                local w = (weightMode == "Random" and (math.random(minW, maxW) + math.random()/10)) or fixW
                event:FireServer({hookPosition = Vector3.new(1988, 450, 184), name = name, rarity = rarity, weight = w})
                task.wait(delay)
            end
        end)
    end
end)

-- OPTIMIZATION LOGIC
FogBtn.MouseButton1Click:Connect(function()
    isNoFog = not isNoFog
    FogBtn.Text = isNoFog and "Anti-Fog: ON" or "Anti-Fog: OFF"
    FogBtn.BackgroundColor3 = isNoFog and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(40, 40, 50)
    if isNoFog then Lighting.FogEnd = 1e5 else Lighting.FogEnd = 1000 end
end)

PotatoBtn.MouseButton1Click:Connect(function()
    isPotato = not isPotato
    PotatoBtn.Text = isPotato and "No-Texture: ON" or "No-Texture: OFF"
    PotatoBtn.BackgroundColor3 = isPotato and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(40, 40, 50)
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then v.Material = isPotato and Enum.Material.SmoothPlastic or Enum.Material.Plastic end
    end
end)

-- Draggable
local d, s, sp
Header.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = true s = i.Position sp = Main.Position end end)
UserInputService.InputChanged:Connect(function(i) if d and i.UserInputType == Enum.UserInputType.MouseMovement then local delta = i.Position - s Main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + delta.X, sp.Y.Scale, sp.Y.Offset + delta.Y) end end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = false end end)

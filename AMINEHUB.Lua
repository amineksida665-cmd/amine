local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local ScreenGui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
ScreenGui.Name = "AmineHubRP"
ScreenGui.ResetOnSpawn = false

-- Admin List (Automatically updated when flight or invisibility is detected)
local CustomAdmins = {
    ["jonta"] = true,
    ["ripplyba"] = true,
    ["ossamabnnlaggin"] = true,
    ["dark"] = true,
    ["tassnima"] = true,
    ["y2k"] = true,
    ["rafa"] = true,
    ["7med"] = true,
    ["2hmed"] = true,
    ["chicana"] = true,
    ["lo3y"] = true,
    ["karmosa"] = true,
    ["pablo"] = true,
    ["tata_k7locha"] = true,
    ["ysf_back"] = true,
    ["bella"] = true,
    ["kazoza"] = true,
    ["jihed"] = true,
    ["dineri"] = true,
    ["kossey_mc"] = true
}

local GangList = {}
local EspContainer = Instance.new("Folder", ScreenGui)
EspContainer.Name = "EspContainer"
local AdminEspContainer = Instance.new("Folder", ScreenGui)
AdminEspContainer.Name = "AdminEspContainer"

local CenterAlert = Instance.new("TextLabel", ScreenGui)
CenterAlert.Size = UDim2.new(0, 420, 0, 45)
CenterAlert.Position = UDim2.new(0.5, -210, 0.12, 0)
CenterAlert.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
CenterAlert.TextColor3 = Color3.fromRGB(255, 100, 100)
CenterAlert.TextSize, CenterAlert.Font = 12, Enum.Font.GothamBold
CenterAlert.Text = ""
CenterAlert.Visible = false
CenterAlert.ZIndex = 100
Instance.new("UICorner", CenterAlert).CornerRadius = UDim.new(0, 8)
local AlertStroke = Instance.new("UIStroke", CenterAlert)
AlertStroke.Color = Color3.fromRGB(255, 50, 50)
AlertStroke.Thickness = 2

-- Green Notification Box for New Additions
local AddNotification = Instance.new("TextLabel", ScreenGui)
AddNotification.Size = UDim2.new(0, 380, 0, 40)
AddNotification.Position = UDim2.new(0.5, -190, 0.04, 0)
AddNotification.BackgroundColor3 = Color3.fromRGB(10, 40, 20)
AddNotification.TextColor3 = Color3.fromRGB(100, 255, 150)
AddNotification.TextSize, AddNotification.Font = 11, Enum.Font.GothamBold
AddNotification.Text = ""
AddNotification.Visible = false
AddNotification.ZIndex = 150
Instance.new("UICorner", AddNotification).CornerRadius = UDim.new(0, 8)
local AddNotifStroke = Instance.new("UIStroke", AddNotification)
AddNotifStroke.Color = Color3.fromRGB(50, 255, 100)
AddNotifStroke.Thickness = 2

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 320, 0, 460)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -230)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 12, 20)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 1
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(120, 120, 120)
MainStroke.Thickness = 2

local TitleLabel = Instance.new("TextLabel", MainFrame)
TitleLabel.Size = UDim2.new(0, 180, 0, 30)
TitleLabel.Position = UDim2.new(0, 12, 0, 8)
TitleLabel.Text = "AMINE HUB - Amin"
TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextSize, TitleLabel.Font = 16, Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 2

local btnHideAllGui = Instance.new("TextButton", MainFrame)
btnHideAllGui.Size = UDim2.new(0, 90, 0, 28)
btnHideAllGui.Position = UDim2.new(1, -102, 0, 8)
btnHideAllGui.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
btnHideAllGui.Text = "HIDE"
btnHideAllGui.TextColor3 = Color3.fromRGB(255, 255, 255)
btnHideAllGui.TextSize, btnHideAllGui.Font = 11, Enum.Font.GothamBold
btnHideAllGui.ZIndex = 2
Instance.new("UICorner", btnHideAllGui).CornerRadius = UDim.new(0, 6)

local WatermarkBtn = Instance.new("TextButton", ScreenGui)
WatermarkBtn.Size = UDim2.new(0, 45, 0, 45)
WatermarkBtn.Position = UDim2.new(0, 20, 0.5, -22)
WatermarkBtn.BackgroundColor3 = Color3.fromRGB(10, 12, 20)
WatermarkBtn.Text = "AM"
WatermarkBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
WatermarkBtn.TextSize, WatermarkBtn.Font = 14, Enum.Font.GothamBold
WatermarkBtn.Visible = false
WatermarkBtn.Active = true
WatermarkBtn.Draggable = true
WatermarkBtn.ZIndex = 200
Instance.new("UICorner", WatermarkBtn).CornerRadius = UDim.new(1, 0)
local WatermarkStroke = Instance.new("UIStroke", WatermarkBtn)
WatermarkStroke.Color = Color3.fromRGB(120, 120, 120)
WatermarkStroke.Thickness = 2

local ScrollingFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollingFrame.Size = UDim2.new(1, -16, 1, -50)
ScrollingFrame.Position = UDim2.new(0, 8, 0, 42)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 900)
ScrollingFrame.ScrollBarThickness = 3
ScrollingFrame.ZIndex = 2

local UIList = Instance.new("UIListLayout", ScrollingFrame)
UIList.Padding = UDim.new(0, 6)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- أيدي أيقونة شخص يمسك سلاح بلون أزرق
local WeaponGuyIconId = "rbxassetid://6034293977"

local function createFeatureButton(name, parent, callback)
    local container = Instance.new("Frame", parent)
    container.Size = UDim2.new(0.96, 0, 0, 38)
    container.BackgroundTransparency = 1
    container.ZIndex = 2

    local btn = Instance.new("TextButton", container)
    btn.Size = UDim2.new(0.68, 0, 1, 0)
    btn.Position = UDim2.new(0, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(15, 20, 35)
    btn.Text = "        " .. name
    btn.TextColor3 = Color3.fromRGB(220, 240, 255)
    btn.TextSize, btn.Font = 10, Enum.Font.GothamBold
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.ZIndex = 2
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = Color3.fromRGB(80, 80, 80)
    btnStroke.Thickness = 1.2

    local icon = Instance.new("ImageLabel", btn)
    icon.Size = UDim2.new(0, 20, 0, 20)
    icon.Position = UDim2.new(0, 6, 0.5, -10)
    icon.BackgroundTransparency = 1
    icon.Image = WeaponGuyIconId
    icon.ImageColor3 = Color3.fromRGB(100, 180, 255) -- لون أزرق مميز للشخصية
    icon.ZIndex = 3

    local toggleBtn = Instance.new("TextButton", container)
    toggleBtn.Size = UDim2.new(0.28, 0, 1, 0)
    toggleBtn.Position = UDim2.new(0.72, 0, 0, 0)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 50)
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(200, 220, 255)
    toggleBtn.TextSize, toggleBtn.Font = 11, Enum.Font.GothamBold
    toggleBtn.ZIndex = 2
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 6)
    local tStroke = Instance.new("UIStroke", toggleBtn)
    tStroke.Color = Color3.fromRGB(80, 80, 80)
    tStroke.Thickness = 1.2

    local state = false
    local function trigger()
        state = not state
        toggleBtn.Text = state and "ON" or "OFF"
        toggleBtn.BackgroundColor3 = state and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(25, 30, 50)
        tStroke.Color = state and Color3.fromRGB(200, 200, 200) or Color3.fromRGB(80, 80, 80)
        callback(state)
    end

    toggleBtn.MouseButton1Click:Connect(trigger)
    btn.MouseButton1Click:Connect(trigger)
    return container
end

local function createButtonWithIcon(name, parent, onClick)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.96, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(15, 20, 35)
    btn.Text = "        " .. name
    btn.TextColor3 = Color3.fromRGB(220, 240, 255)
    btn.TextSize, btn.Font = 10, Enum.Font.GothamBold
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.ZIndex = 2
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(80, 80, 80)
    stroke.Thickness = 1.2

    local icon = Instance.new("ImageLabel", btn)
    icon.Size = UDim2.new(0, 20, 0, 20)
    icon.Position = UDim2.new(0, 6, 0.5, -10)
    icon.BackgroundTransparency = 1
    icon.Image = WeaponGuyIconId
    icon.ImageColor3 = Color3.fromRGB(100, 180, 255) -- لون أزرق للشخصية الحاملة للسلاح
    icon.ZIndex = 3

    btn.MouseButton1Click:Connect(onClick)
    return btn
end

createFeatureButton("ESP PLAYERS (BODY + HP)", ScrollingFrame, function(state)
    _G.EspEnabled = state
    if not state then 
        EspContainer:ClearAllChildren() 
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                local hl = p.Character:FindFirstChild("AminePlayerBodyHL")
                if hl then hl:Destroy() end
            end
        end
    end
end)

createFeatureButton("ADMIN ESP (HP COLOR BODY)", ScrollingFrame, function(state)
    _G.AdminEspEnabled = state
    if not state then AdminEspContainer:ClearAllChildren() end
end)

createFeatureButton("AIMBOT", ScrollingFrame, function(state)
    _G.AimbotEnabled = state
end)

createFeatureButton("BYPASS WALLS", ScrollingFrame, function(state)
    _G.BypassWalls = state
end)

createFeatureButton("FLY", ScrollingFrame, function(state)
    _G.FlyEnabled = state
end)

createFeatureButton("HIGH JUMP", ScrollingFrame, function(state)
    _G.HighJumpEnabled = state
end)

createButtonWithIcon("SPAWN CLONE (COPY YOURSELF)", ScrollingFrame, function()
    local char = LP.Character
    if char then
        char.Archivable = true
        local clone = char:Clone()
        for _, obj in pairs(clone:GetDescendants()) do
            if obj:IsA("Script") or obj:IsA("LocalScript") then
                obj:Destroy()
            end
        end
        clone.Parent = workspace
        clone:SetPrimaryPartCFrame(char:GetPrimaryPartCFrame() * CFrame.new(2, 0, 0))
    end
end)

local allPopups = {}
local function registerPopup(popup)
    table.insert(allPopups, popup)
    return popup
end

local function createPlayerListPopup(titleText, isTpAction)
    local popup = registerPopup(Instance.new("Frame", MainFrame))
    popup.Name = titleText
    popup.Size = UDim2.new(0, 250, 0, 320)
    popup.Position = UDim2.new(-1, -10, 0, 0)
    popup.BackgroundColor3 = Color3.fromRGB(12, 15, 25)
    popup.Visible = false
    popup.ZIndex = 50
    Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", popup)
    stroke.Color = Color3.fromRGB(80, 80, 80)
    stroke.Thickness = 2

    local title = Instance.new("TextLabel", popup)
    title.Size = UDim2.new(1, -30, 0, 35)
    title.Position = UDim2.new(0, 12, 0, 5)
    title.Text = titleText
    title.TextColor3 = Color3.fromRGB(220, 220, 220)
    title.BackgroundTransparency = 1
    title.TextSize, title.Font = 11, Enum.Font.GothamBold
    title.ZIndex = 51
    title.TextXAlignment = Enum.TextXAlignment.Left

    local closeBtn = Instance.new("TextButton", popup)
    closeBtn.Size = UDim2.new(0, 26, 0, 26)
    closeBtn.Position = UDim2.new(1, -32, 0, 8)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize, closeBtn.Font = 11, Enum.Font.GothamBold
    closeBtn.ZIndex = 51
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
    closeBtn.MouseButton1Click:Connect(function() popup.Visible = false end)

    local scroll = Instance.new("ScrollingFrame", popup)
    scroll.Size = UDim2.new(0.9, 0, 0.75, 0)
    scroll.Position = UDim2.new(0.05, 0, 0.2, 0)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 3
    scroll.ZIndex = 51
    
    local listLayout = Instance.new("UIListLayout", scroll)
    listLayout.Padding = UDim.new(0, 5)
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
    end)

    local function refreshList()
        for _, child in pairs(scroll:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextButton") then child:Destroy() end
        end
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LP then
                local pBtn = Instance.new("TextButton", scroll)
                pBtn.Size = UDim2.new(1, 0, 0, 32)
                pBtn.BackgroundColor3 = Color3.fromRGB(18, 24, 40)
                pBtn.Text = player.DisplayName
                pBtn.TextColor3 = Color3.fromRGB(220, 240, 255)
                pBtn.TextSize, pBtn.Font = 10, Enum.Font.GothamBold
                pBtn.ZIndex = 52
                Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 6)
                local pStroke = Instance.new("UIStroke", pBtn)
                pStroke.Color = Color3.fromRGB(80, 80, 80)
                pStroke.Thickness = 1

                if isTpAction == true then
                    pBtn.MouseButton1Click:Connect(function()
                        local targetChar = player.Character
                        local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                        local myChar = LP.Character
                        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                        if targetRoot and myRoot then
                            myRoot.CFrame = targetRoot.CFrame + Vector3.new(0, 3, 0)
                        end
                    end)
                elseif isTpAction == "gang" then
                    local statusText = Instance.new("TextLabel", pBtn)
                    statusText.Size = UDim2.new(0, 60, 1, 0)
                    statusText.Position = UDim2.new(1, -65, 0, 0)
                    statusText.BackgroundTransparency = 1
                    statusText.TextSize = 10
                    statusText.Font = Enum.Font.GothamBold
                    statusText.ZIndex = 53

                    local function updateGangStatus()
                        if GangList[player.UserId] then
                            statusText.Text = "GANG"
                            statusText.TextColor3 = Color3.fromRGB(0, 255, 100)
                            pBtn.BackgroundColor3 = Color3.fromRGB(10, 40, 20)
                        else
                            statusText.Text = "ENEMY"
                            statusText.TextColor3 = Color3.fromRGB(255, 100, 100)
                            pBtn.BackgroundColor3 = Color3.fromRGB(18, 24, 40)
                        end
                    end
                    updateGangStatus()

                    pBtn.MouseButton1Click:Connect(function()
                        GangList[player.UserId] = not GangList[player.UserId]
                        updateGangStatus()
                    end)
                end
            end
        end
    end

    popup:GetPropertyChangedSignal("Visible"):Connect(function()
        if popup.Visible then refreshList() end
    end)
    return popup
end

local LocationsPopup = registerPopup(Instance.new("Frame", MainFrame))
LocationsPopup.Name = "LocationsPopup"
LocationsPopup.Size = UDim2.new(0, 250, 0, 320)
LocationsPopup.Position = UDim2.new(-1, -10, 0, 0)
LocationsPopup.BackgroundColor3 = Color3.fromRGB(12, 15, 25)
LocationsPopup.Visible = false
LocationsPopup.ZIndex = 50
Instance.new("UICorner", LocationsPopup).CornerRadius = UDim.new(0, 8)
local locStroke = Instance.new("UIStroke", LocationsPopup)
locStroke.Color = Color3.fromRGB(80, 80, 80)
locStroke.Thickness = 2

local locTitle = Instance.new("TextLabel", LocationsPopup)
locTitle.Size = UDim2.new(1, -30, 0, 35)
locTitle.Position = UDim2.new(0, 12, 0, 5)
locTitle.Text = "MY PERMANENT LOCATIONS"
locTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
locTitle.BackgroundTransparency = 1
locTitle.TextSize, locTitle.Font = 11, Enum.Font.GothamBold
locTitle.ZIndex = 51
locTitle.TextXAlignment = Enum.TextXAlignment.Left

local locCloseBtn = Instance.new("TextButton", LocationsPopup)
locCloseBtn.Size = UDim2.new(0, 26, 0, 26)
locCloseBtn.Position = UDim2.new(1, -32, 0, 8)
locCloseBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
locCloseBtn.Text = "X"
locCloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
locCloseBtn.TextSize, locCloseBtn.Font = 11, Enum.Font.GothamBold
locCloseBtn.ZIndex = 51
Instance.new("UICorner", locCloseBtn).CornerRadius = UDim.new(0, 6)
locCloseBtn.MouseButton1Click:Connect(function() LocationsPopup.Visible = false end)

local AddLocBtn = Instance.new("TextButton", LocationsPopup)
AddLocBtn.Size = UDim2.new(0.9, 0, 0, 30)
AddLocBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
AddLocBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AddLocBtn.Text = "+ Add & Save Current Place"
AddLocBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AddLocBtn.TextSize, AddLocBtn.Font = 10, Enum.Font.GothamBold
AddLocBtn.ZIndex = 51
Instance.new("UICorner", AddLocBtn).CornerRadius = UDim.new(0, 6)

local locScroll = Instance.new("ScrollingFrame", LocationsPopup)
locScroll.Size = UDim2.new(0.9, 0, 0.6, 0)
locScroll.Position = UDim2.new(0.05, 0, 0.32, 0)
locScroll.BackgroundTransparency = 1
locScroll.ScrollBarThickness = 3
locScroll.ZIndex = 51

local locListLayout = Instance.new("UIListLayout", locScroll)
locListLayout.Padding = UDim.new(0, 5)
locListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

locListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    locScroll.CanvasSize = UDim2.new(0, 0, 0, locListLayout.AbsoluteContentSize.Y + 10)
end)

local HttpService = game:GetService("HttpService")
local FileName = "AmineHub_MyPermanentLocations.json"
local SavedLocations = {}

local DefaultLocations = {
    {Name = "Home", X = 0, Y = 5, Z = 0},
    {Name = "Bank", X = 150, Y = 5, Z = 200},
    {Name = "Gun Shop", X = -100, Y = 5, Z = -150}
}

local function loadLocations()
    if pcall(function() return readfile(FileName) end) then
        local success, data = pcall(function()
            return HttpService:JSONDecode(readfile(FileName))
        end)
        if success and type(data) == "table" and #data > 0 then
            SavedLocations = data
            return
        end
    end
    SavedLocations = DefaultLocations
    pcall(function()
        if writefile then
            writefile(FileName, HttpService:JSONEncode(SavedLocations))
        end
    end)
end

local function saveLocations()
    pcall(function()
        if writefile then
            writefile(FileName, HttpService:JSONEncode(SavedLocations))
        end
    end)
end

loadLocations()

local function refreshLocationsList()
    for _, child in pairs(locScroll:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") then child:Destroy() end
    end

    for index, loc in ipairs(SavedLocations) do
        local row = Instance.new("Frame", locScroll)
        row.Size = UDim2.new(1, 0, 0, 32)
        row.BackgroundTransparency = 1
        row.ZIndex = 52

        local lBtn = Instance.new("TextButton", row)
        lBtn.Size = UDim2.new(0.75, 0, 1, 0)
        lBtn.BackgroundColor3 = Color3.fromRGB(18, 24, 40)
        lBtn.Text = " " .. loc.Name
        lBtn.TextColor3 = Color3.fromRGB(220, 240, 255)
        lBtn.TextSize, lBtn.Font = 10, Enum.Font.GothamBold
        lBtn.TextXAlignment = Enum.TextXAlignment.Left
        lBtn.ZIndex = 52
        Instance.new("UICorner", lBtn).CornerRadius = UDim.new(0, 6)

        local delBtn = Instance.new("TextButton", row)
        delBtn.Size = UDim2.new(0.22, 0, 1, 0)
        delBtn.Position = UDim2.new(0.78, 0, 0, 0)
        delBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
        delBtn.Text = "DEL"
        delBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        delBtn.TextSize, delBtn.Font = 9, Enum.Font.GothamBold
        delBtn.ZIndex = 52
        Instance.new("UICorner", delBtn).CornerRadius = UDim.new(0, 6)

        lBtn.MouseButton1Click:Connect(function()
            local myChar = LP.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if myRoot then
                myRoot.CFrame = CFrame.new(loc.X, loc.Y + 3, loc.Z)
            end
        end)

        delBtn.MouseButton1Click:Connect(function()
            table.remove(SavedLocations, index)
            saveLocations()
            refreshLocationsList()
        end)
    end
end

AddLocBtn.MouseButton1Click:Connect(function()
    local myChar = LP.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if myRoot then
        local customName = "Location " .. (#SavedLocations + 1)
        table.insert(SavedLocations, {
            Name = customName,
            X = myRoot.Position.X,
            Y = myRoot.Position.Y,
            Z = myRoot.Position.Z
        })
        saveLocations()
        refreshLocationsList()
    end
end)

LocationsPopup:GetPropertyChangedSignal("Visible"):Connect(function()
    if LocationsPopup.Visible then refreshLocationsList() end
end)

local InstantTPPopup = createPlayerListPopup("INSTANT TP - PLAYERS", true)
createButtonWithIcon("INSTANT TP", ScrollingFrame, function()
    local newState = not InstantTPPopup.Visible
    InstantTPPopup.Visible = newState
end)

createButtonWithIcon("MY LOCATIONS", ScrollingFrame, function()
    local newState = not LocationsPopup.Visible
    LocationsPopup.Visible = newState
end)

local GangPopup = createPlayerListPopup("YOUR GANG (NO AIMBOT)", "gang")
createButtonWithIcon("YOUR GANG (Select Players)", ScrollingFrame, function()
    local newState = not GangPopup.Visible
    GangPopup.Visible = newState
end)

btnHideAllGui.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    WatermarkBtn.Visible = true
end)

WatermarkBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    WatermarkBtn.Visible = false
end)

-- Function to determine color based on health
local function getHealthColor(health, maxHealth)
    local hpPercent = (health / (maxHealth > 0 and maxHealth or 100)) * 100
    if hpPercent > 80 then
        return Color3.fromRGB(0, 255, 100)
    elseif hpPercent >= 40 then
        return Color3.fromRGB(255, 255, 0)
    else
        return Color3.fromRGB(255, 0, 0)
    end
end

-- Variable to control the temporary appearance of the addition notification
local notifTimer = 0

RunService.RenderStepped:Connect(function()
    local char = LP.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")

    if _G.BypassWalls and char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    -- High Jump feature logic
    if _G.HighJumpEnabled and humanoid then
        humanoid.JumpPower = 120
    elseif humanoid then
        humanoid.JumpPower = 50
    end

    -- Automatic detection of admins (flight + invisibility) and adding them to the admin list automatically
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local pRoot = p.Character:FindFirstChild("HumanoidRootPart")
            local pHum = p.Character:FindFirstChildOfClass("Humanoid")
            if pRoot and pHum then
                local isHacking = false
                
                -- 1. Check flight in the air
                local ray = Ray.new(pRoot.Position, Vector3.new(0, -7, 0))
                local hit = workspace:FindPartOnRay(ray, p.Character)
                if not hit and pRoot.AssemblyLinearVelocity.Y > 25 then
                    isHacking = true
                end

                -- 2. Check invisibility (High transparency in parts)
                for _, part in pairs(p.Character:GetChildren()) do
                    if part:IsA("BasePart") and part.Transparency > 0.6 and part.Name ~= "HumanoidRootPart" then
                        isHacking = true
                        break
                    end
                end

                if isHacking then
                    local nameLower = p.Name:lower()
                    local dispLower = p.DisplayName:lower()
                    if not CustomAdmins[nameLower] then
                        CustomAdmins[nameLower] = true
                        CustomAdmins[dispLower] = true
                        
                        -- Show the green box in English with the person's name
                        AddNotification.Text = "Added " .. p.DisplayName .. " to the admin list!"
                        AddNotification.Visible = true
                        notifTimer = tick() + 4 -- Remains visible for 4 seconds
                    end
                end
            end
        end
    end

    -- Hide the green box after time expires
    if AddNotification.Visible and tick() > notifTimer then
        AddNotification.Visible = false
    end

    -- 1. Normal players ESP system
    if _G.EspEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local pNameLower = p.Name:lower()
                local displayNameLower = p.DisplayName:lower()
                if not CustomAdmins[pNameLower] and not CustomAdmins[displayNameLower] then
                    local pChar = p.Character
                    local pRoot = pChar.HumanoidRootPart
                    local hum = pChar:FindFirstChildOfClass("Humanoid")
                    
                    local hpVal = hum and hum.Health or 100
                    local maxHpVal = hum and hum.MaxHealth or 100
                    local dynamicColor = getHealthColor(hpVal, maxHpVal)

                    local hl = pChar:FindFirstChild("AminePlayerBodyHL")
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "AminePlayerBodyHL"
                        hl.Adornee = pChar
                        hl.FillTransparency = 0.5
                        hl.OutlineTransparency = 0
                        hl.Parent = pChar
                    end
                    hl.FillColor = dynamicColor
                    hl.OutlineColor = dynamicColor

                    local playerBox = EspContainer:FindFirstChild(p.Name .. "_PlayerBody")
                    if not playerBox then
                        playerBox = Instance.new("BillboardGui", EspContainer)
                        playerBox.Name = p.Name .. "_PlayerBody"
                        playerBox.AlwaysOnTop = true
                        playerBox.Size = UDim2.new(0, 120, 0, 45)
                        playerBox.StudsOffset = Vector3.new(0, 3, 0)

                        local infoLabel = Instance.new("TextLabel", playerBox)
                        infoLabel.Name = "InfoLabel"
                        infoLabel.Size = UDim2.new(1, 0, 1, 0)
                        infoLabel.BackgroundTransparency = 1
                        infoLabel.TextSize = 12
                        infoLabel.Font = Enum.Font.GothamBold
                        infoLabel.TextStrokeTransparency = 0.3
                    end

                    local infoLabel = playerBox:FindFirstChild("InfoLabel")
                    if infoLabel and hum then
                        infoLabel.Text = p.DisplayName .. "\nHP: " .. math.floor(hum.Health)
                        infoLabel.TextColor3 = dynamicColor
                    end
                    playerBox.Adornee = pRoot
                end
            end
        end
    else
        EspContainer:ClearAllChildren()
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                local hl = p.Character:FindFirstChild("AminePlayerBodyHL")
                if hl then hl:Destroy() end
            end
        end
    end

    -- 2. Admin ESP system
    if _G.AdminEspEnabled then
        local adminNear = false
        local adminFoundName = ""
        local minDistance = 1000
        local closestDist = math.huge

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local pNameLower = p.Name:lower()
                local displayNameLower = p.DisplayName:lower()
                if CustomAdmins[pNameLower] or CustomAdmins[displayNameLower] then
                    local pChar = p.Character
                    local pRoot = pChar.HumanoidRootPart
                    local hum = pChar:FindFirstChildOfClass("Humanoid")
                    
                    local hpVal = hum and hum.Health or 100
                    local maxHpVal = hum and hum.MaxHealth or 100
                    local dynamicColor = getHealthColor(hpVal, maxHpVal)

                    if root then
                        local dist = (root.Position - pRoot.Position).Magnitude
                        if dist <= minDistance then
                            adminNear = true
                            adminFoundName = p.DisplayName
                            if dist < closestDist then
                                closestDist = dist
                            end
                        end
                    end

                    local hl = pChar:FindFirstChild("AmineAdminBodyHL")
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "AmineAdminBodyHL"
                        hl.Adornee = pChar
                        hl.FillTransparency = 0.5
                        hl.OutlineTransparency = 0
                        hl.Parent = pChar
                    end
                    hl.FillColor = dynamicColor
                    hl.OutlineColor = dynamicColor

                    local adminBox = AdminEspContainer:FindFirstChild(p.Name .. "_AdminBody")
                    if not adminBox then
                        adminBox = Instance.new("BillboardGui", AdminEspContainer)
                        adminBox.Name = p.Name .. "_AdminBody"
                        adminBox.AlwaysOnTop = true
                        adminBox.Size = UDim2.new(0, 120, 0, 45)
                        adminBox.StudsOffset = Vector3.new(0, 3, 0)

                        local infoLabel = Instance.new("TextLabel", adminBox)
                        infoLabel.Name = "InfoLabel"
                        infoLabel.Size = UDim2.new(1, 0, 1, 0)
                        infoLabel.BackgroundTransparency = 1
                        infoLabel.TextSize = 12
                        infoLabel.Font = Enum.Font.GothamBold
                        infoLabel.TextStrokeTransparency = 0.3
                    end

                    local infoLabel = adminBox:FindFirstChild("InfoLabel")
                    if infoLabel and hum then
                        infoLabel.Text = "🚨 " .. p.DisplayName .. "\nHP: " .. math.floor(hum.Health)
                        infoLabel.TextColor3 = dynamicColor
                    end
                    adminBox.Adornee = pRoot
                end
            end
        end

        if adminNear then
            local intensity = math.clamp(1 - (closestDist / 1000), 0.1, 1)
            local flash = math.floor(tick() * (5 + (intensity * 15))) % 2 == 0
            
            CenterAlert.Text = "⚠️ ADMIN (" .. adminFoundName .. ") - " .. math.floor(closestDist) .. "M NEAR!"
            CenterAlert.Visible = true
            CenterAlert.BackgroundColor3 = flash and Color3.fromRGB(80, 10, 10) or Color3.fromRGB(150, 0, 0)
            AlertStroke.Color = flash and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 0)
        else
            CenterAlert.Visible = false
        end
    else
        AdminEspContainer:ClearAllChildren()
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                local hl = p.Character:FindFirstChild("AmineAdminBodyHL")
                if hl then hl:Destroy() end
            end
        end
        CenterAlert.Visible = false
    end

    if _G.AimbotEnabled and root then
        local closestTarget = nil
        local shortestDist = math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                if not GangList[p.UserId] then
                    local pHead = p.Character:FindFirstChild("Head")
                    local pHumanoid = p.Character:FindFirstChildOfClass("Humanoid")
                    if pHead and pHumanoid and pHumanoid.Health > 0 then
                        local screenPoint, onScreen = Camera:WorldToViewportPoint(pHead.Position)
                        if onScreen then
                            local dist = (Vector2.new(screenPoint.X, screenPoint.Y) - UserInputService:GetMouseLocation()).Magnitude
                            if dist < shortestDist then
                                shortestDist = dist
                                closestTarget = pHead
                            end
                        end
                    end
                end
            end
        end
        if closestTarget then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestTarget.Position)
        end
    end

    if _G.FlyEnabled and root then
        local bv = root:FindFirstChild("AmineFlyForce")
        if not bv then
            bv = Instance.new("BodyVelocity")
            bv.Name = "AmineFlyForce"
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.Parent = root
        end
        local moveDir = Vector3.new(0, 0, 0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
        bv.Velocity = moveDir * 80
    else
        if root then
            local bv = root:FindFirstChild("AmineFlyForce")
            if bv then bv:Destroy() end
        end
    end
end)

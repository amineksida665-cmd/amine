local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local HttpService = game:GetService("HttpService")

local ScreenGui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
ScreenGui.Name = "AmineHubPermanentTP"
ScreenGui.ResetOnSpawn = false

-- قائمة المشرفين المحددة (مع إضافة Kossey_Mc)
local CustomAdmins = {
    ["tassnima"] = true,
    ["y2k"] = true,
    ["rafa"] = true,
    ["7med"] = true,
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

-- قائمة اللاعبين المستثنحين من الإيمبوت (Gang)
local GangList = {}

local EspContainer = Instance.new("Folder", ScreenGui)
EspContainer.Name = "EspContainer"

local AdminEspContainer = Instance.new("Folder", ScreenGui)
AdminEspContainer.Name = "AdminEspContainer"

-- تنبيه تحذير المشرفين في المنتصف مع إظهار الاسم
local CenterAlert = Instance.new("TextLabel", ScreenGui)
CenterAlert.Size = UDim2.new(0, 340, 0, 45)
CenterAlert.Position = UDim2.new(0.5, -170, 0.12, 0)
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

-- النافذة الرئيسية
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 320, 0, 460)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -230)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 12, 20)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 1
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(0, 160, 255)
MainStroke.Thickness = 2

local TitleLabel = Instance.new("TextLabel", MainFrame)
TitleLabel.Size = UDim2.new(0, 140, 0, 30)
TitleLabel.Position = UDim2.new(0, 12, 0, 8)
TitleLabel.Text = "AMINE HUB"
TitleLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextSize, TitleLabel.Font = 18, Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 2

local btnHideAllGui = Instance.new("TextButton", MainFrame)
btnHideAllGui.Size = UDim2.new(0, 100, 0, 28)
btnHideAllGui.Position = UDim2.new(1, -112, 0, 8)
btnHideAllGui.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
btnHideAllGui.Text = "HIDE"
btnHideAllGui.TextColor3 = Color3.fromRGB(255, 255, 255)
btnHideAllGui.TextSize, btnHideAllGui.Font = 11, Enum.Font.GothamBold
btnHideAllGui.ZIndex = 2
Instance.new("UICorner", btnHideAllGui).CornerRadius = UDim.new(0, 6)

local ScrollingFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollingFrame.Size = UDim2.new(1, -16, 1, -50)
ScrollingFrame.Position = UDim2.new(0, 8, 0, 42)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 680)
ScrollingFrame.ScrollBarThickness = 3
ScrollingFrame.ZIndex = 2

local UIList = Instance.new("UIListLayout", ScrollingFrame)
UIList.Padding = UDim.new(0, 6)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function createFeatureButton(name, parent, callback)
    local container = Instance.new("Frame", parent)
    container.Size = UDim2.new(0.96, 0, 0, 38)
    container.BackgroundTransparency = 1
    container.ZIndex = 2

    local btn = Instance.new("TextButton", container)
    btn.Size = UDim2.new(0.68, 0, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(15, 20, 35)
    btn.Text = " " .. name
    btn.TextColor3 = Color3.fromRGB(220, 240, 255)
    btn.TextSize, btn.Font = 11, Enum.Font.GothamBold
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.ZIndex = 2
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = Color3.fromRGB(0, 120, 220)
    btnStroke.Thickness = 1.2

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
    tStroke.Color = Color3.fromRGB(0, 120, 220)
    tStroke.Thickness = 1.2

    local state = false
    local function trigger()
        state = not state
        toggleBtn.Text = state and "ON" or "OFF"
        toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(25, 30, 50)
        tStroke.Color = state and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(0, 120, 220)
        callback(state)
    end

    toggleBtn.MouseButton1Click:Connect(trigger)
    btn.MouseButton1Click:Connect(trigger)
    return container
end

local function createActionContainer(name, parent, onClick)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.96, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(15, 20, 35)
    btn.Text = " " .. name
    btn.TextColor3 = Color3.fromRGB(220, 240, 255)
    btn.TextSize, btn.Font = 11, Enum.Font.GothamBold
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.ZIndex = 2
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(0, 140, 255)
    stroke.Thickness = 1.2
    btn.MouseButton1Click:Connect(onClick)
    return btn
end

-- أزرار الميزات الرئيسية
createFeatureButton("ESP PLAYERS", ScrollingFrame, function(state)
    _G.EspEnabled = state
    if not state then EspContainer:ClearAllChildren() end
end)

createFeatureButton("ADMIN ESP (RED)", ScrollingFrame, function(state)
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

local allPopups = {}
local function registerPopup(popup)
    table.insert(allPopups, popup)
    return popup
end

local function closeAllPopupsExcept(activePopup)
    for _, p in ipairs(allPopups) do
        if p ~= activePopup then p.Visible = false end
    end
end

-- قائمة اللاعبين العامة (للـ TP أو للـ Gang)
local function createPlayerListPopup(titleText, isTpAction)
    local popup = registerPopup(Instance.new("Frame", MainFrame))
    popup.Size = UDim2.new(0, 250, 0, 320)
    popup.Position = UDim2.new(-1, -10, 0, 0)
    popup.BackgroundColor3 = Color3.fromRGB(12, 15, 25)
    popup.Visible = false
    popup.ZIndex = 50
    Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", popup)
    stroke.Color = Color3.fromRGB(0, 160, 255)
    stroke.Thickness = 2

    local title = Instance.new("TextLabel", popup)
    title.Size = UDim2.new(1, -30, 0, 35)
    title.Position = UDim2.new(0, 12, 0, 5)
    title.Text = titleText
    title.TextColor3 = Color3.fromRGB(0, 180, 255)
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
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.ScrollBarThickness = 3
    scroll.ZIndex = 51
    local listLayout = Instance.new("UIListLayout", scroll)
    listLayout.Padding = UDim.new(0, 5)
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local function refreshList()
        for _, child in pairs(scroll:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextButton") then child:Destroy() end
        end
        local count = 0
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LP then
                count = count + 1
                local pBtn = Instance.new("TextButton", scroll)
                pBtn.Size = UDim2.new(1, 0, 0, 32)
                pBtn.BackgroundColor3 = Color3.fromRGB(18, 24, 40)
                pBtn.Text = player.DisplayName
                pBtn.TextColor3 = Color3.fromRGB(220, 240, 255)
                pBtn.TextSize, pBtn.Font = 10, Enum.Font.GothamBold
                pBtn.ZIndex = 52
                Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 6)
                local pStroke = Instance.new("UIStroke", pBtn)
                pStroke.Color = Color3.fromRGB(0, 120, 220)
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
                    -- إظهار حالة الـ Gang (مضاف أم لا)
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
        scroll.CanvasSize = UDim2.new(0, 0, 0, count * 36)
    end

    popup:GetPropertyChangedSignal("Visible"):Connect(function()
        if popup.Visible then refreshList() end
    end)
    return popup
end

local InstantTPPopup = createPlayerListPopup("INSTANT TP - PLAYERS", true)
createActionContainer("INSTANT TP", ScrollingFrame, function()
    local newState = not InstantTPPopup.Visible
    closeAllPopupsExcept(InstantTPPopup)
    InstantTPPopup.Visible = newState
end)

local GangPopup = createPlayerListPopup("YOUR GANG (NO AIMBOT)", "gang")
createActionContainer("YOUR GANG (Select Players)", ScrollingFrame, function()
    local newState = not GangPopup.Visible
    closeAllPopupsExcept(GangPopup)
    GangPopup.Visible = newState
end)

createActionContainer("TP TO FARAWAY PLAYER 🚀", ScrollingFrame, function()
    pcall(function()
        local target = nil
        local maxDist = 0
        local myChar = LP.Character
        if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LP and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (myChar.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if dist > maxDist then
                    maxDist = dist
                    target = player
                end
            end
        end
        
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            myChar.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        end
    end)
end)

-- نظام الحفظ الدائم
local FileName = "AmineHub_PermanentWaypoints.json"
local SavedLocations = {}

local function loadSavedWaypoints()
    if readfile and isfile and isfile(FileName) then
        local success, result = pcall(function()
            return HttpService:JSONDecode(readfile(FileName))
        end)
        if success and type(result) == "table" then
            SavedLocations = result
        end
    end
end

local function saveWaypointsToFile()
    if writefile then
        pcall(function()
            writefile(FileName, HttpService:JSONEncode(SavedLocations))
        end)
    end
end

loadSavedWaypoints()

local CustomLocPopup = registerPopup(Instance.new("Frame", MainFrame))
CustomLocPopup.Size = UDim2.new(0, 280, 0, 280)
CustomLocPopup.Position = UDim2.new(-1, -10, 0, 50)
CustomLocPopup.BackgroundColor3 = Color3.fromRGB(12, 15, 25)
CustomLocPopup.Visible = false
CustomLocPopup.ZIndex = 50
Instance.new("UICorner", CustomLocPopup).CornerRadius = UDim.new(0, 8)
local CustomLocStroke = Instance.new("UIStroke", CustomLocPopup)
CustomLocStroke.Color = Color3.fromRGB(0, 160, 255)
CustomLocStroke.Thickness = 2

local CustomLocTitle = Instance.new("TextLabel", CustomLocPopup)
CustomLocTitle.Size = UDim2.new(1, -30, 0, 35)
CustomLocTitle.Position = UDim2.new(0, 12, 0, 5)
CustomLocTitle.Text = "PERMANENT PLACES 💾"
CustomLocTitle.TextColor3 = Color3.fromRGB(0, 180, 255)
CustomLocTitle.BackgroundTransparency = 1
CustomLocTitle.TextSize, CustomLocTitle.Font = 11, Enum.Font.GothamBold
CustomLocTitle.ZIndex = 51
CustomLocTitle.TextXAlignment = Enum.TextXAlignment.Left

local CloseCustomLoc = Instance.new("TextButton", CustomLocPopup)
CloseCustomLoc.Size = UDim2.new(0, 26, 0, 26)
CloseCustomLoc.Position = UDim2.new(1, -32, 0, 8)
CloseCustomLoc.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
CloseCustomLoc.Text = "X"
CloseCustomLoc.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseCustomLoc.TextSize, CloseCustomLoc.Font = 11, Enum.Font.GothamBold
CloseCustomLoc.ZIndex = 51
Instance.new("UICorner", CloseCustomLoc).CornerRadius = UDim.new(0, 6)
CloseCustomLoc.MouseButton1Click:Connect(function() CustomLocPopup.Visible = false end)

local SaveCurrentBtn = Instance.new("TextButton", CustomLocPopup)
SaveCurrentBtn.Size = UDim2.new(0.9, 0, 0, 32)
SaveCurrentBtn.Position = UDim2.new(0.05, 0, 0.16, 0)
SaveCurrentBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
SaveCurrentBtn.Text = "➕ SAVE PERMANENT PLACE"
SaveCurrentBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveCurrentBtn.TextSize, SaveCurrentBtn.Font = 10, Enum.Font.GothamBold
SaveCurrentBtn.ZIndex = 51
Instance.new("UICorner", SaveCurrentBtn).CornerRadius = UDim.new(0, 6)

local CustomLocScroll = Instance.new("ScrollingFrame", CustomLocPopup)
CustomLocScroll.Size = UDim2.new(0.9, 0, 0.65, 0)
CustomLocScroll.Position = UDim2.new(0.05, 0, 0.3, 0)
CustomLocScroll.BackgroundTransparency = 1
CustomLocScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
CustomLocScroll.ScrollBarThickness = 3
CustomLocScroll.ZIndex = 51
local CustomLocListLayout = Instance.new("UIListLayout", CustomLocScroll)
CustomLocListLayout.Padding = UDim.new(0, 5)
CustomLocListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local RenamePopup = Instance.new("Frame", CustomLocPopup)
RenamePopup.Size = UDim2.new(0.9, 0, 0.5, 0)
RenamePopup.Position = UDim2.new(0.05, 0, 0.25, 0)
RenamePopup.BackgroundColor3 = Color3.fromRGB(15, 20, 35)
RenamePopup.Visible = false
RenamePopup.ZIndex = 100
Instance.new("UICorner", RenamePopup).CornerRadius = UDim.new(0, 8)
local RenameStroke = Instance.new("UIStroke", RenamePopup)
RenameStroke.Color = Color3.fromRGB(0, 200, 255)
RenameStroke.Thickness = 2

local RenameTitle = Instance.new("TextLabel", RenamePopup)
RenameTitle.Size = UDim2.new(1, 0, 0, 30)
RenameTitle.Position = UDim2.new(0, 0, 0, 10)
RenameTitle.Text = "ENTER NEW NAME:"
RenameTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
RenameTitle.BackgroundTransparency = 1
RenameTitle.TextSize, RenameTitle.Font = 11, Enum.Font.GothamBold
RenameTitle.ZIndex = 101

local RenameInput = Instance.new("TextBox", RenamePopup)
RenameInput.Size = UDim2.new(0.8, 0, 0, 35)
RenameInput.Position = UDim2.new(0.1, 0, 0.35, 0)
RenameInput.BackgroundColor3 = Color3.fromRGB(25, 35, 55)
RenameInput.Text = ""
RenameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
RenameInput.TextSize, RenameInput.Font = 12, Enum.Font.GothamBold
RenameInput.ZIndex = 101
Instance.new("UICorner", RenameInput).CornerRadius = UDim.new(0, 6)

local ConfirmRenameBtn = Instance.new("TextButton", RenamePopup)
ConfirmRenameBtn.Size = UDim2.new(0.38, 0, 0, 32)
ConfirmRenameBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
ConfirmRenameBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
ConfirmRenameBtn.Text = "OK"
ConfirmRenameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmRenameBtn.TextSize, ConfirmRenameBtn.Font = 11, Enum.Font.GothamBold
ConfirmRenameBtn.ZIndex = 101
Instance.new("UICorner", ConfirmRenameBtn).CornerRadius = UDim.new(0, 6)

local CancelRenameBtn = Instance.new("TextButton", RenamePopup)
CancelRenameBtn.Size = UDim2.new(0.38, 0, 0, 32)
CancelRenameBtn.Position = UDim2.new(0.52, 0, 0.7, 0)
CancelRenameBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
CancelRenameBtn.Text = "CANCEL"
CancelRenameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CancelRenameBtn.TextSize, CancelRenameBtn.Font = 11, Enum.Font.GothamBold
CancelRenameBtn.ZIndex = 101
Instance.new("UICorner", CancelRenameBtn).CornerRadius = UDim.new(0, 6)

local currentEditingOldName = ""

local function refreshCustomLocations()
    for _, child in pairs(CustomLocScroll:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") then child:Destroy() end
    end
    local count = 0
    for name, data in pairs(SavedLocations) do
        count = count + 1
        local row = Instance.new("Frame", CustomLocScroll)
        row.Size = UDim2.new(1, 0, 0, 32)
        row.BackgroundTransparency = 1
        row.ZIndex = 52

        local locBtn = Instance.new("TextButton", row)
        locBtn.Size = UDim2.new(0.52, 0, 1, 0)
        locBtn.BackgroundColor3 = Color3.fromRGB(18, 24, 40)
        locBtn.Text = "📍 " .. name
        locBtn.TextColor3 = Color3.fromRGB(220, 240, 255)
        locBtn.TextSize, locBtn.Font = 10, Enum.Font.GothamBold
        locBtn.ZIndex = 52
        Instance.new("UICorner", locBtn).CornerRadius = UDim.new(0, 6)
        
        locBtn.MouseButton1Click:Connect(function()
            local myRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            if myRoot and data then
                myRoot.CFrame = CFrame.new(data[1], data[2], data[3])
            end
        end)

        local renameBtn = Instance.new("TextButton", row)
        renameBtn.Size = UDim2.new(0.22, 0, 1, 0)
        renameBtn.Position = UDim2.new(0.54, 0, 0, 0)
        renameBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
        renameBtn.Text = "RENAME"
        renameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        renameBtn.TextSize, renameBtn.Font = 9, Enum.Font.GothamBold
        renameBtn.ZIndex = 52
        Instance.new("UICorner", renameBtn).CornerRadius = UDim.new(0, 6)

        renameBtn.MouseButton1Click:Connect(function()
            currentEditingOldName = name
            RenameInput.Text = name
            RenamePopup.Visible = true
        end)

        local delBtn = Instance.new("TextButton", row)
        delBtn.Size = UDim2.new(0.2, 0, 1, 0)
        delBtn.Position = UDim2.new(0.78, 0, 0, 0)
        delBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
        delBtn.Text = "DEL"
        delBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        delBtn.TextSize, delBtn.Font = 9, Enum.Font.GothamBold
        delBtn.ZIndex = 52
        Instance.new("UICorner", delBtn).CornerRadius = UDim.new(0, 6)

        delBtn.MouseButton1Click:Connect(function()
            SavedLocations[name] = nil
            saveWaypointsToFile()
            refreshCustomLocations()
        end)
    end
    CustomLocScroll.CanvasSize = UDim2.new(0, 0, 0, count * 36)
end

ConfirmRenameBtn.MouseButton1Click:Connect(function()
    local newName = RenameInput.Text
    if newName ~= "" and SavedLocations[currentEditingOldName] and not SavedLocations[newName] then
        SavedLocations[newName] = SavedLocations[currentEditingOldName]
        SavedLocations[currentEditingOldName] = nil
        saveWaypointsToFile()
        refreshCustomLocations()
        RenamePopup.Visible = false
    end
end)

CancelRenameBtn.MouseButton1Click:Connect(function()
    RenamePopup.Visible = false
end)

SaveCurrentBtn.MouseButton1Click:Connect(function()
    local myRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if myRoot then
        local pos = myRoot.Position
        local placeName = "Place " .. (table.getn(SavedLocations) + 1)
        SavedLocations[placeName] = {pos.X, pos.Y, pos.Z}
        saveWaypointsToFile()
        refreshCustomLocations()
    end
end)

createActionContainer("PERMANENT PLACES 💾", ScrollingFrame, function()
    local newState = not CustomLocPopup.Visible
    closeAllPopupsExcept(CustomLocPopup)
    CustomLocPopup.Visible = newState
    if newState then refreshCustomLocations() end
end)

btnHideAllGui.MouseButton1Click:Connect(function()
    local guiHidden = ScrollingFrame.Visible
    ScrollingFrame.Visible = not guiHidden
    TitleLabel.Visible = not guiHidden
    MainFrame.Size = guiHidden and UDim2.new(0, 320, 0, 45) or UDim2.new(0, 320, 0, 460)
    btnHideAllGui.Text = guiHidden and "SHOW" or "HIDE"
end)

RunService.RenderStepped:Connect(function()
    local char = LP.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")

    if _G.BypassWalls and char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    if _G.EspEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local humanoid = p.Character:FindFirstChildOfClass("Humanoid")
                local box = EspContainer:FindFirstChild(p.Name .. "_Esp")
                if not box then
                    box = Instance.new("BillboardGui", EspContainer)
                    box.Name = p.Name .. "_Esp"
                    box.AlwaysOnTop = true
                    box.Size = UDim2.new(0, 60, 0, 40)
                    
                    local frame = Instance.new("Frame", box)
                    frame.Size = UDim2.new(1, 0, 1, 0)
                    frame.BackgroundTransparency = 0.8
                    frame.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 4)
                    
                    local infoLabel = Instance.new("TextLabel", frame)
                    infoLabel.Name = "InfoLabel"
                    infoLabel.Size = UDim2.new(1, 0, 1, 0)
                    infoLabel.BackgroundTransparency = 1
                    infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    infoLabel.TextSize = 10
                    infoLabel.Font = Enum.Font.GothamBold
                    infoLabel.TextWrapped = true
                end
                
                local infoLabel = box:FindFirstChild("Frame") and box.Frame:FindFirstChild("InfoLabel")
                if infoLabel and humanoid then
                    local hp = math.floor(humanoid.Health)
                    infoLabel.Text = p.DisplayName .. "\nHP: " .. hp
                end
                
                box.Adornee = p.Character.HumanoidRootPart
            end
        end
    else
        EspContainer:ClearAllChildren()
    end

    if _G.AdminEspEnabled then
        local adminNear = false
        local adminFoundName = ""
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local pNameLower = p.Name:lower()
                local displayNameLower = p.DisplayName:lower()
                if CustomAdmins[pNameLower] or CustomAdmins[displayNameLower] then
                    local pRoot = p.Character.HumanoidRootPart
                    if root then
                        local dist = (root.Position - pRoot.Position).Magnitude
                        if dist < 50 then
                            adminNear = true
                            adminFoundName = p.DisplayName
                        end
                    end
                    local box = AdminEspContainer:FindFirstChild(p.Name .. "_Admin")
                    if not box then
                        box = Instance.new("BillboardGui", AdminEspContainer)
                        box.Name = p.Name .. "_Admin"
                        box.AlwaysOnTop = true
                        box.Size = UDim2.new(0, 40, 0, 60)
                        local frame = Instance.new("Frame", box)
                        frame.Size = UDim2.new(1, 0, 1, 0)
                        frame.BackgroundTransparency = 0.7
                        frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 4)
                        
                        local nameTag = Instance.new("TextLabel", frame)
                        nameTag.Size = UDim2.new(1, 0, 0, 20)
                        nameTag.Position = UDim2.new(0, 0, -1, 0)
                        nameTag.BackgroundTransparency = 1
                        nameTag.TextColor3 = Color3.fromRGB(255, 50, 50)
                        nameTag.TextSize = 10
                        nameTag.Font = Enum.Font.GothamBold
                        nameTag.Text = p.DisplayName
                    end
                    box.Adornee = pRoot
                end
            end
        end
        if adminNear then
            CenterAlert.Text = "⚠️ WARNING: ADMIN (" .. adminFoundName .. ") NEAR!"
            CenterAlert.Visible = true
        else
            CenterAlert.Visible = false
        end
    else
        AdminEspContainer:ClearAllChildren()
        CenterAlert.Visible = false
    end

    if _G.AimbotEnabled and root then
        local closestTarget = nil
        local shortestDist = math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                -- التحقق هل اللاعب موجود في قائمة الجانج المستثناة أم لا
                local skipGang = GangList[p.UserId] == true

                if not skipGang then
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

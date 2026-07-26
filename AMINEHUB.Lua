local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local ScreenGui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
ScreenGui.Name = "AmineHubRP"
ScreenGui.ResetOnSpawn = false

-- Admin List (تم حذف raslenh_k)
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
CenterAlert.Size = UDim2.new(0, 380, 0, 45)
CenterAlert.Position = UDim2.new(0.5, -190, 0.12, 0)
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
TitleLabel.Size = UDim2.new(0, 180, 0, 30)
TitleLabel.Position = UDim2.new(0, 12, 0, 8)
TitleLabel.Text = "AMINE HUB - Amin"
TitleLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextSize, TitleLabel.Font = 16, Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 2

local btnHideAllGui = Instance.new("TextButton", MainFrame)
btnHideAllGui.Size = UDim2.new(0, 90, 0, 28)
btnHideAllGui.Position = UDim2.new(1, -102, 0, 8)
btnHideAllGui.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
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
WatermarkBtn.TextColor3 = Color3.fromRGB(0, 180, 255)
WatermarkBtn.TextSize, WatermarkBtn.Font = 14, Enum.Font.GothamBold
WatermarkBtn.Visible = false
WatermarkBtn.Active = true
WatermarkBtn.Draggable = true
WatermarkBtn.ZIndex = 200
Instance.new("UICorner", WatermarkBtn).CornerRadius = UDim.new(1, 0)
local WatermarkStroke = Instance.new("UIStroke", WatermarkBtn)
WatermarkStroke.Color = Color3.fromRGB(0, 160, 255)
WatermarkStroke.Thickness = 2

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

btnHideAllGui.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    WatermarkBtn.Visible = true
end)

WatermarkBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    WatermarkBtn.Visible = false
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
                    infoLabel.Text = p.DisplayName .. "\nHP: " .. math.floor(humanoid.Health)
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
        local minDistance = 1000
        local closestDist = math.huge

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local pNameLower = p.Name:lower()
                local displayNameLower = p.DisplayName:lower()
                if CustomAdmins[pNameLower] or CustomAdmins[displayNameLower] then
                    local pRoot = p.Character.HumanoidRootPart
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

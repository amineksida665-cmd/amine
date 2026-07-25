local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RunService = game:GetService("RunService")

local ScreenGui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
ScreenGui.Name = "RippersUI"

-- Main Window
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 340, 0, 540)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -270)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Header & Blue Clone Circle Button
local TitleLabel = Instance.new("TextLabel", MainFrame)
TitleLabel.Size = UDim2.new(1, -50, 0, 40)
TitleLabel.Text = "  AMIN"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local CloneCircleBtn = Instance.new("TextButton", MainFrame)
CloneCircleBtn.Size = UDim2.new(0, 32, 0, 32)
CloneCircleBtn.Position = UDim2.new(1, -40, 0, 4)
CloneCircleBtn.BackgroundColor3 = Color3.fromRGB(30, 100, 255)
CloneCircleBtn.Text = "C"
CloneCircleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloneCircleBtn.Font = Enum.Font.GothamBold
CloneCircleBtn.TextSize = 14
Instance.new("UICorner", CloneCircleBtn).CornerRadius = UDim.new(1, 0)

CloneCircleBtn.MouseButton1Click:Connect(function()
    local char = LP.Character
    if char then
        char.Archivable = true
        local clone = char:Clone()
        clone.Parent = workspace
        clone:PivotTo(char:GetPivot() + CFrame.new(3, 0, 0))
    end
end)

-- Scrolling Container
local ScrollingFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollingFrame.Size = UDim2.new(1, -20, 1, -85)
ScrollingFrame.Position = UDim2.new(0, 10, 0, 45)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
ScrollingFrame.ScrollBarThickness = 4

local UIList = Instance.new("UIListLayout", ScrollingFrame)
UIList.Padding = UDim.new(0, 8)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Helper to create feature buttons (Toggle ON/OFF)
local function createFeature(name, callback)
    local MainBtn = Instance.new("TextButton", ScrollingFrame)
    MainBtn.Size = UDim2.new(0.95, 0, 0, 38)
    MainBtn.BackgroundColor3 = Color3.fromRGB(45, 38, 65)
    MainBtn.Text = name .. ": OFF"
    MainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainBtn.TextSize = 13
    MainBtn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", MainBtn).CornerRadius = UDim.new(0, 6)

    local toggled = false
    MainBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        MainBtn.Text = name .. (toggled and ": ON" or ": OFF")
        MainBtn.BackgroundColor3 = toggled and Color3.fromRGB(60, 120, 80) or Color3.fromRGB(45, 38, 65)
        callback(toggled)
    end)
end

createFeature("ESP", function(on) _G.ESPEnabled = on end)
createFeature("YOUR GANG", function(on) _G.YourGangEnabled = on end)
createFeature("AUTO", function(on) _G.AutoEnabled = on end)
createFeature("TP", function(on) _G.TPEnabled = on end)
createFeature("HIDE", function(on) 
    local char = LP.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.Transparency = on and 1 or 0 end
        end
    end
end)
createFeature("WALL", function(on) _G.WallEnabled = on end)
createFeature("FLY", function(on) 
    _G.FlyEnabled = on
    local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if on and root then
        local bv = Instance.new("BodyVelocity", root)
        bv.Name = "RippersFlyVel"
        bv.MaxForce = Vector3.new(99999, 99999, 99999)
        bv.Velocity = Vector3.new(0, 0, 0)
        _G.FlyBV = bv
    else
        if _G.FlyBV then _G.FlyBV:Destroy() end
    end
end)
createFeature("LOCK", function(on) _G.LockEnabled = on end)

-- Target List Popup (Server Players list)
local TargetPopup = Instance.new("Frame", MainFrame)
TargetPopup.Size = UDim2.new(0, 220, 0, 350)
TargetPopup.Position = UDim2.new(-0.7, 0, 0.1, 0)
TargetPopup.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
TargetPopup.Visible = false
TargetPopup.ZIndex = 5
Instance.new("UICorner", TargetPopup).CornerRadius = UDim.new(0, 8)
local TargetStroke = Instance.new("UIStroke", TargetPopup)
TargetStroke.Color = Color3.fromRGB(60, 150, 255)
TargetStroke.Thickness = 2

local TargetScroll = Instance.new("ScrollingFrame", TargetPopup)
TargetScroll.Size = UDim2.new(0.9, 0, 0.85, 0)
TargetScroll.Position = UDim2.new(0.05, 0, 0.08, 0)
TargetScroll.BackgroundTransparency = 1
TargetScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
TargetScroll.ScrollBarThickness = 3
TargetScroll.ZIndex = 6

local TargetListLayout = Instance.new("UIListLayout", TargetScroll)
TargetListLayout.Padding = UDim.new(0, 5)
TargetListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

_G.IgnoredPlayers = {}

local function updateTargetList()
    for _, child in pairs(TargetScroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then
            local pBtn = Instance.new("TextButton", TargetScroll)
            pBtn.Size = UDim2.new(1, 0, 0, 35)
            pBtn.BackgroundColor3 = _G.IgnoredPlayers[p.Name] and Color3.fromRGB(150, 50, 50) or Color3.fromRGB(45, 38, 65)
            pBtn.Text = "IGNORE: " .. p.Name
            pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            pBtn.TextSize = 11
            pBtn.Font = Enum.Font.GothamBold
            pBtn.ZIndex = 6
            Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 6)
            
            pBtn.MouseButton1Click:Connect(function()
                _G.IgnoredPlayers[p.Name] = not _G.IgnoredPlayers[p.Name]
                pBtn.BackgroundColor3 = _G.IgnoredPlayers[p.Name] and Color3.fromRGB(150, 50, 50) or Color3.fromRGB(45, 38, 65)
            end)
        end
    end
    TargetScroll.CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * 40)
end

-- Button to open the Player Target list window
local TargetMenuBtn = Instance.new("TextButton", ScrollingFrame)
TargetMenuBtn.Size = UDim2.new(0.95, 0, 0, 38)
TargetMenuBtn.BackgroundColor3 = Color3.fromRGB(45, 38, 65)
TargetMenuBtn.Text = "SERVER TARGETS LIST"
TargetMenuBtn.TextColor3 = Color3.fromRGB(100, 180, 255)
TargetMenuBtn.TextSize = 12
TargetMenuBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", TargetMenuBtn).CornerRadius = UDim.new(0, 6)

TargetMenuBtn.MouseButton1Click:Connect(function()
    TargetPopup.Visible = not TargetPopup.Visible
    if TargetPopup.Visible then updateTargetList() end
end)

-- Footer Signature
local FooterLabel = Instance.new("TextLabel", MainFrame)
FooterLabel.Size = UDim2.new(1, 0, 0, 25)
FooterLabel.Position = UDim2.new(0, 0, 1, -28)
FooterLabel.BackgroundTransparency = 1
FooterLabel.Text = "Made by Amin 8F"
FooterLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
FooterLabel.TextSize = 11
FooterLabel.Font = Enum.Font.GothamBold
FooterLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Core Loops
RunService.Stepped:Connect(function()
    if _G.WallEnabled and LP.Character then
        for _, part in pairs(LP.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
    if _G.LockEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and not _G.IgnoredPlayers[p.Name] then
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, p.Character.Head.Position)
                break
            end
        end
    end
end)

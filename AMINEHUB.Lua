-- AMINE HUB - FREE FIRE ESP & AIMBOT SCRIPT
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

-- إعدادات السكربت
_G.EspEnabled = true
_G.AimbotEnabled = true
_G.AimbotFOV = 150 -- مساحة التهديف

-- إنشاء واجهة الرسوميات لعرض كشف الأماكن
local ScreenGui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
ScreenGui.Name = "FreeFireHub"
ScreenGui.ResetOnSpawn = false

local EspContainer = Instance.new("Folder", ScreenGui)
EspContainer.Name = "EspContainer"

-- دالة كشف الأماكن (ESP Box & Health)
RunService.RenderStepped:Connect(function()
    if not _G.EspEnabled then
        EspContainer:ClearAllChildren()
        return
    end

    EspContainer:ClearAllChildren()

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local pChar = p.Character
            local pRoot = pChar.HumanoidRootPart
            local hum = pChar:FindFirstChildOfClass("Humanoid")

            -- تحويل إحداثيات اللاعب إلى الشاشة
            local vector, onScreen = Camera:WorldToViewportPoint(pRoot.Position)

            if onScreen then
                local head = pChar:FindFirstChild("Head")
                if head then
                    local headVector = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                    local legVector = Camera:WorldToViewportPoint(pRoot.Position - Vector3.new(0, 3, 0))
                    local height = math.abs(headVector.Y - legVector.Y)
                    local width = height / 2

                    -- إنشاء صندوق كشف الأماكن حول اللاعب
                    local box = Instance.new("Frame", EspContainer)
                    box.Size = UDim2.new(0, width, 0, height)
                    box.Position = UDim2.new(0, headVector.X - width / 2, 0, headVector.Y)
                    box.BackgroundTransparency = 1
                    
                    local stroke = Instance.new("UIStroke", box)
                    stroke.Color = Color3.fromRGB(255, 0, 0) -- لون أحمر للعدو
                    stroke.Thickness = 1.5

                    -- عرض اسم اللاعب وكمية الدم (Health)
                    if hum then
                        local infoLabel = Instance.new("TextLabel", box)
                        infoLabel.Size = UDim2.new(1, 0, 0, 20)
                        infoLabel.Position = UDim2.new(0, 0, -1, 0)
                        infoLabel.BackgroundTransparency = 1
                        infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        infoLabel.TextSize = 11
                        infoLabel.Font = Enum.Font.GothamBold
                        infoLabel.TextStrokeTransparency = 0.3
                        infoLabel.Text = p.DisplayName .. " [" .. math.floor(hum.Health) .. "HP]"
                    end
                end
            end
        end
    end
end)

-- نظام الإيمبوت (Aimbot) تلقائي للرأس عند الضغط أو التفعيل
RunService.RenderStepped:Connect(function()
    if _G.AimbotEnabled then
        local closestTarget = nil
        local shortestDist = math.huge
        local mouseLocation = UserInputService:GetMouseLocation()

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local pHead = p.Character:FindFirstChild("Head")
                local pHumanoid = p.Character:FindFirstChildOfClass("Humanoid")
                
                if pHead and pHumanoid and pHumanoid.Health > 0 then
                    local screenPoint, onScreen = Camera:WorldToViewportPoint(pHead.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPoint.X, screenPoint.Y) - mouseLocation).Magnitude
                        if dist < shortestDist and dist <= _G.AimbotFOV then
                            shortestDist = dist
                            closestTarget = pHead
                        end
                    end
                end
            end
        end

        -- توجيه الكاميرا تلقائياً نحو رأس أقرب خصم
        if closestTarget then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestTarget.Position)
        end
    end
end)

print("Free Fire ESP & Aimbot Loaded Successfully!")

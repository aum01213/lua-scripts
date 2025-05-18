local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "TabbedUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(32, 34, 37)
mainFrame.BorderSizePixel = 0
mainFrame.Name = "MainFrame"
mainFrame.Parent = gui
mainFrame.Active = true

-- Top Bar (ลาก GUI)
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
topBar.BorderSizePixel = 0
topBar.Name = "TopBar"
topBar.Parent = mainFrame

local topBarLabel = Instance.new("TextLabel")
topBarLabel.Text = "Aum Pro V.1"
topBarLabel.Size = UDim2.new(1, 0, 1, 0)
topBarLabel.BackgroundTransparency = 1
topBarLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
topBarLabel.Font = Enum.Font.GothamBold
topBarLabel.TextSize = 16
topBarLabel.Parent = topBar

-- Sidebar (พื้นที่ว่าง ซ้าย)
local sideBar = Instance.new("Frame")
sideBar.Size = UDim2.new(0, 100, 1, -40)
sideBar.Position = UDim2.new(0, 0, 0, 40)
sideBar.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
sideBar.BorderSizePixel = 0
sideBar.Name = "SideBar"
sideBar.Parent = mainFrame

-- Content Area (ขวา)
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -100, 1, -40)
contentFrame.Position = UDim2.new(0, 100, 0, 40)
contentFrame.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
contentFrame.Name = "AutoContent"
contentFrame.Parent = mainFrame

-- Label "Auto Farm"
local autoFarmLabel = Instance.new("TextLabel")
autoFarmLabel.Text = "Auto Farm"
autoFarmLabel.Size = UDim2.new(0, 120, 0, 40)
autoFarmLabel.Position = UDim2.new(0, 30, 0, 30)
autoFarmLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
autoFarmLabel.BackgroundTransparency = 1
autoFarmLabel.TextXAlignment = Enum.TextXAlignment.Left
autoFarmLabel.Font = Enum.Font.GothamSemibold
autoFarmLabel.TextSize = 22
autoFarmLabel.Parent = contentFrame

-- Toggle Button (วงกลมเล็กลง)
local autoFarmToggle = Instance.new("TextButton")
autoFarmToggle.Size = UDim2.new(0, 20, 0, 20)
autoFarmToggle.Position = UDim2.new(0, 180, 0, 40)
autoFarmToggle.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
autoFarmToggle.Text = ""
autoFarmToggle.Name = "AutoFarmToggle"
autoFarmToggle.AutoButtonColor = false
autoFarmToggle.Parent = contentFrame
autoFarmToggle.BorderSizePixel = 0
autoFarmToggle.ZIndex = 2
autoFarmToggle.ClipsDescendants = true

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(1, 0) -- ทำเป็นวงกลม
uiCorner.Parent = autoFarmToggle

local border = Instance.new("UIStroke")
border.Color = Color3.fromRGB(120, 120, 120)
border.Thickness = 2
border.Parent = autoFarmToggle

local checkMark = Instance.new("Frame")
checkMark.Size = UDim2.new(1, -10, 1, -10)
checkMark.Position = UDim2.new(0, 5, 0, 5)
checkMark.BackgroundColor3 = Color3.fromRGB(40, 200, 120)
checkMark.Visible = false
checkMark.Name = "CheckMark"
checkMark.Parent = autoFarmToggle
checkMark.ZIndex = 3
checkMark.ClipsDescendants = true
checkMark.BorderSizePixel = 0

local checkCorner = Instance.new("UICorner")
checkCorner.CornerRadius = UDim.new(1, 0) -- วงกลมเหมือนกัน
checkCorner.Parent = checkMark

-- Toggle logic
local isAutoFarmOn = false
autoFarmToggle.MouseButton1Click:Connect(function()
	isAutoFarmOn = not isAutoFarmOn
	checkMark.Visible = isAutoFarmOn
	if isAutoFarmOn then
		autoFarmToggle.BackgroundColor3 = Color3.fromRGB(50, 150, 70)
	else
		autoFarmToggle.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
	end
	print("Auto Farm is", isAutoFarmOn and "ON" or "OFF")
end)

-- Dragging logic for topBar
local UserInputService = game:GetService("UserInputService")
local dragging = false
local dragStart, startPos

topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
	end
end)

topBar.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- Auto Farm Loop: ส่งคำสั่ง RemoteEvent ทุก 0.5 วินาทีเมื่อเปิด
spawn(function()
	while true do
		wait(0.01)
		if isAutoFarmOn then
			local args = {
				[1] = {
					[1] = {
						[1] = "\5",
						[2] = "Combat",
						[3] = 2,
						[4] = false,
						[5] = player.Character and player.Character:FindFirstChild("Combat"),
						[6] = "Melee",
						[7] = {
							[1] = Vector3.new(3383.283447265625, 135.72975158691406, 1761.7642822265625),
							[2] = Vector3.new(0.057197459042072296, -0.12832456827163696, 0.9900814294815063)
						}
					}
				}
			}
			local remote = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvent")
			if remote then
				remote:FireServer(unpack(args))
			end
		end
	end
end))



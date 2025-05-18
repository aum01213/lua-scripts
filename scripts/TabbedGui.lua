-- Create GUI elements
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "TabbedUI"

-- Main Frame
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Name = "MainFrame"

-- Tab Buttons Container
local tabBar = Instance.new("Frame", mainFrame)
tabBar.Size = UDim2.new(1, 0, 0, 40)
tabBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
tabBar.BorderSizePixel = 0

-- Tab Buttons
local tabs = {}
local tabNames = {"Home", "Settings"}

for i, name in pairs(tabNames) do
    local button = Instance.new("TextButton", tabBar)
    button.Size = UDim2.new(0, 100, 1, 0)
    button.Position = UDim2.new(0, (i - 1) * 100, 0, 0)
    button.Text = name
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Name = name .. "TabButton"
    tabs[name] = button
end

-- Tab Pages
local pages = {}
for _, name in pairs(tabNames) do
    local page = Instance.new("Frame", mainFrame)
    page.Size = UDim2.new(1, 0, 1, -40)
    page.Position = UDim2.new(0, 0, 0, 40)
    page.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    page.Name = name .. "Page"
    page.Visible = false

    -- Example Content
    local label = Instance.new("TextLabel", page)
    label.Text = name .. " Content Here"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.TextColor3 = Color3.new(1, 1, 1)
    label.BackgroundTransparency = 1
    label.TextScaled = true

    pages[name] = page
end

-- Tab Switching Logic
local function showTab(tabName)
    for name, page in pairs(pages) do
        page.Visible = (name == tabName)
    end
end

-- Connect Buttons
for name, button in pairs(tabs) do
    button.MouseButton1Click:Connect(function()
        showTab(name)
    end)
end

-- Default Tab
showTab("Home")

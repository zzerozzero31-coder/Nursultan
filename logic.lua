task.wait(0.1) -- Ждем, пока первый файл загрузит UI

local ScreenGui = getgenv().ScreenGui
local THEME = getgenv().THEME
local ICONS = getgenv().ICONS
local createTabPage = getgenv().createTabPage
local createCard = getgenv().createCard
local addToggle = getgenv().addToggle
local createSlider = getgenv().createSlider
local createButton = getgenv().createButton
local addSidebarItem = getgenv().addSidebarItem

-- Вкладка Settings
local settingsTab = createTabPage("Settings")
local uiCard = createCard(settingsTab.Col1, "Interface", 1)

-- Stealth Mode
addToggle(uiCard, "Stealth Mode", false, function(s)
    if s then 
        ScreenGui.Enabled = false
        local icon = Instance.new("ImageButton")
        icon.Size = UDim2.new(0, 40, 0, 40); icon.Position = UDim2.new(1, -12, 1, -12); icon.AnchorPoint = Vector2.new(1, 1)
        icon.BackgroundTransparency = 1; icon.Image = "rbxassetid://139568612294283"; icon.ZIndex = 800; icon.Parent = ScreenGui
        icon.MouseButton1Click:Connect(function()
            ScreenGui.Enabled = true
            icon:Destroy()
            if not getgenv().isOpen then getgenv().openUI() end
        end)
    else
        ScreenGui.Enabled = true
    end
end)

-- NoName
local NoNameEnabled = false
task.spawn(function()
    local t = 0
    while ScreenGui and ScreenGui.Parent do
        if NoNameEnabled then
            t = t + 1
            if getgenv().NursultanSetNameLabel then getgenv().NursultanSetNameLabel(string.rep("?", (t % 5) + 1)) end
        end
        task.wait(0.35)
    end
end)

addToggle(uiCard, "NoName", false, function(s)
    NoNameEnabled = s
    if not s and getgenv().NursultanSetNameLabel then getgenv().NursultanSetNameLabel(string.lower(game.Players.LocalPlayer.Name)) end
end)

-- Кнопка выгрузки
local uCard = createCard(settingsTab.Col2, "Misc", 1)
createButton(uCard, "Unload UI", "Removes the GUI completely", 1, function()
    getgenv().NursultanShowUnloadConfirm()
end)

-- Вкладка Combat
local combatTab = createTabPage("Combat")
local aimCard = createCard(combatTab.Col1, "Aim Bot", 1)
addToggle(aimCard, "Enabled", false, function(s) print("AimBot:", s) end)
createSlider(aimCard, "Circle Size", 20, 300, 80, 3, function(v) print("Size:", v) end)

-- Сайдбар
addSidebarItem("Combat", ICONS.Combat, 1)
addSidebarItem("Settings", ICONS.Settings, 2)

-- Кнопка закрытия
getgenv().CloseBtn.MouseButton1Click:Connect(getgenv().NursultanShowUnloadConfirm)

-- Запуск
getgenv().HudContainer.Visible = true
getgenv().openUI()
getgenv().NursultanNotify("nursultan ui", "Loaded successfully!", 3)

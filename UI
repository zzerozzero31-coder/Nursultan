local success, err = pcall(function()

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer

local CUSTOM_LOGO_ID = "rbxassetid://139568612294283"
local NOTIFICATION_ICON = "rbxassetid://70752671105522"
local NOTIFICATION_SOUND = "rbxassetid://6042053626"

if _G.NursultanUI_Loaded then
    local existing = _G.NursultanUI_ScreenGui
    if existing and existing.Parent then
        pcall(function() existing:Destroy() end)
    end
    local existingBlur = _G.NursultanUI_Blur
    if existingBlur and existingBlur.Parent then
        pcall(function() existingBlur:Destroy() end)
    end
end

local function findExistingGui()
    local parents = {}
    if gethui then
        pcall(function() table.insert(parents, gethui()) end)
    end
    table.insert(parents, CoreGui)
    table.insert(parents, LocalPlayer:WaitForChild("PlayerGui"))

    for _, parent in ipairs(parents) do
        if parent then
            local ok, gui = pcall(function()
                return parent:FindFirstChild("PastaCompleteUI")
            end)
            if ok and gui then return gui end
        end
    end
    return nil
end

local existing = findExistingGui()
while existing do
    pcall(function() existing:Destroy() end)
    existing = findExistingGui()
end

for _, obj in ipairs(Lighting:GetChildren()) do
    if obj:IsA("BlurEffect") and obj.Name == "NursultanBlur" then
        pcall(function() obj:Destroy() end)
    end
end

for _, obj in ipairs(SoundService:GetChildren()) do
    if obj:IsA("Sound") and obj.Name == "NursultanNotifSound" then
        pcall(function() obj:Destroy() end)
    end
end

_G.NursultanUI_Loaded = true

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PastaCompleteUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999
ScreenGui.IgnoreGuiInset = true

local targetParent = LocalPlayer:WaitForChild("PlayerGui")
local parentOk = pcall(function()
    ScreenGui.Parent = targetParent
end)
if not parentOk then
    ScreenGui.Parent = CoreGui
end

_G.NursultanUI_ScreenGui = ScreenGui

local THEME = {
    Background    = Color3.fromRGB(12, 9, 11),
    CardBg        = Color3.fromRGB(18, 13, 16),
    CardHover     = Color3.fromRGB(22, 16, 19),
    PillBg        = Color3.fromRGB(16, 12, 14),
    SidebarActive = Color3.fromRGB(27, 16, 19),
    Border        = Color3.fromRGB(36, 24, 28),
    BorderActive  = Color3.fromRGB(90, 36, 42),
    Accent        = Color3.fromRGB(246, 92, 82),
    AccentSoft    = Color3.fromRGB(255, 165, 155),
    AccentDark    = Color3.fromRGB(130, 40, 42),
    TextPrimary   = Color3.fromRGB(235, 235, 235),
    TextMuted     = Color3.fromRGB(120, 110, 115),
    TextDim       = Color3.fromRGB(72, 64, 68),
    Divider       = Color3.fromRGB(48, 36, 40),
    BadgeBg       = Color3.fromRGB(25, 18, 22),
    ToggleOff     = Color3.fromRGB(36, 28, 32),
    KnobOff       = Color3.fromRGB(78, 68, 73),
    KnobOn        = Color3.fromRGB(255, 255, 255)
}

local ICONS = {
    Search   = "rbxassetid://7733911828",
    Chevron  = "rbxassetid://7733717447",
    More     = "rbxassetid://7734021300",
    Menu     = "rbxassetid://7733993211",
    Combat   = "rbxassetid://7734053426",
    Movement = "rbxassetid://7733799901",
    Visuals  = "rbxassetid://7733774602",
    Player   = "rbxassetid://7733954760",
    Misc     = "rbxassetid://7734056411",
    Presets  = "rbxassetid://7733964719",
    AutoBuy  = "rbxassetid://7733942651",
    Accounts = "rbxassetid://7733765307",
    Settings = "rbxassetid://7059346386",
    Keybinds = "rbxassetid://7734021300",
    User     = "rbxassetid://7733954760",
    Chart    = "rbxassetid://7733749837",
    Clock    = "rbxassetid://7733734762",
    Compass  = "rbxassetid://7733720755",
    Signal   = "rbxassetid://7734058495",
    Radar    = "rbxassetid://7734053426",
    Speed    = "rbxassetid://7733799901",
    Close    = "rbxassetid://10723407389"
}

local TWEEN_FAST = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TWEEN_SLOW = TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)

local blurEffect = Instance.new("BlurEffect")
blurEffect.Name = "NursultanBlur"
blurEffect.Size = 0
blurEffect.Parent = Lighting

_G.NursultanUI_Blur = blurEffect

local notifSound = Instance.new("Sound")
notifSound.Name = "NursultanNotifSound"
notifSound.SoundId = NOTIFICATION_SOUND
notifSound.Volume = 0.4
notifSound.Parent = SoundService

local themeObjects = {}
local function registerThemeObj(obj)
    table.insert(themeObjects, obj)
end
_G.NursultanRegisterThemeObj = registerThemeObj

-- Ripple
local rippleHolder = Instance.new("Frame")
rippleHolder.Name = "RippleHolder"
rippleHolder.Size = UDim2.new(1, 0, 1, 0)
rippleHolder.BackgroundTransparency = 1
rippleHolder.ZIndex = 700
rippleHolder.Parent = ScreenGui

local function spawnRipple(absX, absY, color)
    local ripple = Instance.new("Frame")
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Position = UDim2.new(0, absX, 0, absY)
    ripple.BackgroundColor3 = color or THEME.Accent
    ripple.BackgroundTransparency = 0.6
    ripple.BorderSizePixel = 0
    ripple.ZIndex = 701
    ripple.Parent = rippleHolder

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = ripple

    TweenService:Create(ripple, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 80, 0, 80),
        BackgroundTransparency = 1
    }):Play()

    task.delay(0.6, function()
        if ripple and ripple.Parent then ripple:Destroy() end
    end)
end

local function attachRipple(obj)
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local pos = UserInputService:GetMouseLocation()
            spawnRipple(pos.X, pos.Y, THEME.Accent)
        end
    end)
end

-- Favorites
local FAVORITES = {}
_G.NursultanFavorites = FAVORITES

local function isFavorite(name)
    return FAVORITES[name] == true
end

local function toggleFavorite(name)
    FAVORITES[name] = not FAVORITES[name]
    if not FAVORITES[name] then FAVORITES[name] = nil end
    if _G.NursultanRefreshFavorites then
        _G.NursultanRefreshFavorites()
    end
end

-- Tooltip
local tooltipHolder = Instance.new("Frame")
tooltipHolder.Name = "TooltipHolder"
tooltipHolder.Size = UDim2.new(0, 0, 0, 0)
tooltipHolder.BackgroundTransparency = 1
tooltipHolder.ZIndex = 600
tooltipHolder.Parent = ScreenGui

local tooltip = Instance.new("Frame")
tooltip.Name = "Tooltip"
tooltip.AnchorPoint = Vector2.new(0.5, 1)
tooltip.Size = UDim2.new(0, 100, 0, 22)
tooltip.BackgroundColor3 = THEME.CardBg
tooltip.BackgroundTransparency = 1
tooltip.BorderSizePixel = 0
tooltip.Visible = false
tooltip.ZIndex = 601
tooltip.Parent = tooltipHolder

local tooltipCorner = Instance.new("UICorner")
tooltipCorner.CornerRadius = UDim.new(0, 5)
tooltipCorner.Parent = tooltip

local tooltipStroke = Instance.new("UIStroke")
tooltipStroke.Color = THEME.BorderActive
tooltipStroke.Thickness = 1
tooltipStroke.Transparency = 1
tooltipStroke.Parent = tooltip

local tooltipLabel = Instance.new("TextLabel")
tooltipLabel.Size = UDim2.new(1, -10, 1, 0)
tooltipLabel.Position = UDim2.new(0, 5, 0, 0)
tooltipLabel.BackgroundTransparency = 1
tooltipLabel.Text = ""
tooltipLabel.Font = Enum.Font.GothamMedium
tooltipLabel.TextSize = 10
tooltipLabel.TextColor3 = THEME.TextPrimary
tooltipLabel.TextTransparency = 1
tooltipLabel.TextXAlignment = Enum.TextXAlignment.Center
tooltipLabel.ZIndex = 602
tooltipLabel.Parent = tooltip

local tooltipTween

local function showTooltip(text, anchorObj)
    if tooltipTween then tooltipTween:Cancel() end
    tooltipLabel.Text = text
    tooltipLabel.TextColor3 = THEME.TextPrimary
    tooltipLabel.TextTransparency = 1
    tooltipStroke.Transparency = 1
    tooltip.BackgroundColor3 = THEME.CardBg
    tooltip.BackgroundTransparency = 1

    local absPos = anchorObj.AbsolutePosition
    local absSize = anchorObj.AbsoluteSize
    tooltip.Size = UDim2.new(0, math.max(70, #text * 6 + 20), 0, 22)
    tooltip.Position = UDim2.new(0, absPos.X + absSize.X / 2, 0, absPos.Y - 6)
    tooltip.Visible = true

    tooltipTween = TweenService:Create(tooltip, TWEEN_FAST, {
        BackgroundTransparency = 0.05
    })
    tooltipTween:Play()
    TweenService:Create(tooltipStroke, TWEEN_FAST, {Transparency = 0}):Play()
    TweenService:Create(tooltipLabel, TWEEN_FAST, {TextTransparency = 0}):Play()
end

local function hideTooltip()
    if tooltipTween then tooltipTween:Cancel() end
    tooltipTween = TweenService:Create(tooltip, TWEEN_FAST, {
        BackgroundTransparency = 1
    })
    tooltipTween:Play()
    TweenService:Create(tooltipStroke, TWEEN_FAST, {Transparency = 1}):Play()
    local t = TweenService:Create(tooltipLabel, TWEEN_FAST, {TextTransparency = 1})
    t:Play()
    t.Completed:Connect(function()
        tooltip.Visible = false
    end)
end
_G.NursultanHideTooltip = hideTooltip

-- Notifications
local NotificationHolder = Instance.new("Frame")
NotificationHolder.Name = "NotificationHolder"
NotificationHolder.AnchorPoint = Vector2.new(1, 0)
NotificationHolder.Size = UDim2.new(0, 320, 0, 500)
NotificationHolder.Position = UDim2.new(1, -16, 0, 52)
NotificationHolder.BackgroundTransparency = 1
NotificationHolder.ZIndex = 400
NotificationHolder.Parent = ScreenGui

local NotificationList = Instance.new("UIListLayout")
NotificationList.SortOrder = Enum.SortOrder.LayoutOrder
NotificationList.Padding = UDim.new(0, 8)
NotificationList.HorizontalAlignment = Enum.HorizontalAlignment.Right
NotificationList.Parent = NotificationHolder

local function notify(title, description, duration)
    duration = duration or 3

    task.spawn(function()
        pcall(function()
            notifSound.TimePosition = 0
            notifSound:Play()
        end)
    end)

    local notif = Instance.new("Frame")
    notif.Name = "Notification"
    notif.Size = UDim2.new(0, 300, 0, 64)
    notif.BackgroundColor3 = THEME.CardBg
    notif.BorderSizePixel = 0
    notif.ZIndex = 401
    notif.Parent = NotificationHolder

    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 8)
    notifCorner.Parent = notif

    local notifStroke = Instance.new("UIStroke")
    notifStroke.Color = THEME.Border
    notifStroke.Thickness = 1
    notifStroke.Parent = notif

    local accentBar = Instance.new("Frame")
    accentBar.Size = UDim2.new(0, 3, 1, -16)
    accentBar.Position = UDim2.new(0, 0, 0, 8)
    accentBar.BackgroundColor3 = THEME.Accent
    accentBar.BorderSizePixel = 0
    accentBar.ZIndex = 402
    accentBar.Parent = notif

    local accentCorner = Instance.new("UICorner")
    accentCorner.CornerRadius = UDim.new(1, 0)
    accentCorner.Parent = accentBar

    local iconHolder = Instance.new("Frame")
    iconHolder.Size = UDim2.new(0, 36, 0, 36)
    iconHolder.Position = UDim2.new(0, 12, 0, 14)
    iconHolder.BackgroundColor3 = THEME.PillBg
    iconHolder.BorderSizePixel = 0
    iconHolder.ZIndex = 402
    iconHolder.Parent = notif

    local iconHolderCorner = Instance.new("UICorner")
    iconHolderCorner.CornerRadius = UDim.new(0, 7)
    iconHolderCorner.Parent = iconHolder

    local iconHolderStroke = Instance.new("UIStroke")
    iconHolderStroke.Color = THEME.Border
    iconHolderStroke.Thickness = 1
    iconHolderStroke.Parent = iconHolder

    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 22, 0, 22)
    icon.Position = UDim2.new(0.5, -11, 0.5, -11)
    icon.BackgroundTransparency = 1
    icon.Image = NOTIFICATION_ICON
    icon.ScaleType = Enum.ScaleType.Fit
    icon.ImageColor3 = THEME.Accent
    icon.ZIndex = 403
    icon.Parent = iconHolder

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -80, 0, 16)
    titleLabel.Position = UDim2.new(0, 56, 0, 12)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 12
    titleLabel.TextColor3 = THEME.TextPrimary
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
    titleLabel.ZIndex = 402
    titleLabel.Parent = notif

    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -80, 0, 14)
    descLabel.Position = UDim2.new(0, 56, 0, 30)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = description
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 10
    descLabel.TextColor3 = THEME.TextMuted
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.TextTruncate = Enum.TextTruncate.AtEnd
    descLabel.ZIndex = 402
    descLabel.Parent = notif

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 18, 0, 18)
    closeBtn.Position = UDim2.new(1, -26, 0, 8)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = ""
    closeBtn.ZIndex = 403
    closeBtn.Parent = notif

    local closeIcon = Instance.new("ImageLabel")
    closeIcon.Size = UDim2.new(0, 12, 0, 12)
    closeIcon.Position = UDim2.new(0.5, -6, 0.5, -6)
    closeIcon.BackgroundTransparency = 1
    closeIcon.Image = ICONS.Close
    closeIcon.ImageColor3 = THEME.TextDim
    closeIcon.ZIndex = 404
    closeIcon.Parent = closeBtn

    local progressBg = Instance.new("Frame")
    progressBg.Size = UDim2.new(1, -16, 0, 3)
    progressBg.Position = UDim2.new(0, 8, 1, -7)
    progressBg.BackgroundColor3 = THEME.ToggleOff
    progressBg.BorderSizePixel = 0
    progressBg.ZIndex = 402
    progressBg.Parent = notif

    local progressBgCorner = Instance.new("UICorner")
    progressBgCorner.CornerRadius = UDim.new(1, 0)
    progressBgCorner.Parent = progressBg

    local progressFill = Instance.new("Frame")
    progressFill.Size = UDim2.new(1, 0, 1, 0)
    progressFill.BackgroundColor3 = THEME.Accent
    progressFill.BorderSizePixel = 0
    progressFill.ZIndex = 403
    progressFill.Parent = progressBg

    local progressFillCorner = Instance.new("UICorner")
    progressFillCorner.CornerRadius = UDim.new(1, 0)
    progressFillCorner.Parent = progressFill

    notif.BackgroundTransparency = 1
    notifStroke.Transparency = 1
    accentBar.BackgroundTransparency = 1
    iconHolder.BackgroundTransparency = 1
    iconHolderStroke.Transparency = 1
    icon.ImageTransparency = 1
    titleLabel.TextTransparency = 1
    descLabel.TextTransparency = 1
    closeIcon.ImageTransparency = 1
    progressBg.BackgroundTransparency = 1
    progressFill.BackgroundTransparency = 1

    notif.Position = UDim2.new(1, 0, 0, 0)

    TweenService:Create(notif, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()

    TweenService:Create(notif, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
    TweenService:Create(notifStroke, TweenInfo.new(0.3), {Transparency = 0}):Play()
    TweenService:Create(accentBar, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
    TweenService:Create(iconHolder, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
    TweenService:Create(iconHolderStroke, TweenInfo.new(0.3), {Transparency = 0}):Play()
    TweenService:Create(icon, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
    TweenService:Create(titleLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    TweenService:Create(descLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    TweenService:Create(closeIcon, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
    TweenService:Create(progressBg, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()

    closeBtn.MouseEnter:Connect(function()
        TweenService:Create(closeIcon, TWEEN_FAST, {ImageColor3 = THEME.Accent}):Play()
    end)
    closeBtn.MouseLeave:Connect(function()
        TweenService:Create(closeIcon, TWEEN_FAST, {ImageColor3 = THEME.TextDim}):Play()
    end)

    local finished = false
    local progressTween

    local function dismiss()
        if finished then return end
        finished = true
        if progressTween then progressTween:Cancel() end

        local closeTween = TweenService:Create(notif, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 30, 0, 0),
            BackgroundTransparency = 1
        })
        TweenService:Create(notifStroke, TweenInfo.new(0.35), {Transparency = 1}):Play()
        TweenService:Create(accentBar, TweenInfo.new(0.35), {BackgroundTransparency = 1}):Play()
        TweenService:Create(iconHolder, TweenInfo.new(0.35), {BackgroundTransparency = 1}):Play()
        TweenService:Create(iconHolderStroke, TweenInfo.new(0.35), {Transparency = 1}):Play()
        TweenService:Create(icon, TweenInfo.new(0.35), {ImageTransparency = 1}):Play()
        TweenService:Create(titleLabel, TweenInfo.new(0.35), {TextTransparency = 1}):Play()
        TweenService:Create(descLabel, TweenInfo.new(0.35), {TextTransparency = 1}):Play()
        TweenService:Create(closeIcon, TweenInfo.new(0.35), {ImageTransparency = 1}):Play()
        TweenService:Create(progressBg, TweenInfo.new(0.35), {BackgroundTransparency = 1}):Play()
        TweenService:Create(progressFill, TweenInfo.new(0.35), {BackgroundTransparency = 1}):Play()
        closeTween:Play()
        closeTween.Completed:Connect(function()
            if notif and notif.Parent then notif:Destroy() end
        end)
    end

    closeBtn.MouseButton1Click:Connect(dismiss)

    progressTween = TweenService:Create(progressFill, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 1, 0)
    })
    progressTween:Play()
    progressTween.Completed:Connect(dismiss)

    registerThemeObj(notif)
    for _, d in ipairs(notif:GetDescendants()) do
        registerThemeObj(d)
    end

    return notif
end

_G.NursultanNotify = notify

-- Aim Circle (до HUD и Main, но после ScreenGui)
local aimCircle = Instance.new("Frame")
aimCircle.Name = "AimCircle"
aimCircle.AnchorPoint = Vector2.new(0.5, 0.5)
aimCircle.Size = UDim2.new(0, 80, 0, 80)
aimCircle.BackgroundTransparency = 1
aimCircle.BorderSizePixel = 0
aimCircle.Visible = false
aimCircle.ZIndex = 100
aimCircle.Parent = ScreenGui

local aimCircleUIStroke = Instance.new("UIStroke")
aimCircleUIStroke.Color = THEME.Accent
aimCircleUIStroke.Thickness = 1.5
aimCircleUIStroke.Transparency = 0.2
aimCircleUIStroke.Parent = aimCircle

local aimCircleCorner = Instance.new("UICorner")
aimCircleCorner.CornerRadius = UDim.new(1, 0)
aimCircleCorner.Parent = aimCircle

local aimState = {
    Enabled = false,
    ShowCircle = true,
    TargetPart = "Head",
    TeamCheck = "Enemy",
    CircleSize = 80,
    Smoothness = 0.25,
    FOV = 150
}

-- HUD
local HudContainer = Instance.new("Frame")
HudContainer.Name = "HudContainer"
HudContainer.Size = UDim2.new(0, 600, 0, 50)
HudContainer.Position = UDim2.new(0, 16, 0, 84)
HudContainer.BackgroundTransparency = 1
HudContainer.Visible = false
HudContainer.Parent = ScreenGui

local HudVerticalLayout = Instance.new("UIListLayout")
HudVerticalLayout.SortOrder = Enum.SortOrder.LayoutOrder
HudVerticalLayout.Padding = UDim.new(0, 4)
HudVerticalLayout.Parent = HudContainer

local function createHudRow(name, height, order)
    local row = Instance.new("Frame")
    row.Name = name
    row.Size = UDim2.new(1, 0, 0, height)
    row.BackgroundTransparency = 1
    row.LayoutOrder = order
    row.Parent = HudContainer

    local hLayout = Instance.new("UIListLayout")
    hLayout.FillDirection = Enum.FillDirection.Horizontal
    hLayout.SortOrder = Enum.SortOrder.LayoutOrder
    hLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    hLayout.Padding = UDim.new(0, 5)
    hLayout.Parent = row

    return row
end

local TopHudRow = createHudRow("TopRow", 22, 1)
local BottomHudRow = createHudRow("BottomRow", 22, 2)

local function createHudPill(parent, order)
    local pill = Instance.new("Frame")
    pill.AutomaticSize = Enum.AutomaticSize.X
    pill.Size = UDim2.new(0, 0, 1, 0)
    pill.BackgroundColor3 = THEME.PillBg
    pill.BorderSizePixel = 0
    pill.LayoutOrder = order
    pill.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = pill

    local stroke = Instance.new("UIStroke")
    stroke.Color = THEME.Border
    stroke.Thickness = 1
    stroke.Parent = pill

    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 6)
    pad.PaddingRight = UDim.new(0, 6)
    pad.Parent = pill

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.Padding = UDim.new(0, 5)
    layout.Parent = pill

    return pill
end

local function addHudDivider(parent, order)
    local div = Instance.new("Frame")
    div.Size = UDim2.new(0, 1, 0, 10)
    div.BackgroundColor3 = THEME.Divider
    div.BorderSizePixel = 0
    div.LayoutOrder = order
    div.Parent = parent
end

local function addHudText(parent, text, isMuted, order)
    local lbl = Instance.new("TextLabel")
    lbl.AutomaticSize = Enum.AutomaticSize.X
    lbl.Size = UDim2.new(0, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 10.5
    lbl.TextColor3 = isMuted and THEME.TextMuted or THEME.TextPrimary
    lbl.LayoutOrder = order
    lbl.Parent = parent
    return lbl
end

local function addHudSmallIcon(parent, iconId, order)
    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 11, 0, 11)
    icon.BackgroundTransparency = 1
    icon.Image = iconId
    icon.ScaleType = Enum.ScaleType.Fit
    icon.ImageColor3 = THEME.Accent
    icon.LayoutOrder = order
    icon.Parent = parent
    return icon
end

local BrandPill = createHudPill(TopHudRow, 1)

local HudLogoWrap = Instance.new("Frame")
HudLogoWrap.Size = UDim2.new(0, 20, 0, 20)
HudLogoWrap.BackgroundTransparency = 1
HudLogoWrap.LayoutOrder = 1
HudLogoWrap.Parent = BrandPill

local HudBrandLogo = Instance.new("ImageLabel")
HudBrandLogo.Size = UDim2.new(1.35, 0, 1.35, 0)
HudBrandLogo.Position = UDim2.new(-0.175, 0, -0.175, 0)
HudBrandLogo.BackgroundTransparency = 1
HudBrandLogo.Image = CUSTOM_LOGO_ID
HudBrandLogo.ScaleType = Enum.ScaleType.Fit
HudBrandLogo.ImageColor3 = Color3.fromRGB(255, 255, 255)
HudBrandLogo.ZIndex = 2
HudBrandLogo.Parent = HudLogoWrap

local HudLogoGrad = Instance.new("UIGradient")
HudLogoGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, THEME.AccentSoft),
    ColorSequenceKeypoint.new(0.45, THEME.Accent),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(165, 32, 42))
})
HudLogoGrad.Rotation = -35
HudLogoGrad.Parent = HudBrandLogo

addHudDivider(BrandPill, 2)
local HudBrandText = addHudText(BrandPill, "nursultan", false, 3)

local HudBrandGrad = Instance.new("UIGradient")
HudBrandGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, THEME.AccentSoft),
    ColorSequenceKeypoint.new(1.0, THEME.Accent)
})
HudBrandGrad.Parent = HudBrandText

local StatsPill = createHudPill(TopHudRow, 2)
addHudSmallIcon(StatsPill, ICONS.User, 1)
local NameLabel = addHudText(StatsPill, string.lower(LocalPlayer.Name), false, 2)
_G.NursultanSetNameLabel = function(str) NameLabel.Text = str end
addHudDivider(StatsPill, 3)

addHudSmallIcon(StatsPill, ICONS.Chart, 4)
local FpsLabel = addHudText(StatsPill, "0 Fps", false, 5)
addHudDivider(StatsPill, 6)

addHudSmallIcon(StatsPill, ICONS.Clock, 7)
local TimeLabel = addHudText(StatsPill, "00:00:00", false, 8)

local PosPill = createHudPill(BottomHudRow, 1)
addHudSmallIcon(PosPill, ICONS.Compass, 1)
addHudDivider(PosPill, 2)
local PosLabel = addHudText(PosPill, "0, 0, 0", false, 3)

local PingPill = createHudPill(BottomHudRow, 2)
addHudSmallIcon(PingPill, ICONS.Signal, 1)
addHudDivider(PingPill, 2)
local PingLabel = addHudText(PingPill, "0 Ping", false, 3)

local TickPill = createHudPill(BottomHudRow, 3)
addHudSmallIcon(TickPill, ICONS.Radar, 1)
addHudDivider(TickPill, 2)
local TickLabel = addHudText(TickPill, "20.0 Ticks", false, 3)

local SpeedPill = createHudPill(BottomHudRow, 4)
addHudSmallIcon(SpeedPill, ICONS.Speed, 1)
addHudDivider(SpeedPill, 2)
local SpeedLabel = addHudText(SpeedPill, "0.0 Bps", false, 3)

do
    local hudDragging, hudDragStart, hudStartPos
    HudContainer.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            hudDragging = true
            hudDragStart = input.Position
            hudStartPos = HudContainer.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if hudDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - hudDragStart
            local newX = hudStartPos.X.Offset + delta.X
            local newY = hudStartPos.Y.Offset + delta.Y
            local camera = workspace.CurrentCamera
            local viewportSize = camera and camera.ViewportSize or Vector2.new(1920, 1080)
            local hudW = HudContainer.AbsoluteSize.X
            local hudH = HudContainer.AbsoluteSize.Y
            local maxX = math.max(0, viewportSize.X - hudW)
            local maxY = math.max(0, viewportSize.Y - hudH)
            newX = math.clamp(newX, 0, maxX)
            newY = math.clamp(newY, 0, maxY)
            HudContainer.Position = UDim2.new(0, newX, 0, newY)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            hudDragging = false
        end
    end)
end

local fpsCounter, lastFpsCheck = 0, os.clock()
local lastPosition = Vector3.zero
local lastPosTime = os.clock()

local function getPing()
    local ok, value = pcall(function()
        return Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
    end)
    if ok and typeof(value) == "number" then
        return math.floor(value)
    end
    return 0
end

RunService.RenderStepped:Connect(function()
    fpsCounter = fpsCounter + 1
    local now = os.clock()
    if now - lastFpsCheck >= 1 then
        FpsLabel.Text = string.format("%d Fps", fpsCounter)
        fpsCounter = 0
        lastFpsCheck = now
    end
    TimeLabel.Text = os.date("%H:%M:%S")
    PingLabel.Text = string.format("%d Ping", getPing())

    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        local currentPos = hrp.Position
        PosLabel.Text = string.format("%d, %d, %d", math.floor(currentPos.X), math.floor(currentPos.Y), math.floor(currentPos.Z))
        local deltaTime = now - lastPosTime
        if deltaTime >= 0.1 then
            local dist = (Vector3.new(currentPos.X, 0, currentPos.Z) - Vector3.new(lastPosition.X, 0, lastPosition.Z)).Magnitude
            local bps = dist / deltaTime
            SpeedLabel.Text = string.format("%.1f Bps", bps)
            lastPosition = currentPos
            lastPosTime = now
        end
    else
        PosLabel.Text = "0, 0, 0"
        SpeedLabel.Text = "0.0 Bps"
    end
end)

-- NoName state
local NoNameEnabled = false
task.spawn(function()
    local tick = 0
    while ScreenGui.Parent do
        if NoNameEnabled then
            tick = tick + 1
            local c = (tick % 5) + 1
            if _G.NursultanSetNameLabel then
                _G.NursultanSetNameLabel(string.rep("?", c))
            end
        end
        task.wait(0.35)
    end
end)

-- Main
local Main = Instance.new("Frame")
Main.Name = "MainFrame"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Size = UDim2.new(0, 790, 0, 490)
Main.Position = UDim2.new(0.5, 0, 0.5, 18)
Main.BackgroundColor3 = THEME.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = false
Main.Visible = false
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = THEME.Border
MainStroke.Thickness = 1.2
MainStroke.Parent = Main

local mainTargetSize = UDim2.new(0, 790, 0, 490)
local mainHiddenSize = UDim2.new(0, 790, 0, 0)

local isAnimating = false
local isOpen = true

local function closeUI()
    if isAnimating or not isOpen then return end
    isAnimating = true
    isOpen = false
    if closeActiveDropdown then closeActiveDropdown() end
    if _G.NursultanHideTooltip then _G.NursultanHideTooltip() end

    Main.ClipsDescendants = true
    MainStroke.Transparency = 1

    local tween = TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = mainHiddenSize,
        BackgroundTransparency = 1
    })
    tween:Play()
    tween.Completed:Connect(function()
        Main.Visible = false
        Main.Size = mainTargetSize
        Main.BackgroundTransparency = 0
        MainStroke.Transparency = 0
        Main.ClipsDescendants = false
        isAnimating = false
    end)
end

local function openUI()
    if isAnimating or isOpen then return end
    isAnimating = true
    isOpen = true

    Main.Visible = true
    Main.ClipsDescendants = true
    Main.Size = mainHiddenSize
    Main.BackgroundTransparency = 1
    MainStroke.Transparency = 1

    local tween = TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = mainTargetSize,
        BackgroundTransparency = 0
    })
    tween:Play()
    tween.Completed:Connect(function()
        Main.BackgroundTransparency = 0
        MainStroke.Transparency = 0
        Main.ClipsDescendants = false
        isAnimating = false
    end)
end

do
    local dragging, dragStart, startPos
    Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 56)
TopBar.BackgroundTransparency = 1
TopBar.Parent = Main

local MainLogoHolder = Instance.new("Frame")
MainLogoHolder.Name = "LogoHolder"
MainLogoHolder.Size = UDim2.new(0, 64, 0, 64)
MainLogoHolder.Position = UDim2.new(0, 52, 0, -4)
MainLogoHolder.BackgroundTransparency = 1
MainLogoHolder.Parent = TopBar

local MainLogoImg = Instance.new("ImageLabel")
MainLogoImg.Name = "LogoMain"
MainLogoImg.Size = UDim2.new(1, 0, 1, 0)
MainLogoImg.Position = UDim2.new(0, 0, 0, 0)
MainLogoImg.BackgroundTransparency = 1
MainLogoImg.Image = CUSTOM_LOGO_ID
MainLogoImg.ScaleType = Enum.ScaleType.Fit
MainLogoImg.ImageColor3 = Color3.fromRGB(255, 255, 255)
MainLogoImg.ZIndex = 3
MainLogoImg.Parent = MainLogoHolder

local MainLogoGrad = Instance.new("UIGradient")
MainLogoGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 175, 165)),
    ColorSequenceKeypoint.new(0.45, Color3.fromRGB(246, 92, 82)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(165, 32, 42))
})
MainLogoGrad.Rotation = -35
MainLogoGrad.Parent = MainLogoImg

task.spawn(function()
    local offset = 0
    while ScreenGui.Parent do
        offset = (offset + 0.004) % 1
        if MainLogoGrad and MainLogoGrad.Parent then
            MainLogoGrad.Offset = Vector2.new(offset, 0)
        end
        if HudLogoGrad and HudLogoGrad.Parent then
            HudLogoGrad.Offset = Vector2.new(offset, 0)
        end
        task.wait(0.03)
    end
end)

local SidebarToggleBtn = Instance.new("ImageButton")
SidebarToggleBtn.Size = UDim2.new(0, 18, 0, 18)
SidebarToggleBtn.Position = UDim2.new(0, 18, 0.5, -9)
SidebarToggleBtn.BackgroundTransparency = 1
SidebarToggleBtn.Image = ICONS.Menu
SidebarToggleBtn.ImageColor3 = THEME.TextMuted
SidebarToggleBtn.Parent = TopBar

SidebarToggleBtn.MouseEnter:Connect(function()
    TweenService:Create(SidebarToggleBtn, TWEEN_FAST, {ImageColor3 = THEME.TextPrimary}):Play()
end)
SidebarToggleBtn.MouseLeave:Connect(function()
    TweenService:Create(SidebarToggleBtn, TWEEN_FAST, {ImageColor3 = THEME.TextMuted}):Play()
end)

local SearchBox = Instance.new("Frame")
SearchBox.Size = UDim2.new(0, 250, 0, 26)
SearchBox.Position = UDim2.new(0, 185, 0, 15)
SearchBox.BackgroundColor3 = THEME.CardBg
SearchBox.BorderSizePixel = 0
SearchBox.Parent = TopBar

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 6)
SearchCorner.Parent = SearchBox

local SearchStroke = Instance.new("UIStroke")
SearchStroke.Color = THEME.Border
SearchStroke.Thickness = 0.8
SearchStroke.Parent = SearchBox

local SearchIcon = Instance.new("ImageLabel")
SearchIcon.Size = UDim2.new(0, 13, 0, 13)
SearchIcon.Position = UDim2.new(0, 9, 0.5, -6.5)
SearchIcon.BackgroundTransparency = 1
SearchIcon.Image = ICONS.Search
SearchIcon.ImageColor3 = THEME.TextMuted
SearchIcon.Parent = SearchBox

local SearchInput = Instance.new("TextBox")
SearchInput.Text = ""
SearchInput.PlaceholderText = "Search something"
SearchInput.PlaceholderColor3 = THEME.TextMuted
SearchInput.TextColor3 = THEME.TextPrimary
SearchInput.Font = Enum.Font.Gotham
SearchInput.TextSize = 11
SearchInput.Position = UDim2.new(0, 30, 0, 0)
SearchInput.Size = UDim2.new(1, -36, 1, 0)
SearchInput.BackgroundTransparency = 1
SearchInput.TextXAlignment = Enum.TextXAlignment.Left
SearchInput.ClearTextOnFocus = false
SearchInput.Parent = SearchBox

local MenuBtn = Instance.new("ImageButton")
MenuBtn.Size = UDim2.new(0, 17, 0, 17)
MenuBtn.Position = UDim2.new(1, -32, 0.5, -8.5)
MenuBtn.BackgroundTransparency = 1
MenuBtn.Image = ICONS.Menu
MenuBtn.ImageColor3 = THEME.TextMuted
MenuBtn.Parent = TopBar

MenuBtn.MouseEnter:Connect(function()
    TweenService:Create(MenuBtn, TWEEN_FAST, {ImageColor3 = THEME.TextPrimary}):Play()
end)
MenuBtn.MouseLeave:Connect(function()
    TweenService:Create(MenuBtn, TWEEN_FAST, {ImageColor3 = THEME.TextMuted}):Play()
end)

-- Close button (opens unload confirm)
local CloseBtn = Instance.new("ImageButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 15, 0, 15)
CloseBtn.Position = UDim2.new(1, -56, 0.5, -7.5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Image = ICONS.Close
CloseBtn.ImageColor3 = THEME.TextMuted
CloseBtn.Parent = TopBar

CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TWEEN_FAST, {ImageColor3 = THEME.Accent}):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TWEEN_FAST, {ImageColor3 = THEME.TextMuted}):Play()
end)

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 155, 1, -58)
Sidebar.Position = UDim2.new(0, 14, 0, 54)
Sidebar.BackgroundTransparency = 1
Sidebar.ClipsDescendants = true
Sidebar.Parent = Main

local SideList = Instance.new("UIListLayout")
SideList.Padding = UDim.new(0, 2)
SideList.SortOrder = Enum.SortOrder.LayoutOrder
SideList.Parent = Sidebar

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -195, 1, -62)
ContentArea.Position = UDim2.new(0, 182, 0, 54)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = Main

local sidebarOpen = true

SidebarToggleBtn.MouseButton1Click:Connect(function()
    sidebarOpen = not sidebarOpen
    local targetWidth = sidebarOpen and 155 or 0
    local targetContentX = sidebarOpen and 182 or 14

    TweenService:Create(Sidebar, TWEEN_SLOW, {
        Size = UDim2.new(0, targetWidth, 1, -58)
    }):Play()

    TweenService:Create(ContentArea, TWEEN_SLOW, {
        Size = UDim2.new(1, sidebarOpen and -195 or -30, 1, -62),
        Position = UDim2.new(0, targetContentX, 0, 54)
    }):Play()
end)

local activeSidebarTab = nil
local sidebarItems = {}

local function addCategory(name, order)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 16)
    lbl.LayoutOrder = order
    lbl.BackgroundTransparency = 1
    lbl.Text = "   " .. name:upper()
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 9
    lbl.TextColor3 = THEME.TextDim
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = Sidebar
end

local TABS = {}
local activeTabName = nil

local function createTabPage(name)
    local page = Instance.new("Frame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = ContentArea

    local Col1 = Instance.new("ScrollingFrame")
    Col1.Size = UDim2.new(0.485, 0, 1, 0)
    Col1.BackgroundTransparency = 1
    Col1.ScrollBarThickness = 0
    Col1.CanvasSize = UDim2.new(0, 0, 0, 0)
    Col1.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Col1.Parent = page

    local Col2 = Instance.new("ScrollingFrame")
    Col2.Size = UDim2.new(0.485, 0, 1, 0)
    Col2.Position = UDim2.new(0.515, 0, 0, 0)
    Col2.BackgroundTransparency = 1
    Col2.ScrollBarThickness = 0
    Col2.CanvasSize = UDim2.new(0, 0, 0, 0)
    Col2.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Col2.Parent = page

    for _, col in ipairs({Col1, Col2}) do
        local l = Instance.new("UIListLayout")
        l.Padding = UDim.new(0, 12)
        l.SortOrder = Enum.SortOrder.LayoutOrder
        l.Parent = col
    end

    TABS[name] = {Page = page, Col1 = Col1, Col2 = Col2}
    return TABS[name]
end

local function showTab(name)
    for tabName, tabData in pairs(TABS) do
        tabData.Page.Visible = (tabName == name)
    end
    activeTabName = name

    for _, item in ipairs(sidebarItems) do
        if item.Name == name then
            if activeSidebarTab and activeSidebarTab.Btn ~= item.Btn then
                TweenService:Create(activeSidebarTab.Btn, TWEEN_FAST, {BackgroundTransparency = 1}):Play()
                TweenService:Create(activeSidebarTab.Stroke, TWEEN_FAST, {Transparency = 1}):Play()
                TweenService:Create(activeSidebarTab.Icon, TWEEN_FAST, {ImageColor3 = THEME.TextMuted}):Play()
                TweenService:Create(activeSidebarTab.Title, TWEEN_FAST, {TextColor3 = THEME.TextMuted}):Play()
            end
            TweenService:Create(item.Btn, TWEEN_FAST, {BackgroundTransparency = 0, BackgroundColor3 = THEME.SidebarActive}):Play()
            TweenService:Create(item.Stroke, TWEEN_FAST, {Transparency = 0, Color = THEME.BorderActive}):Play()
            TweenService:Create(item.Icon, TWEEN_FAST, {ImageColor3 = THEME.Accent}):Play()
            TweenService:Create(item.Title, TWEEN_FAST, {TextColor3 = THEME.TextPrimary}):Play()
            activeSidebarTab = {Btn = item.Btn, Icon = item.Icon, Title = item.Title, Stroke = item.Stroke}
        end
    end
end

local function addSidebarItem(name, iconId, isDefaultActive, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -4, 0, 25)
    btn.LayoutOrder = order
    btn.BackgroundColor3 = isDefaultActive and THEME.SidebarActive or THEME.Background
    btn.BackgroundTransparency = isDefaultActive and 0 or 1
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = Sidebar

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = isDefaultActive and THEME.BorderActive or Color3.fromRGB(0, 0, 0)
    stroke.Transparency = isDefaultActive and 0 or 1
    stroke.Thickness = 1
    stroke.Parent = btn

    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 13, 0, 13)
    icon.Position = UDim2.new(0, 8, 0.5, -6.5)
    icon.BackgroundTransparency = 1
    icon.Image = iconId
    icon.ImageColor3 = isDefaultActive and THEME.Accent or THEME.TextMuted
    icon.Parent = btn

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -30, 1, 0)
    title.Position = UDim2.new(0, 28, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = name
    title.Font = Enum.Font.GothamMedium
    title.TextSize = 11
    title.TextColor3 = isDefaultActive and THEME.TextPrimary or THEME.TextMuted
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = btn

    local itemData = {Name = name, Btn = btn, Icon = icon, Title = title, Stroke = stroke}
    table.insert(sidebarItems, itemData)

    if isDefaultActive then
        activeSidebarTab = itemData
    end

    btn.MouseEnter:Connect(function()
        if not activeSidebarTab or activeSidebarTab.Btn ~= btn then
            TweenService:Create(title, TWEEN_FAST, {TextColor3 = THEME.TextPrimary}):Play()
            TweenService:Create(icon, TWEEN_FAST, {ImageColor3 = THEME.TextPrimary}):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        if not activeSidebarTab or activeSidebarTab.Btn ~= btn then
            TweenService:Create(title, TWEEN_FAST, {TextColor3 = THEME.TextMuted}):Play()
            TweenService:Create(icon, TWEEN_FAST, {ImageColor3 = THEME.TextMuted}):Play()
        end
    end)

    btn.MouseButton1Click:Connect(function()
        showTab(name)
    end)

    attachRipple(btn)
end

addCategory("Features", 1)
addSidebarItem("Combat", ICONS.Combat, true, 2)
addSidebarItem("Movement", ICONS.Movement, false, 3)
addSidebarItem("Visuals", ICONS.Visuals, false, 4)
addSidebarItem("Player", ICONS.Player, false, 5)
addSidebarItem("Misc", ICONS.Misc, false, 6)

addCategory("Manager", 7)
addSidebarItem("Keybinds", ICONS.Keybinds, false, 8)
addSidebarItem("Presets", ICONS.Presets, false, 9)
addSidebarItem("Auto Buy", ICONS.AutoBuy, false, 10)
addSidebarItem("Account", ICONS.Accounts, false, 11)
addSidebarItem("Settings", ICONS.Settings, false, 12)

local Footer = Instance.new("Frame")
Footer.Size = UDim2.new(0, 170, 0, 34)
Footer.Position = UDim2.new(0, 16, 1, -46)
Footer.BackgroundTransparency = 1
Footer.Parent = Main

local AvatarHolder = Instance.new("Frame")
AvatarHolder.Size = UDim2.new(0, 26, 0, 26)
AvatarHolder.Position = UDim2.new(0, 0, 0.5, -13)
AvatarHolder.BackgroundColor3 = THEME.PillBg
AvatarHolder.BorderSizePixel = 0
AvatarHolder.Parent = Footer

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = AvatarHolder

local AvatarStroke = Instance.new("UIStroke")
AvatarStroke.Color = THEME.Border
AvatarStroke.Thickness = 1
AvatarStroke.Parent = AvatarHolder

local AvatarImg = Instance.new("ImageLabel")
AvatarImg.Size = UDim2.new(1, -2, 1, -2)
AvatarImg.Position = UDim2.new(0, 1, 0, 1)
AvatarImg.BackgroundTransparency = 1
AvatarImg.Image = ""
AvatarImg.ScaleType = Enum.ScaleType.Crop
AvatarImg.Parent = AvatarHolder

local AvatarImgCorner = Instance.new("UICorner")
AvatarImgCorner.CornerRadius = UDim.new(1, 0)
AvatarImgCorner.Parent = AvatarImg

task.spawn(function()
    local ok, thumb = pcall(function()
        return Players:GetUserThumbnailAsync(
            LocalPlayer.UserId,
            Enum.ThumbnailType.HeadShot,
            Enum.ThumbnailSize.Size100x100
        )
    end)
    if ok and thumb then
        AvatarImg.Image = thumb
    end
end)

local UserLabel = Instance.new("TextLabel")
UserLabel.Size = UDim2.new(1, -34, 0, 14)
UserLabel.Position = UDim2.new(0, 34, 0, 3)
UserLabel.BackgroundTransparency = 1
UserLabel.Text = LocalPlayer.DisplayName
UserLabel.Font = Enum.Font.GothamBold
UserLabel.TextSize = 10
UserLabel.TextColor3 = THEME.TextPrimary
UserLabel.TextXAlignment = Enum.TextXAlignment.Left
UserLabel.Parent = Footer

local SubLabel = Instance.new("TextLabel")
SubLabel.Size = UDim2.new(1, -34, 0, 11)
SubLabel.Position = UDim2.new(0, 34, 0, 17)
SubLabel.BackgroundTransparency = 1
SubLabel.Text = "nursultan ui"
SubLabel.Font = Enum.Font.Gotham
SubLabel.TextSize = 8
SubLabel.TextColor3 = THEME.TextDim
SubLabel.TextXAlignment = Enum.TextXAlignment.Left
SubLabel.Parent = Footer

local function applyHover(card, stroke)
    card.MouseEnter:Connect(function()
        TweenService:Create(card, TWEEN_FAST, {BackgroundColor3 = THEME.CardHover}):Play()
        TweenService:Create(stroke, TWEEN_FAST, {Color = THEME.BorderActive, Thickness = 1.1}):Play()
    end)
    card.MouseLeave:Connect(function()
        TweenService:Create(card, TWEEN_FAST, {BackgroundColor3 = THEME.CardBg}):Play()
        TweenService:Create(stroke, TWEEN_FAST, {Color = THEME.Border, Thickness = 0.8}):Play()
    end)
end

local function createCard(parent, titleText, order)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 0)
    card.AutomaticSize = Enum.AutomaticSize.Y
    card.BackgroundColor3 = THEME.CardBg
    card.BorderSizePixel = 0
    card.LayoutOrder = order
    card.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = card

    local s = Instance.new("UIStroke")
    s.Color = THEME.Border
    s.Thickness = 0.8
    s.Parent = card

    local p = Instance.new("UIPadding")
    p.PaddingTop = UDim.new(0, 11)
    p.PaddingBottom = UDim.new(0, 13)
    p.PaddingLeft = UDim.new(0, 12)
    p.PaddingRight = UDim.new(0, 12)
    p.Parent = card

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 10)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = card

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 18)
    header.BackgroundTransparency = 1
    header.LayoutOrder = 0
    header.Parent = card

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 1, 0)
    title.BackgroundTransparency = 1
    title.Text = titleText
    title.Font = Enum.Font.GothamBold
    title.TextSize = 12
    title.TextColor3 = THEME.TextPrimary
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header

    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 12, 0, 12)
    icon.Position = UDim2.new(1, -12, 0.5, -6)
    icon.BackgroundTransparency = 1
    icon.Image = ICONS.Chevron
    icon.ImageColor3 = THEME.Accent
    icon.Parent = header

    applyHover(card, s)

    return card
end

local function createInfoRow(parent, label, value, order)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 16)
    row.BackgroundTransparency = 1
    row.LayoutOrder = order
    row.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.5, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 10
    lbl.TextColor3 = THEME.TextMuted
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local val = Instance.new("TextLabel")
    val.Size = UDim2.new(0.5, 0, 1, 0)
    val.Position = UDim2.new(0.5, 0, 0, 0)
    val.BackgroundTransparency = 1
    val.Text = tostring(value)
    val.Font = Enum.Font.GothamBold
    val.TextSize = 10
    val.TextColor3 = THEME.TextPrimary
    val.TextXAlignment = Enum.TextXAlignment.Right
    val.TextTruncate = Enum.TextTruncate.AtEnd
    val.Parent = row

    return val
end

local function createBigAvatar(parent, size, order)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(0, size, 0, size)
    holder.BackgroundColor3 = THEME.PillBg
    holder.BorderSizePixel = 0
    holder.LayoutOrder = order
    holder.Parent = parent

    local holderCorner = Instance.new("UICorner")
    holderCorner.CornerRadius = UDim.new(1, 0)
    holderCorner.Parent = holder

    local holderStroke = Instance.new("UIStroke")
    holderStroke.Color = THEME.BorderActive
    holderStroke.Thickness = 1.5
    holderStroke.Parent = holder

    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(1, -4, 1, -4)
    img.Position = UDim2.new(0, 2, 0, 2)
    img.BackgroundTransparency = 1
    img.Image = ""
    img.ScaleType = Enum.ScaleType.Crop
    img.Parent = holder

    local imgCorner = Instance.new("UICorner")
    imgCorner.CornerRadius = UDim.new(1, 0)
    imgCorner.Parent = img

    return img
end

local ActiveDropdown = nil
local KeybindListening = nil
local KeybindTarget = nil
local keybindListRefresh = nil

function closeActiveDropdown()
    if ActiveDropdown then
        ActiveDropdown:Destroy()
        ActiveDropdown = nil
    end
end

local function openKeybindModal(targetBadge, toggleObj)
    if KeybindListening then
        KeybindListening:Disconnect()
        KeybindListening = nil
    end

    if KeybindTarget and KeybindTarget.Badge and KeybindTarget.Badge.Text == "..." then
        KeybindTarget.Badge.Text = KeybindTarget.PrevText or "-"
        KeybindTarget.Badge.TextColor3 = THEME.TextMuted
    end

    KeybindTarget = {Badge = targetBadge, PrevText = targetBadge.Text, Toggle = toggleObj}

    targetBadge.Text = "..."
    targetBadge.TextColor3 = THEME.Accent

    KeybindListening = UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local keyName = input.KeyCode.Name
            if keyName == "Escape" then
                targetBadge.Text = "-"
                if toggleObj then
                    toggleObj.Keybind = nil
                    toggleObj.KeyCode = nil
                end
            else
                targetBadge.Text = keyName
                if toggleObj then
                    toggleObj.Keybind = keyName
                    toggleObj.KeyCode = input.KeyCode
                end
            end
            targetBadge.TextColor3 = THEME.TextMuted
            if KeybindListening then
                KeybindListening:Disconnect()
                KeybindListening = nil
            end
            KeybindTarget = nil
            if keybindListRefresh then keybindListRefresh() end
        end
    end)
end

local function toggleDropdown(parentRow, badgeLabel, toggleObj)
    if ActiveDropdown then
        ActiveDropdown:Destroy()
        ActiveDropdown = nil
        return
    end

    local drop = Instance.new("Frame")
    drop.Name = "Dropdown"
    drop.Size = UDim2.new(0, 115, 0, 58)
    drop.Position = UDim2.new(1, -120, 1, 3)
    drop.BackgroundColor3 = THEME.CardBg
    drop.ZIndex = 30
    drop.Parent = parentRow

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = drop

    local s = Instance.new("UIStroke")
    s.Color = THEME.Border
    s.Thickness = 1
    s.Parent = drop

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 1)
    list.Parent = drop

    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 3)
    pad.PaddingBottom = UDim.new(0, 3)
    pad.PaddingLeft = UDim.new(0, 5)
    pad.PaddingRight = UDim.new(0, 5)
    pad.Parent = drop

    local function addOption(name, onClick)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 24)
        btn.BackgroundTransparency = 1
        btn.Text = " " .. name
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 10.5
        btn.TextColor3 = THEME.TextPrimary
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.ZIndex = 31
        btn.Parent = drop

        btn.MouseEnter:Connect(function() btn.TextColor3 = THEME.Accent end)
        btn.MouseLeave:Connect(function() btn.TextColor3 = THEME.TextPrimary end)
        btn.MouseButton1Click:Connect(function()
            drop:Destroy()
            ActiveDropdown = nil
            if onClick then onClick() end
        end)
    end

    addOption("Bind Key", function()
        openKeybindModal(badgeLabel, toggleObj)
    end)
    addOption("Reset Value", function()
        badgeLabel.Text = "-"
        if toggleObj then
            toggleObj.Keybind = nil
            toggleObj.KeyCode = nil
        end
        if keybindListRefresh then keybindListRefresh() end
    end)

    ActiveDropdown = drop
    registerThemeObj(drop)
    for _, d in ipairs(drop:GetDescendants()) do
        registerThemeObj(d)
    end
end

local registeredRows = {}
local allToggles = {}

local function addToggle(card, name, description, defaultState, keybindDefault, callback)
    local row = Instance.new("Frame")
    row.Name = name
    row.Size = UDim2.new(1, 0, 0, 21)
    row.BackgroundTransparency = 1
    row.Parent = card

    local entry = {Frame = row, Name = name:lower(), DisplayName = name}
    table.insert(registeredRows, entry)

    local accentBar = Instance.new("Frame")
    accentBar.Name = name .. "_AccentBar"
    accentBar.Size = UDim2.new(0, 2, 1, -4)
    accentBar.Position = UDim2.new(0, -12, 0, 2)
    accentBar.BackgroundColor3 = THEME.Accent
    accentBar.BorderSizePixel = 0
    accentBar.BackgroundTransparency = 1
    accentBar.Parent = row

    local accentBarCorner = Instance.new("UICorner")
    accentBarCorner.CornerRadius = UDim.new(1, 0)
    accentBarCorner.Parent = accentBar

    local textContainer = Instance.new("Frame")
    textContainer.Size = UDim2.new(1, -80, 1, 0)
    textContainer.BackgroundTransparency = 1
    textContainer.Parent = row

    local rowTitle = Instance.new("TextLabel")
    rowTitle.Size = UDim2.new(1, 0, 1, 0)
    rowTitle.BackgroundTransparency = 1
    rowTitle.Text = name
    rowTitle.Font = Enum.Font.GothamMedium
    rowTitle.TextSize = 11
    rowTitle.TextColor3 = THEME.TextPrimary
    rowTitle.TextXAlignment = Enum.TextXAlignment.Left
    rowTitle.Parent = textContainer

    local badge = Instance.new("TextLabel")
    badge.Size = UDim2.new(0, 18, 0, 14)
    badge.Position = UDim2.new(1, -92, 0.5, -7)
    badge.BackgroundColor3 = THEME.BadgeBg
    badge.Text = keybindDefault or ""
    badge.Visible = (keybindDefault ~= nil)
    badge.Font = Enum.Font.GothamBold
    badge.TextSize = 8.5
    badge.TextColor3 = THEME.TextMuted
    badge.Parent = row

    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 3)
    bc.Parent = badge

    local bs = Instance.new("UIStroke")
    bs.Color = THEME.Border
    bs.Thickness = 0.8
    bs.Parent = badge

    local favBtn = Instance.new("TextButton")
    favBtn.Name = "FavBtn"
    favBtn.Size = UDim2.new(0, 14, 0, 14)
    favBtn.Position = UDim2.new(1, -72, 0.5, -7)
    favBtn.BackgroundTransparency = 1
    favBtn.Text = isFavorite(name) and "★" or "☆"
    favBtn.Font = Enum.Font.GothamBold
    favBtn.TextSize = 14
    favBtn.TextColor3 = isFavorite(name) and THEME.Accent or THEME.TextDim
    favBtn.AutoButtonColor = false
    favBtn.Parent = row

    favBtn.MouseEnter:Connect(function()
        if not isFavorite(name) then
            TweenService:Create(favBtn, TWEEN_FAST, {TextColor3 = THEME.Accent}):Play()
        end
    end)
    favBtn.MouseLeave:Connect(function()
        if not isFavorite(name) then
            TweenService:Create(favBtn, TWEEN_FAST, {TextColor3 = THEME.TextDim}):Play()
        end
    end)
    favBtn.MouseButton1Click:Connect(function()
        toggleFavorite(name)
        if isFavorite(name) then
            favBtn.Text = "★"
            favBtn.TextColor3 = THEME.Accent
            notify("Favorites", name .. " added", 2)
        else
            favBtn.Text = "☆"
            favBtn.TextColor3 = THEME.TextDim
            notify("Favorites", name .. " removed", 2)
        end
    end)

    local optBtn = Instance.new("ImageButton")
    optBtn.Size = UDim2.new(0, 13, 0, 13)
    optBtn.Position = UDim2.new(1, -52, 0.5, -6.5)
    optBtn.BackgroundTransparency = 1
    optBtn.Image = ICONS.More
    optBtn.ImageColor3 = THEME.TextDim
    optBtn.Parent = row

    optBtn.MouseEnter:Connect(function()
        TweenService:Create(optBtn, TWEEN_FAST, {ImageColor3 = THEME.TextPrimary}):Play()
    end)
    optBtn.MouseLeave:Connect(function()
        TweenService:Create(optBtn, TWEEN_FAST, {ImageColor3 = THEME.TextDim}):Play()
    end)

    local helpBtn = Instance.new("TextButton")
    helpBtn.Size = UDim2.new(0, 14, 0, 14)
    helpBtn.Position = UDim2.new(1, -36, 0.5, -7)
    helpBtn.BackgroundTransparency = 1
    helpBtn.Text = "?"
    helpBtn.Font = Enum.Font.GothamBold
    helpBtn.TextSize = 11
    helpBtn.TextColor3 = THEME.TextDim
    helpBtn.AutoButtonColor = false
    helpBtn.Parent = row

    local helpText = description or (name .. " — toggles this feature")

    helpBtn.MouseEnter:Connect(function()
        TweenService:Create(helpBtn, TWEEN_FAST, {TextColor3 = THEME.Accent}):Play()
        showTooltip(helpText, helpBtn)
    end)
    helpBtn.MouseLeave:Connect(function()
        TweenService:Create(helpBtn, TWEEN_FAST, {TextColor3 = THEME.TextDim}):Play()
        hideTooltip()
    end)

    local switch = Instance.new("TextButton")
    switch.Size = UDim2.new(0, 32, 0, 16)
    switch.Position = UDim2.new(1, -16, 0.5, -8)
    switch.BackgroundColor3 = defaultState and THEME.Accent or THEME.ToggleOff
    switch.Text = ""
    switch.AutoButtonColor = false
    switch.Parent = row

    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(1, 0)
    sCorner.Parent = switch

    local knob = Instance.new("Frame")
    knob.Name = "Knob"
    knob.Size = UDim2.new(0, 12, 0, 12)
    knob.Position = defaultState and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
    knob.BackgroundColor3 = defaultState and THEME.KnobOn or THEME.KnobOff
    knob.BorderSizePixel = 0
    knob.Parent = switch

    local kCorner = Instance.new("UICorner")
    kCorner.CornerRadius = UDim.new(1, 0)
    kCorner.Parent = knob

    local toggleObj = {
        Name = name,
        IsToggled = defaultState,
        DefaultState = defaultState,
        Keybind = keybindDefault,
        DefaultKeybind = keybindDefault,
        KeyCode = nil,
        Badge = badge,
        Switch = switch,
        Knob = knob,
        AccentBar = accentBar,
        Callback = callback,
        PulseTween = nil,
        FavBtn = favBtn
    }

    if keybindDefault then
        local ok, code = pcall(function()
            return Enum.KeyCode[keybindDefault]
        end)
        if ok then toggleObj.KeyCode = code end
    end

    local function stopPulse()
        if toggleObj.PulseTween then
            toggleObj.PulseTween:Cancel()
            toggleObj.PulseTween = nil
        end
        accentBar.BackgroundTransparency = 1
    end

    local function startPulse()
        stopPulse()
        accentBar.BackgroundColor3 = THEME.Accent
        accentBar.BackgroundTransparency = 0
        toggleObj.PulseTween = TweenService:Create(accentBar, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            BackgroundTransparency = 0.55
        })
        toggleObj.PulseTween:Play()
    end

    local function setToggle(state, fromKeybind)
        if toggleObj.IsToggled == state then return end
        toggleObj.IsToggled = state
        local targetColor = state and THEME.Accent or THEME.ToggleOff
        local targetKnobColor = state and THEME.KnobOn or THEME.KnobOff
        local targetPos = state and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)

        TweenService:Create(switch, TWEEN_FAST, {BackgroundColor3 = targetColor}):Play()
        TweenService:Create(knob, TWEEN_FAST, {BackgroundColor3 = targetKnobColor, Position = targetPos}):Play()

        if state then
            startPulse()
        else
            stopPulse()
        end

        if callback then
            callback(state, fromKeybind)
        end
    end

    toggleObj.SetToggle = setToggle
    toggleObj.StartPulse = startPulse
    toggleObj.StopPulse = stopPulse
    entry.Toggle = toggleObj
    table.insert(allToggles, toggleObj)

    if defaultState then
        startPulse()
    end

    switch.MouseButton1Click:Connect(function()
        setToggle(not toggleObj.IsToggled, false)
    end)

    optBtn.MouseButton1Click:Connect(function()
        badge.Visible = true
        toggleDropdown(row, badge, toggleObj)
    end)

    attachRipple(switch)

    return toggleObj
end

local function createButton(parent, name, description, order, onClick)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, 0, 0, description and 30 or 21)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.LayoutOrder = order
    btn.Parent = parent

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 14)
    title.BackgroundTransparency = 1
    title.Text = name
    title.Font = Enum.Font.GothamMedium
    title.TextSize = 11
    title.TextColor3 = THEME.TextPrimary
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = btn

    if description then
        local desc = Instance.new("TextLabel")
        desc.Size = UDim2.new(1, 0, 0, 12)
        desc.Position = UDim2.new(0, 0, 0, 14)
        desc.BackgroundTransparency = 1
        desc.Text = description
        desc.Font = Enum.Font.Gotham
        desc.TextSize = 9
        desc.TextColor3 = THEME.TextMuted
        desc.TextXAlignment = Enum.TextXAlignment.Left
        desc.Parent = btn
    end

    local chev = Instance.new("ImageLabel")
    chev.Size = UDim2.new(0, 12, 0, 12)
    chev.Position = UDim2.new(1, -12, 0.5, -6)
    chev.BackgroundTransparency = 1
    chev.Image = ICONS.Chevron
    chev.ImageColor3 = THEME.TextDim
    chev.Parent = btn

    btn.MouseEnter:Connect(function()
        TweenService:Create(title, TWEEN_FAST, {TextColor3 = THEME.Accent}):Play()
        TweenService:Create(chev, TWEEN_FAST, {ImageColor3 = THEME.Accent}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(title, TWEEN_FAST, {TextColor3 = THEME.TextPrimary}):Play()
        TweenService:Create(chev, TWEEN_FAST, {ImageColor3 = THEME.TextDim}):Play()
    end)
    btn.MouseButton1Click:Connect(function()
        if onClick then onClick() end
    end)

    attachRipple(btn)

    return btn
end

local function createSlider(parent, name, minVal, maxVal, defaultVal, order, callback)
    local row = Instance.new("Frame")
    row.Name = name
    row.Size = UDim2.new(1, 0, 0, 34)
    row.BackgroundTransparency = 1
    row.LayoutOrder = order
    row.Parent = parent

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -50, 0, 14)
    title.BackgroundTransparency = 1
    title.Text = name
    title.Font = Enum.Font.GothamMedium
    title.TextSize = 11
    title.TextColor3 = THEME.TextPrimary
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = row

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 46, 0, 14)
    valueLabel.Position = UDim2.new(1, -46, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(defaultVal)
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 10
    valueLabel.TextColor3 = THEME.Accent
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = row

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, 0, 0, 6)
    track.Position = UDim2.new(0, 0, 0, 20)
    track.BackgroundColor3 = THEME.ToggleOff
    track.BorderSizePixel = 0
    track.Parent = row

    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = track

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    fill.BackgroundColor3 = THEME.Accent
    fill.BorderSizePixel = 0
    fill.Parent = track

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.AnchorPoint = Vector2.new(0.5, 0.5)
    knob.Position = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 0.5, 0)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.Parent = track

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    local dragging = false

    local function updateValue(inputX)
        local trackAbs = track.AbsolutePosition.X
        local trackW = track.AbsoluteSize.X
        if trackW <= 0 then return end
        local rel = math.clamp((inputX - trackAbs) / trackW, 0, 1)
        local value = minVal + (maxVal - minVal) * rel
        value = math.floor(value * 100 + 0.5) / 100
        fill.Size = UDim2.new(rel, 0, 1, 0)
        knob.Position = UDim2.new(rel, 0, 0.5, 0)
        valueLabel.Text = tostring(value)
        if callback then callback(value) end
    end

    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateValue(input.Position.X)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateValue(input.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

local function createSelector(parent, name, options, defaultIndex, order, callback)
    local row = Instance.new("Frame")
    row.Name = name
    row.Size = UDim2.new(1, 0, 0, 21)
    row.BackgroundTransparency = 1
    row.LayoutOrder = order
    row.Parent = parent

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.5, 0, 1, 0)
    title.BackgroundTransparency = 1
    title.Text = name
    title.Font = Enum.Font.GothamMedium
    title.TextSize = 11
    title.TextColor3 = THEME.TextPrimary
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = row

    local currentIndex = defaultIndex or 1

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 90, 0, 18)
    btn.Position = UDim2.new(1, -90, 0.5, -9)
    btn.BackgroundColor3 = THEME.BadgeBg
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = row

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn

    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = THEME.Border
    btnStroke.Thickness = 0.8
    btnStroke.Parent = btn

    local btnLabel = Instance.new("TextLabel")
    btnLabel.Size = UDim2.new(1, -16, 1, 0)
    btnLabel.Position = UDim2.new(0, 6, 0, 0)
    btnLabel.BackgroundTransparency = 1
    btnLabel.Text = options[currentIndex]
    btnLabel.Font = Enum.Font.GothamMedium
    btnLabel.TextSize = 9.5
    btnLabel.TextColor3 = THEME.TextPrimary
    btnLabel.TextXAlignment = Enum.TextXAlignment.Left
    btnLabel.TextTruncate = Enum.TextTruncate.AtEnd
    btnLabel.Parent = btn

    local chev = Instance.new("ImageLabel")
    chev.Size = UDim2.new(0, 10, 0, 10)
    chev.Position = UDim2.new(1, -14, 0.5, -5)
    chev.BackgroundTransparency = 1
    chev.Image = ICONS.Chevron
    chev.ImageColor3 = THEME.TextMuted
    chev.Rotation = 90
    chev.Parent = btn

    local dropDownOpen = false
    local dropFrame = nil

    local function closeDrop()
        if dropFrame then
            dropFrame:Destroy()
            dropFrame = nil
            dropDownOpen = false
        end
    end

    local function openDrop()
        if dropDownOpen then
            closeDrop()
            return
        end
        dropDownOpen = true

        dropFrame = Instance.new("Frame")
        dropFrame.Name = "SelectorDropdown"
        dropFrame.Size = UDim2.new(0, 90, 0, #options * 20 + 6)
        dropFrame.Position = UDim2.new(1, -90, 1, 2)
        dropFrame.BackgroundColor3 = THEME.CardBg
        dropFrame.ZIndex = 30
        dropFrame.Parent = row

        local dc = Instance.new("UICorner")
        dc.CornerRadius = UDim.new(0, 6)
        dc.Parent = dropFrame

        local ds = Instance.new("UIStroke")
        ds.Color = THEME.Border
        ds.Thickness = 1
        ds.Parent = dropFrame

        local dl = Instance.new("UIListLayout")
        dl.Padding = UDim.new(0, 1)
        dl.Parent = dropFrame

        local dp = Instance.new("UIPadding")
        dp.PaddingTop = UDim.new(0, 3)
        dp.PaddingBottom = UDim.new(0, 3)
        dp.PaddingLeft = UDim.new(0, 4)
        dp.PaddingRight = UDim.new(0, 4)
        dp.Parent = dropFrame

        for i, opt in ipairs(options) do
            local optBtn = Instance.new("TextButton")
            optBtn.Size = UDim2.new(1, 0, 0, 18)
            optBtn.BackgroundTransparency = 1
            optBtn.Text = " " .. opt
            optBtn.Font = Enum.Font.GothamMedium
            optBtn.TextSize = 9.5
            optBtn.TextColor3 = (i == currentIndex) and THEME.Accent or THEME.TextPrimary
            optBtn.TextXAlignment = Enum.TextXAlignment.Left
            optBtn.ZIndex = 31
            optBtn.Parent = dropFrame

            optBtn.MouseEnter:Connect(function() optBtn.TextColor3 = THEME.Accent end)
            optBtn.MouseLeave:Connect(function()
                optBtn.TextColor3 = (i == currentIndex) and THEME.Accent or THEME.TextPrimary
            end)
            optBtn.MouseButton1Click:Connect(function()
                currentIndex = i
                btnLabel.Text = options[i]
                closeDrop()
                if callback then callback(options[i], i) end
            end)
        end
    end

    btn.MouseButton1Click:Connect(openDrop)
end

-- Aim logic
local function isTargetValid(player)
    if not player or player == LocalPlayer then return false end
    if not player.Character then return false end
    
    local hum = player.Character:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end

    if aimState.TeamCheck == "Enemy" then
        if player.Team == LocalPlayer.Team then return false end
    elseif aimState.TeamCheck == "Ignore" then
        if player.Team == LocalPlayer.Team then return false end
    end

    return true
end

local function getTargetPart(player)
    if not player or not player.Character then return nil end
    
    if aimState.TargetPart == "Closest" then
        local closestPart = nil
        local closestDist = math.huge
        local mousePos = UserInputService:GetMouseLocation()
        
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closestPart = part
                    end
                end
            end
        end
        return closestPart
    else
        return player.Character:FindFirstChild(aimState.TargetPart) or player.Character:FindFirstChild("HumanoidRootPart")
    end
end

local function findBestTarget()
    local mousePos = UserInputService:GetMouseLocation()
    local bestPlayer = nil
    local bestPart = nil
    local bestDist = aimState.CircleSize / 2

    for _, player in ipairs(Players:GetPlayers()) do
        if isTargetValid(player) then
            local part = getTargetPart(player)
            if part then
                local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local screenPos = Vector2.new(pos.X, pos.Y)
                    local dist = (screenPos - mousePos).Magnitude
                    if dist < bestDist then
                        bestDist = dist
                        bestPlayer = player
                        bestPart = part
                    end
                end
            end
        end
    end

    return bestPlayer, bestPart
end

RunService.RenderStepped:Connect(function()
    if aimState.ShowCircle then
        local mousePos = UserInputService:GetMouseLocation()
        aimCircle.Position = UDim2.new(0, mousePos.X, 0, mousePos.Y)
        aimCircle.Size = UDim2.new(0, aimState.CircleSize, 0, aimState.CircleSize)
        aimCircle.Visible = true
    else
        aimCircle.Visible = false
    end

    if not aimState.Enabled then return end

    local _, targetPart = findBestTarget()
    if targetPart then
        local camera = workspace.CurrentCamera
        local targetPos = targetPart.Position
        local currentCFrame = camera.CFrame
        local targetCFrame = CFrame.new(currentCFrame.Position, targetPos)
        
        local alpha = 1 - math.pow(aimState.Smoothness, 0.1)
        camera.CFrame = currentCFrame:Lerp(targetCFrame, alpha)
    end
end)

-- Combat tab
local combatTab = createTabPage("Combat")

local aimCard = createCard(combatTab.Col1, "Aim Bot", 1)

addToggle(aimCard, "Aim Bot", "Automatically aims at targets inside the circle", false, "F1", function(state)
    aimState.Enabled = state
end)

addToggle(aimCard, "Show Circle", "Show the aim circle around your cursor", true, nil, function(state)
    aimState.ShowCircle = state
end)

createSlider(aimCard, "Circle Size", 20, 300, 80, 4, function(value)
    aimState.CircleSize = value
end)

createSlider(aimCard, "Smoothness", 0.05, 1, 0.25, 5, function(value)
    aimState.Smoothness = value
end)

createSelector(aimCard, "Target Part", {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso", "Closest"}, 1, 6, function(value)
    aimState.TargetPart = value
end)

createSelector(aimCard, "Team Check", {"Enemy", "All", "Ignore"}, 1, 7, function(value)
    aimState.TeamCheck = value
end)

createSlider(aimCard, "FOV", 10, 500, 150, 8, function(value)
    aimState.FOV = value
end)

local targetCard = createCard(combatTab.Col2, "Target", 1)

local ignoreCard = createCard(combatTab.Col2, "Ignore", 2)
addToggle(ignoreCard, "Ignore Friends", "Don't aim at friends", true, nil)
addToggle(ignoreCard, "Ignore Dead", "Don't aim at dead players", true, nil)
addToggle(ignoreCard, "Ignore NPC", "Don't aim at NPCs", false, nil)

createTabPage("Movement")
createTabPage("Visuals")
createTabPage("Player")
createTabPage("Misc")

-- Account
local accountTab = createTabPage("Account")

local accountInfoCard = createCard(accountTab.Col1, "Account Info", 1)

local accountAvatarWrap = Instance.new("Frame")
accountAvatarWrap.Size = UDim2.new(1, 0, 0, 76)
accountAvatarWrap.BackgroundTransparency = 1
accountAvatarWrap.LayoutOrder = 1
accountAvatarWrap.Parent = accountInfoCard

local accountAvatar = createBigAvatar(accountAvatarWrap, 72, 1)
accountAvatar.Parent.Position = UDim2.new(0.5, -36, 0, 0)

task.spawn(function()
    local ok, thumb = pcall(function()
        return Players:GetUserThumbnailAsync(
            LocalPlayer.UserId,
            Enum.ThumbnailType.HeadShot,
            Enum.ThumbnailSize.Size150x150
        )
    end)
    if ok and thumb then
        accountAvatar.Image = thumb
    end
end)

local displayNameRow = Instance.new("TextLabel")
displayNameRow.Size = UDim2.new(1, 0, 0, 18)
displayNameRow.BackgroundTransparency = 1
displayNameRow.Text = LocalPlayer.DisplayName
displayNameRow.Font = Enum.Font.GothamBold
displayNameRow.TextSize = 14
displayNameRow.TextColor3 = THEME.TextPrimary
displayNameRow.LayoutOrder = 2
displayNameRow.Parent = accountInfoCard

local usernameRow = Instance.new("TextLabel")
usernameRow.Size = UDim2.new(1, 0, 0, 13)
usernameRow.BackgroundTransparency = 1
usernameRow.Text = "@" .. LocalPlayer.Name
usernameRow.Font = Enum.Font.Gotham
usernameRow.TextSize = 10
usernameRow.TextColor3 = THEME.TextMuted
usernameRow.LayoutOrder = 3
usernameRow.Parent = accountInfoCard

local divider = Instance.new("Frame")
divider.Size = UDim2.new(1, 0, 0, 1)
divider.BackgroundColor3 = THEME.Divider
divider.BorderSizePixel = 0
divider.LayoutOrder = 4
divider.Parent = accountInfoCard

createInfoRow(accountInfoCard, "Username", LocalPlayer.Name, 5)
createInfoRow(accountInfoCard, "User ID", LocalPlayer.UserId, 6)

local accountAgeDays = LocalPlayer.AccountAge
local years = math.floor(accountAgeDays / 365)
local daysAfter = accountAgeDays % 365
local ageText
if years > 0 then
    ageText = string.format("%dy %dd (%d days)", years, daysAfter, accountAgeDays)
else
    ageText = string.format("%d days", accountAgeDays)
end
createInfoRow(accountInfoCard, "Account Age", ageText, 7)

local regDate = os.date("%d.%m.%Y", os.time() - accountAgeDays * 86400)
createInfoRow(accountInfoCard, "Created", regDate, 8)

local premiumText = "No"
pcall(function()
    if LocalPlayer.MembershipType == Enum.MembershipType.Premium then
        premiumText = "Premium"
    end
end)
createInfoRow(accountInfoCard, "Membership", premiumText, 9)

local pingRowValue = createInfoRow(accountInfoCard, "Ping", "0 ms", 10)
local friendsRowValue = createInfoRow(accountInfoCard, "Friends", "?", 11)
local followersRowValue = createInfoRow(accountInfoCard, "Followers", "?", 12)

pcall(function()
    friendsRowValue.Text = tostring(LocalPlayer.FriendCount or "?")
end)
pcall(function()
    followersRowValue.Text = tostring(LocalPlayer.FollowerCount or "?")
end)

local sessionCard = createCard(accountTab.Col2, "Session", 1)
local sessionStart = os.clock()
local uptimeValue = createInfoRow(sessionCard, "Uptime", "00:00:00", 1)
createInfoRow(sessionCard, "Place ID", game.PlaceId, 2)
createInfoRow(sessionCard, "Job ID", string.sub(game.JobId, 1, 18) .. "...", 3)

local creditsCard = createCard(accountTab.Col2, "Credits", 2)
createInfoRow(creditsCard, "Made by", "juicovss", 1)
createInfoRow(creditsCard, "Roblox", "juicovss", 2)
createInfoRow(creditsCard, "TikTok", "c00lbr0_t34mzz", 3)

task.spawn(function()
    while task.wait(1) do
        local elapsed = os.clock() - sessionStart
        local h = math.floor(elapsed / 3600)
        local m = math.floor((elapsed % 3600) / 60)
        local s = math.floor(elapsed % 60)
        uptimeValue.Text = string.format("%02d:%02d:%02d", h, m, s)
    end
end)

task.spawn(function()
    while task.wait(1) do
        pingRowValue.Text = tostring(getPing()) .. " ms"
    end
end)

-- Keybinds
local keybindsTab = createTabPage("Keybinds")

local favCard = createCard(keybindsTab.Col1, "Favorites", 1)

local favRowsHolder = Instance.new("Frame")
favRowsHolder.Size = UDim2.new(1, 0, 0, 0)
favRowsHolder.AutomaticSize = Enum.AutomaticSize.Y
favRowsHolder.BackgroundTransparency = 1
favRowsHolder.LayoutOrder = 1
favRowsHolder.Parent = favCard

local favRowsLayout = Instance.new("UIListLayout")
favRowsLayout.Padding = UDim.new(0, 6)
favRowsLayout.SortOrder = Enum.SortOrder.LayoutOrder
favRowsLayout.Parent = favRowsHolder

local function refreshFavorites()
    for _, child in ipairs(favRowsHolder:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextLabel") then
            child:Destroy()
        end
    end

    local count = 0
    for _, toggleObj in ipairs(allToggles) do
        if isFavorite(toggleObj.Name) then
            count = count + 1

            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 20)
            row.BackgroundColor3 = THEME.PillBg
            row.BorderSizePixel = 0
            row.LayoutOrder = count
            row.Parent = favRowsHolder

            local rowCorner = Instance.new("UICorner")
            rowCorner.CornerRadius = UDim.new(0, 4)
            rowCorner.Parent = row

            local nameLbl = Instance.new("TextLabel")
            nameLbl.Size = UDim2.new(1, -50, 1, 0)
            nameLbl.Position = UDim2.new(0, 10, 0, 0)
            nameLbl.BackgroundTransparency = 1
            nameLbl.Text = toggleObj.Name
            nameLbl.Font = Enum.Font.GothamMedium
            nameLbl.TextSize = 10
            nameLbl.TextColor3 = THEME.TextPrimary
            nameLbl.TextXAlignment = Enum.TextXAlignment.Left
            nameLbl.Parent = row

            local stateLbl = Instance.new("TextLabel")
            stateLbl.Size = UDim2.new(0, 40, 1, 0)
            stateLbl.Position = UDim2.new(1, -46, 0, 0)
            stateLbl.BackgroundTransparency = 1
            stateLbl.Text = toggleObj.IsToggled and "ON" or "OFF"
            stateLbl.Font = Enum.Font.GothamBold
            stateLbl.TextSize = 9
            stateLbl.TextColor3 = toggleObj.IsToggled and THEME.Accent or THEME.TextMuted
            stateLbl.TextXAlignment = Enum.TextXAlignment.Right
            stateLbl.Parent = row
        end
    end

    if count == 0 then
        local empty = Instance.new("TextLabel")
        empty.Size = UDim2.new(1, 0, 0, 16)
        empty.BackgroundTransparency = 1
        empty.Text = "No favorites — click ☆ in Keybinds"
        empty.Font = Enum.Font.Gotham
        empty.TextSize = 10
        empty.TextColor3 = THEME.TextDim
        empty.TextXAlignment = Enum.TextXAlignment.Center
        empty.LayoutOrder = 1
        empty.Parent = favRowsHolder
    end
end

_G.NursultanRefreshFavorites = refreshFavorites

local keybindsCard = createCard(keybindsTab.Col1, "Active Keybinds", 2)

local keybindRowsHolder = Instance.new("Frame")
keybindRowsHolder.Size = UDim2.new(1, 0, 0, 0)
keybindRowsHolder.AutomaticSize = Enum.AutomaticSize.Y
keybindRowsHolder.BackgroundTransparency = 1
keybindRowsHolder.LayoutOrder = 1
keybindRowsHolder.Parent = keybindsCard

local keybindRowsLayout = Instance.new("UIListLayout")
keybindRowsLayout.Padding = UDim.new(0, 6)
keybindRowsLayout.SortOrder = Enum.SortOrder.LayoutOrder
keybindRowsLayout.Parent = keybindRowsHolder

keybindListRefresh = function()
    for _, child in ipairs(keybindRowsHolder:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextLabel") then
            child:Destroy()
        end
    end

    local count = 0
    for _, toggleObj in ipairs(allToggles) do
        if toggleObj.Keybind and toggleObj.Keybind ~= "" and toggleObj.Keybind ~= "-" then
            count = count + 1

            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 20)
            row.BackgroundColor3 = THEME.PillBg
            row.BorderSizePixel = 0
            row.LayoutOrder = count
            row.Parent = keybindRowsHolder

            local rowCorner = Instance.new("UICorner")
            rowCorner.CornerRadius = UDim.new(0, 4)
            rowCorner.Parent = row

            local nameLbl = Instance.new("TextLabel")
            nameLbl.Size = UDim2.new(1, -60, 1, 0)
            nameLbl.Position = UDim2.new(0, 10, 0, 0)
            nameLbl.BackgroundTransparency = 1
            nameLbl.Text = toggleObj.Name
            nameLbl.Font = Enum.Font.GothamMedium
            nameLbl.TextSize = 10
            nameLbl.TextColor3 = THEME.TextPrimary
            nameLbl.TextXAlignment = Enum.TextXAlignment.Left
            nameLbl.Parent = row

            local keyLbl = Instance.new("TextLabel")
            keyLbl.Size = UDim2.new(0, 50, 1, 0)
            keyLbl.Position = UDim2.new(1, -56, 0, 0)
            keyLbl.BackgroundTransparency = 1
            keyLbl.Text = toggleObj.Keybind
            keyLbl.Font = Enum.Font.GothamBold
            keyLbl.TextSize = 10
            keyLbl.TextColor3 = THEME.Accent
            keyLbl.TextXAlignment = Enum.TextXAlignment.Right
            keyLbl.Parent = row
        end
    end

    if count == 0 then
        local empty = Instance.new("TextLabel")
        empty.Size = UDim2.new(1, 0, 0, 16)
        empty.BackgroundTransparency = 1
        empty.Text = "No keybinds set"
        empty.Font = Enum.Font.Gotham
        empty.TextSize = 10
        empty.TextColor3 = THEME.TextDim
        empty.TextXAlignment = Enum.TextXAlignment.Center
        empty.LayoutOrder = 1
        empty.Parent = keybindRowsHolder
    end
end

task.spawn(function()
    task.wait(0.1)
    keybindListRefresh()
    refreshFavorites()
end)

-- Settings
local settingsTab = createTabPage("Settings")

local hudToggleKey = Enum.KeyCode.RightControl

local uiCard = createCard(settingsTab.Col1, "Interface", 1)

createButton(uiCard, "Toggle Key", "Current: RightControl", 1, function() end)

local toggleKeyBtn = uiCard:FindFirstChild("Toggle Key")
if toggleKeyBtn then
    local badge = Instance.new("TextLabel")
    badge.Size = UDim2.new(0, 70, 0, 16)
    badge.Position = UDim2.new(1, -86, 0.5, -8)
    badge.BackgroundColor3 = THEME.BadgeBg
    badge.Text = "RightControl"
    badge.Font = Enum.Font.GothamBold
    badge.TextSize = 9
    badge.TextColor3 = THEME.TextMuted
    badge.Parent = toggleKeyBtn

    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(0, 3)
    bCorner.Parent = badge

    local bStroke = Instance.new("UIStroke")
    bStroke.Color = THEME.Border
    bStroke.Thickness = 0.8
    bStroke.Parent = badge

    local chev = toggleKeyBtn:FindFirstChildOfClass("ImageLabel")
    if chev then
        chev.Position = UDim2.new(1, -20, 0.5, -6)
    end

    toggleKeyBtn.MouseButton1Click:Connect(function()
        if KeybindListening then
            KeybindListening:Disconnect()
            KeybindListening = nil
        end

        badge.Text = "..."
        badge.TextColor3 = THEME.Accent

        KeybindListening = UserInputService.InputBegan:Connect(function(input, processed)
            if processed then return end
            if input.UserInputType == Enum.UserInputType.Keyboard then
                badge.Text = input.KeyCode.Name
                badge.TextColor3 = THEME.TextMuted
                hudToggleKey = input.KeyCode
                if KeybindListening then
                    KeybindListening:Disconnect()
                    KeybindListening = nil
                end
            end
        end)
    end)
end

createButton(uiCard, "Reset UI Position", "Center the window", 2, function()
    Main.Position = UDim2.new(0.5, 0, 0.5, 18)
end)

-- Stealth mode toggle
addToggle(uiCard, "Stealth Mode", "Hide everything, leave a small icon in corner", false, nil, function(state)
    if state then
        if _G.NursultanEnableStealth then _G.NursultanEnableStealth() end
    else
        if _G.NursultanDisableStealth then _G.NursultanDisableStealth() end
    end
end)

-- NoName toggle
addToggle(uiCard, "NoName", "Replace your name in HUD with animated question marks", false, nil, function(state)
    NoNameEnabled = state
    if not state and _G.NursultanSetNameLabel then
        _G.NursultanSetNameLabel(string.lower(LocalPlayer.Name))
    end
end)

local themeCard = createCard(settingsTab.Col1, "Theme", 2)

local colorRow = Instance.new("Frame")
colorRow.Size = UDim2.new(1, 0, 0, 24)
colorRow.BackgroundTransparency = 1
colorRow.LayoutOrder = 1
colorRow.Parent = themeCard

local colorLayout = Instance.new("UIListLayout")
colorLayout.FillDirection = Enum.FillDirection.Horizontal
colorLayout.Padding = UDim.new(0, 6)
colorLayout.SortOrder = Enum.SortOrder.LayoutOrder
colorLayout.VerticalAlignment = Enum.VerticalAlignment.Center
colorLayout.Parent = colorRow

local PRESETS = {
    {Name = "Red",    Main = Color3.fromRGB(246, 92, 82),    Soft = Color3.fromRGB(255, 165, 155), Dark = Color3.fromRGB(130, 40, 42)},
    {Name = "Blue",   Main = Color3.fromRGB(74, 144, 246),   Soft = Color3.fromRGB(160, 195, 255), Dark = Color3.fromRGB(38, 70, 140)},
    {Name = "Green",  Main = Color3.fromRGB(82, 200, 110),   Soft = Color3.fromRGB(160, 240, 180), Dark = Color3.fromRGB(40, 110, 60)},
    {Name = "Purple", Main = Color3.fromRGB(160, 92, 246),   Soft = Color3.fromRGB(210, 170, 255), Dark = Color3.fromRGB(85, 40, 140)},
    {Name = "Pink",   Main = Color3.fromRGB(246, 92, 180),   Soft = Color3.fromRGB(255, 175, 220), Dark = Color3.fromRGB(130, 40, 90)},
    {Name = "Orange", Main = Color3.fromRGB(246, 150, 60),   Soft = Color3.fromRGB(255, 200, 150), Dark = Color3.fromRGB(140, 80, 30)}
}

local function recolorAll(oldAccent, oldBorderActive)
    oldAccent = oldAccent or THEME.Accent
    oldBorderActive = oldBorderActive or THEME.BorderActive

    if MainLogoGrad and MainLogoGrad.Parent then
        MainLogoGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, THEME.AccentSoft),
            ColorSequenceKeypoint.new(0.45, THEME.Accent),
            ColorSequenceKeypoint.new(1.0, THEME.AccentDark)
        })
    end
    if HudLogoGrad and HudLogoGrad.Parent then
        HudLogoGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, THEME.AccentSoft),
            ColorSequenceKeypoint.new(0.45, THEME.Accent),
            ColorSequenceKeypoint.new(1.0, THEME.AccentDark)
        })
    end
    if HudBrandGrad and HudBrandGrad.Parent then
        HudBrandGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, THEME.AccentSoft),
            ColorSequenceKeypoint.new(1.0, THEME.Accent)
        })
    end
    if aimCircleUIStroke and aimCircleUIStroke.Parent then
        aimCircleUIStroke.Color = THEME.Accent
    end

    for _, toggleObj in ipairs(allToggles) do
        if toggleObj.AccentBar and toggleObj.AccentBar.Parent then
            toggleObj.AccentBar.BackgroundColor3 = THEME.Accent
        end
        if toggleObj.IsToggled and toggleObj.Switch and toggleObj.Switch.Parent then
            toggleObj.Switch.BackgroundColor3 = THEME.Accent
        end
        if toggleObj.FavBtn and toggleObj.FavBtn.Parent and isFavorite(toggleObj.Name) then
            toggleObj.FavBtn.TextColor3 = THEME.Accent
        end
    end

    for _, item in ipairs(sidebarItems) do
        if item.Icon and item.Icon.Parent then
            local isActive = activeSidebarTab and activeSidebarTab.Btn == item.Btn
            item.Icon.ImageColor3 = isActive and THEME.Accent or THEME.TextMuted
            if isActive and item.Stroke and item.Stroke.Parent then
                item.Stroke.Color = THEME.BorderActive
            end
        end
    end

    local function replaceColor(obj, prop, from, to)
        if not obj or not obj.Parent then return end
        local ok, val = pcall(function() return obj[prop] end)
        if ok and typeof(val) == "Color3" and val == from then
            obj[prop] = to
        end
    end

    if Main and Main.Parent then
        for _, desc in ipairs(Main:GetDescendants()) do
            if desc:IsA("ImageLabel") or desc:IsA("ImageButton") then
                replaceColor(desc, "ImageColor3", oldAccent, THEME.Accent)
            end
            if desc:IsA("Frame") or desc:IsA("TextButton") then
                replaceColor(desc, "BackgroundColor3", oldAccent, THEME.Accent)
            end
            if desc:IsA("TextLabel") or desc:IsA("TextBox") then
                replaceColor(desc, "TextColor3", oldAccent, THEME.Accent)
            end
            if desc:IsA("UIStroke") then
                replaceColor(desc, "Color", oldBorderActive, THEME.BorderActive)
            end
        end
    end

    if HudContainer and HudContainer.Parent then
        for _, desc in ipairs(HudContainer:GetDescendants()) do
            if desc:IsA("ImageLabel") then
                replaceColor(desc, "ImageColor3", oldAccent, THEME.Accent)
            end
            if desc:IsA("TextLabel") then
                replaceColor(desc, "TextColor3", oldAccent, THEME.Accent)
            end
            if desc:IsA("UIStroke") then
                replaceColor(desc, "Color", oldBorderActive, THEME.BorderActive)
            end
        end
    end

    if keybindListRefresh then keybindListRefresh() end
    if refreshFavorites then refreshFavorites() end
end

_G.NursultanRecolor = recolorAll

for i, preset in ipairs(PRESETS) do
    local swatch = Instance.new("TextButton")
    swatch.Name = preset.Name
    swatch.Size = UDim2.new(0, 22, 0, 22)
    swatch.BackgroundColor3 = preset.Main
    swatch.Text = ""
    swatch.AutoButtonColor = false
    swatch.LayoutOrder = i
    swatch.Parent = colorRow

    local swatchCorner = Instance.new("UICorner")
    swatchCorner.CornerRadius = UDim.new(1, 0)
    swatchCorner.Parent = swatch

    local swatchStroke = Instance.new("UIStroke")
    swatchStroke.Color = THEME.Border
    swatchStroke.Thickness = 1.5
    swatchStroke.Parent = swatch

    swatch.MouseEnter:Connect(function()
        TweenService:Create(swatch, TWEEN_FAST, {Size = UDim2.new(0, 26, 0, 26)}):Play()
    end)
    swatch.MouseLeave:Connect(function()
        TweenService:Create(swatch, TWEEN_FAST, {Size = UDim2.new(0, 22, 0, 22)}):Play()
    end)

    swatch.MouseButton1Click:Connect(function()
        local oldAccent = THEME.Accent
        local oldBorderActive = THEME.BorderActive

        THEME.Accent = preset.Main
        THEME.AccentSoft = preset.Soft
        THEME.AccentDark = preset.Dark
        THEME.BorderActive = Color3.fromRGB(
            math.min(255, math.floor(preset.Dark.R * 255) + 40),
            math.min(255, math.floor(preset.Dark.G * 255) + 40),
            math.min(255, math.floor(preset.Dark.B * 255) + 40)
        )

        recolorAll(oldAccent, oldBorderActive)
        notify("Theme", "Changed to " .. preset.Name, 2)
    end)

    attachRipple(swatch)
end

local configCard = createCard(settingsTab.Col2, "Config", 1)

_G.NursultanConfig = _G.NursultanConfig or {}

createButton(configCard, "Save Config", "Save current settings", 1, function()
    local snapshot = {}
    for _, toggleObj in ipairs(allToggles) do
        snapshot[toggleObj.Name] = {
            IsToggled = toggleObj.IsToggled,
            Keybind = toggleObj.Keybind,
            Favorite = isFavorite(toggleObj.Name)
        }
    end
    _G.NursultanConfig = snapshot
    notify("Config", "Saved successfully", 2.5)
end)

createButton(configCard, "Load Config", "Apply saved settings", 2, function()
    if not _G.NursultanConfig or next(_G.NursultanConfig) == nil then
        notify("Config", "No saved config found", 2.5)
        return
    end

    for _, toggleObj in ipairs(allToggles) do
        local saved = _G.NursultanConfig[toggleObj.Name]
        if saved then
            toggleObj.IsToggled = not saved.IsToggled
            toggleObj.SetToggle(saved.IsToggled, false)

            if saved.Keybind and saved.Keybind ~= "-" then
                toggleObj.Keybind = saved.Keybind
                local ok, code = pcall(function() return Enum.KeyCode[saved.Keybind] end)
                if ok then
                    toggleObj.KeyCode = code
                else
                    toggleObj.KeyCode = nil
                end
                toggleObj.Badge.Text = saved.Keybind
            else
                toggleObj.Keybind = nil
                toggleObj.KeyCode = nil
                toggleObj.Badge.Text = ""
            end

            if saved.Favorite then
                FAVORITES[toggleObj.Name] = true
                if toggleObj.FavBtn then
                    toggleObj.FavBtn.Text = "★"
                    toggleObj.FavBtn.TextColor3 = THEME.Accent
                end
            end
        end
    end

    if keybindListRefresh then keybindListRefresh() end
    if refreshFavorites then refreshFavorites() end
    notify("Config", "Loaded successfully", 2.5)
end)

createButton(configCard, "Reset Config", "Clear saved config", 3, function()
    _G.NursultanConfig = {}
    for _, toggleObj in ipairs(allToggles) do
        toggleObj.IsToggled = not toggleObj.DefaultState
        toggleObj.SetToggle(toggleObj.DefaultState, false)

        if toggleObj.DefaultKeybind then
            toggleObj.Keybind = toggleObj.DefaultKeybind
            local ok, code = pcall(function() return Enum.KeyCode[toggleObj.DefaultKeybind] end)
            if ok then toggleObj.KeyCode = code end
            toggleObj.Badge.Text = toggleObj.DefaultKeybind
        else
            toggleObj.Keybind = nil
            toggleObj.KeyCode = nil
            toggleObj.Badge.Text = ""
        end
    end
    for k in pairs(FAVORITES) do FAVORITES[k] = nil end

    for _, toggleObj in ipairs(allToggles) do
        if toggleObj.FavBtn then
            toggleObj.FavBtn.Text = "☆"
            toggleObj.FavBtn.TextColor3 = THEME.TextDim
        end
    end

    if keybindListRefresh then keybindListRefresh() end
    if refreshFavorites then refreshFavorites() end
    notify("Config", "Reset to defaults", 2.5)
end)

local hudCard = createCard(settingsTab.Col2, "HUD", 2)

addToggle(hudCard, "HUD Visible", "Show or hide the top-left HUD", true, nil, function(state)
    HudContainer.Visible = state
end)

addToggle(hudCard, "Watermark", "Show or hide the brand watermark", true, nil, function(state)
    BrandPill.Visible = state
end)

local miscCard = createCard(settingsTab.Col2, "Misc", 3)

createButton(miscCard, "Test Notification", "Show a sample notification", 1, function()
    notify("Nursultan UI", "This is a test notification!", 4)
end)

createButton(miscCard, "Unload UI", "Removes the GUI completely", 2, function()
    if blurEffect then blurEffect:Destroy() end
    if notifSound then notifSound:Destroy() end
    _G.NursultanUI_Loaded = nil
    _G.NursultanUI_ScreenGui = nil
    _G.NursultanUI_Blur = nil
    ScreenGui:Destroy()
end)

createInfoRow(miscCard, "Version", "nursultan v1.8", 3)
createInfoRow(miscCard, "Build", "stable", 4)

-- ===== Stealth mode =====
local StealthActive = false
local StealthIconBtn = nil

local function createStealthIcon()
    if StealthIconBtn then
        pcall(function() StealthIconBtn:Destroy() end)
        StealthIconBtn = nil
    end
    StealthIconBtn = Instance.new("ImageButton")
    StealthIconBtn.Name = "StealthIcon"
    StealthIconBtn.AnchorPoint = Vector2.new(1, 1)
    StealthIconBtn.Size = UDim2.new(0, 40, 0, 40)
    StealthIconBtn.Position = UDim2.new(1, -12, 1, -12)
    StealthIconBtn.BackgroundTransparency = 1
    StealthIconBtn.Image = CUSTOM_LOGO_ID
    StealthIconBtn.ScaleType = Enum.ScaleType.Fit
    StealthIconBtn.ZIndex = 800
    StealthIconBtn.Parent = ScreenGui

    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.0, THEME.AccentSoft),
        ColorSequenceKeypoint.new(0.45, THEME.Accent),
        ColorSequenceKeypoint.new(1.0, Color3.fromRGB(165, 32, 42))
    })
    grad.Rotation = -35
    grad.Parent = StealthIconBtn

    local stroke = Instance.new("UIStroke")
    stroke.Color = THEME.Accent
    stroke.Thickness = 1
    stroke.Transparency = 0.4
    stroke.Parent = StealthIconBtn

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = StealthIconBtn

    StealthIconBtn.MouseButton1Click:Connect(function()
        _G.NursultanDisableStealth()
        if not isOpen then openUI() end
        notify("Stealth Mode", "UI restored.", 3)
    end)
end

_G.NursultanEnableStealth = function()
    if StealthActive then return end
    StealthActive = true
    ScreenGui.Enabled = false
    blurEffect.Size = 0
    createStealthIcon()
end

_G.NursultanDisableStealth = function()
    if not StealthActive then return end
    StealthActive = false
    ScreenGui.Enabled = true
    if StealthIconBtn then
        pcall(function() StealthIconBtn:Destroy() end)
        StealthIconBtn = nil
    end
end

-- ===== Unload confirmation =====
local unloadPhrases = {
    "are you sure you want to quit? :(",
    "leaving so soon? :(",
    "you really wanna unload? :(",
    "don't go... please? :(",
    "are you sure you want to leave? :(",
    "quitting already? :(",
    "bye bye? :(",
    "this is the end... :(",
    "sad to see you go :(",
    "confirm unload? :("
}

local UnloadOverlay = nil

_G.NursultanShowUnloadConfirm = function()
    if UnloadOverlay then return end
    local phrase = unloadPhrases[math.random(1, #unloadPhrases)]

    UnloadOverlay = Instance.new("Frame")
    UnloadOverlay.Name = "UnloadOverlay"
    UnloadOverlay.Size = UDim2.new(1, 0, 1, 0)
    UnloadOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    UnloadOverlay.BackgroundTransparency = 0.45
    UnloadOverlay.BorderSizePixel = 0
    UnloadOverlay.ZIndex = 900
    UnloadOverlay.Parent = ScreenGui

    blurEffect.Size = 24

    local center = Instance.new("Frame")
    center.AnchorPoint = Vector2.new(0.5, 0.5)
    center.Size = UDim2.new(0, 360, 0, 180)
    center.Position = UDim2.new(0.5, 0, 0.5, 0)
    center.BackgroundColor3 = THEME.CardBg
    center.BackgroundTransparency = 1
    center.BorderSizePixel = 0
    center.ZIndex = 901
    center.Parent = UnloadOverlay

    local cc = Instance.new("UICorner"); cc.CornerRadius = UDim.new(0, 12); cc.Parent = center
    local cs = Instance.new("UIStroke"); cs.Color = THEME.BorderActive; cs.Thickness = 1.2; cs.Transparency = 1; cs.Parent = center

    local logo = Instance.new("ImageLabel")
    logo.Size = UDim2.new(0, 44, 0, 44)
    logo.Position = UDim2.new(0.5, -22, 0, 22)
    logo.BackgroundTransparency = 1
    logo.Image = CUSTOM_LOGO_ID
    logo.ScaleType = Enum.ScaleType.Fit
    logo.ZIndex = 902
    logo.Parent = center

    local lg = Instance.new("UIGradient")
    lg.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.0, THEME.AccentSoft),
        ColorSequenceKeypoint.new(1.0, THEME.Accent)
    })
    lg.Rotation = -35
    lg.Parent = logo

    local phraseLabel = Instance.new("TextLabel")
    phraseLabel.Size = UDim2.new(1, -40, 0, 26)
    phraseLabel.Position = UDim2.new(0, 20, 0, 80)
    phraseLabel.BackgroundTransparency = 1
    phraseLabel.Text = phrase
    phraseLabel.Font = Enum.Font.GothamMedium
    phraseLabel.TextSize = 14
    phraseLabel.TextColor3 = THEME.TextPrimary
    phraseLabel.TextTransparency = 1
    phraseLabel.ZIndex = 902
    phraseLabel.Parent = center

    local yesBtn = Instance.new("TextButton")
    yesBtn.Size = UDim2.new(0, 130, 0, 32)
    yesBtn.Position = UDim2.new(0, 45, 1, -54)
    yesBtn.BackgroundColor3 = THEME.Accent
    yesBtn.BackgroundTransparency = 1
    yesBtn.Text = "Yes"
    yesBtn.Font = Enum.Font.GothamBold
    yesBtn.TextSize = 13
    yesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    yesBtn.TextTransparency = 1
    yesBtn.AutoButtonColor = false
    yesBtn.ZIndex = 902
    yesBtn.Parent = center
    local yc = Instance.new("UICorner"); yc.CornerRadius = UDim.new(0, 6); yc.Parent = yesBtn

    local noBtn = Instance.new("TextButton")
    noBtn.Size = UDim2.new(0, 130, 0, 32)
    noBtn.Position = UDim2.new(1, -175, 1, -54)
    noBtn.BackgroundColor3 = THEME.ToggleOff
    noBtn.BackgroundTransparency = 1
    noBtn.Text = "No"
    noBtn.Font = Enum.Font.GothamBold
    noBtn.TextSize = 13
    noBtn.TextColor3 = THEME.TextPrimary
    noBtn.TextTransparency = 1
    noBtn.AutoButtonColor = false
    noBtn.ZIndex = 902
    noBtn.Parent = center
    local nc = Instance.new("UICorner"); nc.CornerRadius = UDim.new(0, 6); nc.Parent = noBtn

    TweenService:Create(center, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
    TweenService:Create(cs, TweenInfo.new(0.3), {Transparency = 0}):Play()
    TweenService:Create(phraseLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    TweenService:Create(yesBtn, TweenInfo.new(0.3), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
    TweenService:Create(noBtn, TweenInfo.new(0.3), {BackgroundTransparency = 0, TextTransparency = 0}):Play()

    local function dismiss(cb)
        if not UnloadOverlay then return end
        local ov = UnloadOverlay
        UnloadOverlay = nil
        TweenService:Create(ov, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
        TweenService:Create(center, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
        TweenService:Create(cs, TweenInfo.new(0.25), {Transparency = 1}):Play()
        TweenService:Create(phraseLabel, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
        TweenService:Create(yesBtn, TweenInfo.new(0.25), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        TweenService:Create(noBtn, TweenInfo.new(0.25), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        blurEffect.Size = 0
        task.delay(0.3, function()
            if ov and ov.Parent then ov:Destroy() end
        end)
        if cb then task.delay(0.28, cb) end
    end

    yesBtn.MouseButton1Click:Connect(function()
        dismiss(function()
            if blurEffect then blurEffect:Destroy() end
            if notifSound then notifSound:Destroy() end
            _G.NursultanUI_Loaded = nil
            _G.NursultanUI_ScreenGui = nil
            _G.NursultanUI_Blur = nil
            if ScreenGui and ScreenGui.Parent then ScreenGui:Destroy() end
        end)
    end)

    noBtn.MouseButton1Click:Connect(function() dismiss(nil) end)
end

CloseBtn.MouseButton1Click:Connect(function()
    if _G.NursultanShowUnloadConfirm then _G.NursultanShowUnloadConfirm() end
end)

-- Loading screen
local LoadingScreen = Instance.new("Frame")
LoadingScreen.Name = "LoadingScreen"
LoadingScreen.Size = UDim2.new(1, 0, 1, 0)
LoadingScreen.Position = UDim2.new(0, 0, 0, 0)
LoadingScreen.BackgroundColor3 = THEME.Background
LoadingScreen.BackgroundTransparency = 1
LoadingScreen.BorderSizePixel = 0
LoadingScreen.ZIndex = 500
LoadingScreen.Parent = ScreenGui

local LoadingBg = Instance.new("Frame")
LoadingBg.Size = UDim2.new(1, 0, 1, 0)
LoadingBg.BackgroundColor3 = THEME.Background
LoadingBg.BackgroundTransparency = 0.25
LoadingBg.BorderSizePixel = 0
LoadingBg.ZIndex = 501
LoadingBg.Parent = LoadingScreen

local LoadingCenter = Instance.new("Frame")
LoadingCenter.Size = UDim2.new(0, 400, 0, 160)
LoadingCenter.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingCenter.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingCenter.BackgroundTransparency = 1
LoadingCenter.ZIndex = 502
LoadingCenter.Parent = LoadingScreen

local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.Size = UDim2.new(1, 0, 0, 36)
LoadingTitle.Position = UDim2.new(0, 0, 0, 0)
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Text = "Loading."
LoadingTitle.Font = Enum.Font.GothamBold
LoadingTitle.TextSize = 26
LoadingTitle.TextColor3 = THEME.TextPrimary
LoadingTitle.TextXAlignment = Enum.TextXAlignment.Center
LoadingTitle.ZIndex = 503
LoadingTitle.Parent = LoadingCenter

local LoadingTitleGrad = Instance.new("UIGradient")
LoadingTitleGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, THEME.AccentSoft),
    ColorSequenceKeypoint.new(0.5, THEME.Accent),
    ColorSequenceKeypoint.new(1.0, THEME.AccentSoft)
})
LoadingTitleGrad.Rotation = 0
LoadingTitleGrad.Parent = LoadingTitle

task.spawn(function()
    local dots = 0
    while LoadingScreen.Parent do
        dots = (dots % 3) + 1
        LoadingTitle.Text = "Loading" .. string.rep(".", dots)
        task.wait(0.35)
    end
end)

local LoadingBarBg = Instance.new("Frame")
LoadingBarBg.Size = UDim2.new(1, -40, 0, 6)
LoadingBarBg.Position = UDim2.new(0, 20, 0, 60)
LoadingBarBg.BackgroundColor3 = THEME.ToggleOff
LoadingBarBg.BorderSizePixel = 0
LoadingBarBg.ZIndex = 503
LoadingBarBg.Parent = LoadingCenter

local LoadingBarBgCorner = Instance.new("UICorner")
LoadingBarBgCorner.CornerRadius = UDim.new(1, 0)
LoadingBarBgCorner.Parent = LoadingBarBg

local LoadingBarFill = Instance.new("Frame")
LoadingBarFill.Size = UDim2.new(0, 0, 1, 0)
LoadingBarFill.BackgroundColor3 = THEME.Accent
LoadingBarFill.BorderSizePixel = 0
LoadingBarFill.ZIndex = 504
LoadingBarFill.Parent = LoadingBarBg

local LoadingBarFillCorner = Instance.new("UICorner")
LoadingBarFillCorner.CornerRadius = UDim.new(1, 0)
LoadingBarFillCorner.Parent = LoadingBarFill

local LoadingBarFillGrad = Instance.new("UIGradient")
LoadingBarFillGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, THEME.AccentSoft),
    ColorSequenceKeypoint.new(1.0, THEME.Accent)
})
LoadingBarFillGrad.Parent = LoadingBarFill

local LoadingPercent = Instance.new("TextLabel")
LoadingPercent.Size = UDim2.new(1, 0, 0, 14)
LoadingPercent.Position = UDim2.new(0, 0, 0, 74)
LoadingPercent.BackgroundTransparency = 1
LoadingPercent.Text = "0%"
LoadingPercent.Font = Enum.Font.GothamMedium
LoadingPercent.TextSize = 11
LoadingPercent.TextColor3 = THEME.TextMuted
LoadingPercent.TextXAlignment = Enum.TextXAlignment.Center
LoadingPercent.ZIndex = 503
LoadingPercent.Parent = LoadingCenter

local LoadingTip = Instance.new("TextLabel")
LoadingTip.Size = UDim2.new(1, -20, 0, 14)
LoadingTip.Position = UDim2.new(0, 10, 0, 96)
LoadingTip.BackgroundTransparency = 1
LoadingTip.Text = ""
LoadingTip.Font = Enum.Font.GothamMedium
LoadingTip.TextSize = 10
LoadingTip.TextColor3 = THEME.TextDim
LoadingTip.TextTransparency = 1
LoadingTip.TextXAlignment = Enum.TextXAlignment.Center
LoadingTip.ZIndex = 503
LoadingTip.Parent = LoadingCenter

local TIPS = {
    "Press RightControl to show/hide the GUI",
    "Click ☆ next to a toggle to add it to Favorites",
    "Use the ? button to see what each toggle does",
    "Bind keys from the ... menu next to each toggle",
    "Save your setup with Config → Save",
    "Drag the HUD to move it anywhere on screen"
}

task.spawn(function()
    while LoadingScreen.Parent do
        local tip = TIPS[math.random(1, #TIPS)]
        LoadingTip.Text = tip
        TweenService:Create(LoadingTip, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
        task.wait(1.6)
        TweenService:Create(LoadingTip, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
        task.wait(0.5)
    end
end)

local LogoReveal = Instance.new("Frame")
LogoReveal.Name = "LogoReveal"
LogoReveal.AnchorPoint = Vector2.new(0.5, 0.5)
LogoReveal.Position = UDim2.new(0.5, 0, 0.5, 0)
LogoReveal.Size = UDim2.new(0, 500, 0, 160)
LogoReveal.BackgroundTransparency = 1
LogoReveal.ZIndex = 510
LogoReveal.Visible = false
LogoReveal.Parent = LoadingScreen

local LogoN = Instance.new("ImageLabel")
LogoN.Name = "LogoN"
LogoN.AnchorPoint = Vector2.new(0.5, 0.5)
LogoN.Position = UDim2.new(0.5, 0, 0.5, 0)
LogoN.Size = UDim2.new(0, 140, 0, 140)
LogoN.BackgroundTransparency = 1
LogoN.Image = CUSTOM_LOGO_ID
LogoN.ScaleType = Enum.ScaleType.Fit
LogoN.ImageColor3 = Color3.fromRGB(255, 255, 255)
LogoN.ImageTransparency = 1
LogoN.ZIndex = 512
LogoN.Parent = LogoReveal

local LogoNGrad = Instance.new("UIGradient")
LogoNGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 175, 165)),
    ColorSequenceKeypoint.new(0.45, Color3.fromRGB(246, 92, 82)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(165, 32, 42))
})
LogoNGrad.Rotation = -35
LogoNGrad.Parent = LogoN

local LettersHolder = Instance.new("Frame")
LettersHolder.Name = "LettersHolder"
LettersHolder.AnchorPoint = Vector2.new(0, 0.5)
LettersHolder.Position = UDim2.new(0.5, -135, 0.5, 0)
LettersHolder.Size = UDim2.new(0, 250, 0, 100)
LettersHolder.BackgroundTransparency = 1
LettersHolder.ZIndex = 511
LettersHolder.Parent = LogoReveal

local LettersLayout = Instance.new("UIListLayout")
LettersLayout.FillDirection = Enum.FillDirection.Horizontal
LettersLayout.SortOrder = Enum.SortOrder.LayoutOrder
LettersLayout.VerticalAlignment = Enum.VerticalAlignment.Center
LettersLayout.Padding = UDim.new(0, 1)
LettersLayout.Parent = LettersHolder

local lettersList = {}
local word = "ursultan"

for i = 1, #word do
    local letter = Instance.new("TextLabel")
    letter.Name = "Letter" .. i
    letter.Size = UDim2.new(0, 0, 1, 0)
    letter.AutomaticSize = Enum.AutomaticSize.X
    letter.BackgroundTransparency = 1
    letter.Text = string.upper(string.sub(word, i, i))
    letter.Font = Enum.Font.GothamBold
    letter.TextSize = 62
    letter.TextColor3 = Color3.fromRGB(255, 255, 255)
    letter.TextTransparency = 1
    letter.TextXAlignment = Enum.TextXAlignment.Left
    letter.ZIndex = 512
    letter.LayoutOrder = i
    letter.Parent = LettersHolder

    local letterGrad = Instance.new("UIGradient")
    letterGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.0, THEME.AccentSoft),
        ColorSequenceKeypoint.new(0.5, THEME.Accent),
        ColorSequenceKeypoint.new(1.0, THEME.AccentDark)
    })
    letterGrad.Rotation = 0
    letterGrad.Parent = letter

    table.insert(lettersList, letter)
end

local LettersGradient = Instance.new("UIGradient")
LettersGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, THEME.AccentSoft),
    ColorSequenceKeypoint.new(0.5, THEME.Accent),
    ColorSequenceKeypoint.new(1.0, THEME.AccentDark)
})
LettersGradient.Rotation = 0
LettersGradient.Parent = LettersHolder

task.spawn(function()
    local offset = 0
    while LoadingScreen.Parent do
        offset = (offset + 0.008) % 1
        if LettersGradient and LettersGradient.Parent then
            LettersGradient.Offset = Vector2.new(offset, 0)
        end
        if LogoNGrad and LogoNGrad.Parent then
            LogoNGrad.Offset = Vector2.new(offset, 0)
        end
        task.wait(0.03)
    end
end)

TweenService:Create(blurEffect, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 24}):Play()
TweenService:Create(LoadingBg, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.15}):Play()

local loadingDone = false

task.spawn(function()
    local steps = { { weight = 1 }, { weight = 2 }, { weight = 3 }, { weight = 2 }, { weight = 2 } }
    local totalWeight = 0
    for _, step in ipairs(steps) do totalWeight = totalWeight + step.weight end

    local accumulated = 0
    for _, step in ipairs(steps) do
        accumulated = accumulated + step.weight
        local targetPercent = accumulated / totalWeight
        local startPercent = (accumulated - step.weight) / totalWeight
        local startTime = os.clock()
        local stepDuration = 0.35 + math.random() * 0.15

        while true do
            local elapsed = os.clock() - startTime
            local progress = math.clamp(elapsed / stepDuration, 0, 1)
            local currentPercent = startPercent + (targetPercent - startPercent) * progress
            LoadingBarFill.Size = UDim2.new(currentPercent, 0, 1, 0)
            LoadingPercent.Text = string.format("%d%%", math.floor(currentPercent * 100))
            if progress >= 1 then break end
            task.wait()
        end
    end

    LoadingBarFill.Size = UDim2.new(1, 0, 1, 0)
    LoadingPercent.Text = "100%"

    task.wait(0.25)

    local fadeOut = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(LoadingTitle, fadeOut, {TextTransparency = 1}):Play()
    TweenService:Create(LoadingPercent, fadeOut, {TextTransparency = 1}):Play()
    TweenService:Create(LoadingBarBg, fadeOut, {BackgroundTransparency = 1}):Play()
    TweenService:Create(LoadingBarFill, fadeOut, {BackgroundTransparency = 1}):Play()
    TweenService:Create(LoadingTip, fadeOut, {TextTransparency = 1}):Play()

    task.wait(0.4)

    LoadingTitle.Visible = false
    LoadingPercent.Visible = false
    LoadingBarBg.Visible = false
    LoadingBarFill.Visible = false
    LoadingTip.Visible = false

    LogoReveal.Visible = true

    LogoN.Position = UDim2.new(0.5, 0, 0.5, 0)
    LogoN.Size = UDim2.new(0, 60, 0, 60)
    LogoN.ImageTransparency = 1

    TweenService:Create(LogoN, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 140, 0, 140),
        ImageTransparency = 0
    }):Play()

    task.wait(0.75)

    local logoShift = TweenService:Create(LogoN, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -165, 0.5, 0),
        Size = UDim2.new(0, 125, 0, 125)
    })
    logoShift:Play()

    LettersHolder.Position = UDim2.new(0.5, -135, 0.5, 0)

    task.wait(0.25)

    for i, letter in ipairs(lettersList) do
        TweenService:Create(letter, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            TextTransparency = 0
        }):Play()
        task.wait(0.06)
    end

    task.wait(0.6)

    local pulseTween = TweenService:Create(LettersHolder, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Position = UDim2.new(0.5, -135, 0.5, -2)
    })
    pulseTween:Play()

    task.wait(1.0)
    pulseTween:Cancel()

    TweenService:Create(LogoN, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 135, 0, 135)
    }):Play()

    task.wait(0.5)

    local flyTween = TweenService:Create(LogoReveal, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, 0, 1.6, 0)
    })
    flyTween:Play()

    TweenService:Create(LogoN, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        ImageTransparency = 1
    }):Play()

    for _, letter in ipairs(lettersList) do
        TweenService:Create(letter, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            TextTransparency = 1
        }):Play()
    end

    flyTween.Completed:Wait()

    TweenService:Create(LoadingBg, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play()
    TweenService:Create(blurEffect, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = 0
    }):Play()

    task.wait(0.35)
    LoadingScreen:Destroy()

    HudContainer.Visible = true

    isOpen = false
    openUI()

    loadingDone = true

    task.wait(0.6)
    notify("nursultan ui", "Loaded successfully!", 4)
    task.wait(0.4)
    notify("Welcome", "Hello, " .. LocalPlayer.DisplayName .. "!", 5)
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if not loadingDone then return end

    if input.KeyCode == hudToggleKey then
        if isOpen then
            closeUI()
        else
            openUI()
        end
    end
end)

end)

if not success then
    warn("[Nursultan UI Error] " .. tostring(err))
end

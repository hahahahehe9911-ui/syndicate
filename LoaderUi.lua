repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

repeat task.wait() until localPlayer:FindFirstChild("PlayerGui")

-- Detect if mobile
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local function new(class, props)
    local inst = Instance.new(class)
    for k,v in pairs(props or {}) do inst[k] = v end
    return inst
end

local blatantv2fix = loadstring(game:HttpGet("https://raw.githubusercontent.com/hahahahehe9911-ui/syndicate/refs/heads/main/moduls/BlatantV2.lua"))()
local TeleportModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hahahahehe9911-ui/syndicate/refs/heads/main/moduls/TeleportModule.lua"))()
local DisableCutscenes = loadstring(game:HttpGet("https://raw.githubusercontent.com/hahahahehe9911-ui/syndicate/refs/heads/main/moduls/DisableCutscenes.lua"))()
local DisableExtras = loadstring(game:HttpGet("https://raw.githubusercontent.com/hahahahehe9911-ui/syndicate/refs/heads/main/moduls/DisableExtras.lua"))()
local NoFishingAnimation = loadstring(game:HttpGet("https://raw.githubusercontent.com/hahahahehe9911-ui/syndicate/refs/heads/main/moduls/NoFishingAnimation.lua"))()
local AutoSell = loadstring(game:HttpGet("https://raw.githubusercontent.com/hahahahehe9911-ui/syndicate/refs/heads/main/moduls/AutoSell.lua"))()
local AntiAFK = loadstring(game:HttpGet("https://raw.githubusercontent.com/hahahahehe9911-ui/syndicate/refs/heads/main/moduls/AntiAFK.lua"))()
local UnlockFPS = loadstring(game:HttpGet("https://raw.githubusercontent.com/hahahahehe9911-ui/syndicate/refs/heads/main/moduls/UnlockFPS.lua"))()
local FPSBooster = loadstring(game:HttpGet("https://raw.githubusercontent.com/hahahahehe9911-ui/syndicate/refs/heads/main/moduls/FpsBooster.lua"))()
local Notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/hahahahehe9911-ui/syndicate/refs/heads/main/moduls/NotificationModule.lua"))()

print("✅ All modules loaded securely!")

-- Galaxy Color Palette
local colors = {
    primary = Color3.fromRGB(255, 140, 0),       -- Purple
    secondary = Color3.fromRGB(147, 112, 219),    -- Medium purple
    accent = Color3.fromRGB(186, 85, 211),        -- Orchid
    galaxy1 = Color3.fromRGB(123, 104, 238),      -- Medium slate blue
    galaxy2 = Color3.fromRGB(72, 61, 139),        -- Dark slate blue
    success = Color3.fromRGB(34, 197, 94),        -- Green
    warning = Color3.fromRGB(251, 191, 36),       -- Amber
    danger = Color3.fromRGB(239, 68, 68),         -- Red
    
    bg1 = Color3.fromRGB(10, 10, 10),             -- Deep black
    bg2 = Color3.fromRGB(18, 18, 18),             -- Dark gray
    bg3 = Color3.fromRGB(25, 25, 25),             -- Medium gray
    bg4 = Color3.fromRGB(35, 35, 35),             -- Light gray
    
    text = Color3.fromRGB(255, 255, 255),
    textDim = Color3.fromRGB(180, 180, 180),
    textDimmer = Color3.fromRGB(120, 120, 120),
    
    border = Color3.fromRGB(50, 50, 50),
    glow = Color3.fromRGB(138, 43, 226),
}

-- Compact Window Size
local windowSize = UDim2.new(0, 420, 0, 280)
local minWindowSize = Vector2.new(380, 250)
local maxWindowSize = Vector2.new(550, 400)

-- Sidebar state (Always expanded, no toggle)
local sidebarWidth = 140

local gui = new("ScreenGui",{
    Name="SyncGUI_Galaxy",
    Parent=localPlayer.PlayerGui,
    IgnoreGuiInset=true,
    ResetOnSpawn=false,
    ZIndexBehavior=Enum.ZIndexBehavior.Sibling,
    DisplayOrder=999999999
})

local function bringToFront()
    -- Langsung set ke nilai maksimal DisplayOrder
    gui.DisplayOrder = 2147483647  -- Nilai Int32 maksimal
    print("🔥 GUI forced to max DisplayOrder:", gui.DisplayOrder)
end

-- Main Window Container - ULTRA TRANSPARENT
local win = new("Frame",{
    Parent=gui,
    Size=windowSize,
    Position=UDim2.new(0.5, -windowSize.X.Offset/2, 0.5, -windowSize.Y.Offset/2),
    BackgroundColor3=colors.bg1,
    BackgroundTransparency=0.25,  -- Lebih transparan dari 0.15
    BorderSizePixel=0,
    ClipsDescendants=false,
    ZIndex=3
})
new("UICorner",{Parent=win, CornerRadius=UDim.new(0, 12)})

-- Subtle outer glow
new("UIStroke",{
    Parent=win,
    Color=colors.primary,
    Thickness=1,
    Transparency=0.9,  -- Lebih transparan dari 0.85
    ApplyStrokeMode=Enum.ApplyStrokeMode.Border
})

-- Inner shadow effect
local innerShadow = new("Frame",{
    Parent=win,
    Size=UDim2.new(1, -2, 1, -2),
    Position=UDim2.new(0, 1, 0, 1),
    BackgroundTransparency=1,
    BorderSizePixel=0,
    ZIndex=2
})
new("UICorner",{Parent=innerShadow, CornerRadius=UDim.new(0, 11)})
new("UIStroke",{
    Parent=innerShadow,
    Color=Color3.fromRGB(0, 0, 0),
    Thickness=1,
    Transparency=0.8  -- Lebih transparan dari 0.7
})

-- Sidebar (Below header, always visible, ULTRA transparent)
local sidebar = new("Frame",{
    Parent=win,
    Size=UDim2.new(0, sidebarWidth, 1, -45),
    Position=UDim2.new(0, 0, 0, 45),
    BackgroundColor3=colors.bg2,
    BackgroundTransparency=0.75,  -- Lebih transparan dari 0.6
    BorderSizePixel=0,
    ClipsDescendants=true,
    ZIndex=4
})
new("UICorner",{Parent=sidebar, CornerRadius=UDim.new(0, 12)})

-- Sidebar subtle border
new("UIStroke",{
    Parent=sidebar,
    Color=colors.primary,
    Thickness=1,
    Transparency=0.95  -- Lebih transparan dari 0.9
})

-- Script Header (INSIDE window, at the top, ULTRA transparent)
local scriptHeader = new("Frame",{
    Parent=win,
    Size=UDim2.new(1, 0, 0, 45),
    Position=UDim2.new(0, 0, 0, 0),
    BackgroundColor3=colors.bg2,
    BackgroundTransparency=0.75,  -- Lebih transparan dari 0.6
    BorderSizePixel=0,
    ZIndex=5
})
new("UICorner",{Parent=scriptHeader, CornerRadius=UDim.new(0, 12)})

-- Subtle gradient overlay
local gradient = new("UIGradient",{
    Parent=scriptHeader,
    Color=ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(72, 61, 139))
    },
    Rotation=45,
    Transparency=NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.97),  -- Lebih transparan
        NumberSequenceKeypoint.new(1, 0.99)   -- Lebih transparan
    }
})

-- Drag Handle for Header (More subtle)
local headerDragHandle = new("Frame",{
    Parent=scriptHeader,
    Size=UDim2.new(0, 40, 0, 3),
    Position=UDim2.new(0.5, -20, 0, 8),
    BackgroundColor3=colors.primary,
    BackgroundTransparency=0.8,  -- Lebih transparan dari 0.7
    BorderSizePixel=0,
    ZIndex=6
})
new("UICorner",{Parent=headerDragHandle, CornerRadius=UDim.new(1, 0)})

-- Drag handle glow effect
new("UIStroke",{
    Parent=headerDragHandle,
    Color=colors.primary,
    Thickness=1,
    Transparency=0.85  -- Lebih transparan dari 0.8
})

-- Title with glow effect
local titleLabel = new("TextLabel",{
    Parent=scriptHeader,
    Text="Syndicate",
    Size=UDim2.new(0, 80, 1, 0),
    Position=UDim2.new(0, 15, 0, 0),
    BackgroundTransparency=1,
    Font=Enum.Font.GothamBold,
    TextSize=17,
    TextColor3=colors.primary,
    TextXAlignment=Enum.TextXAlignment.Left,
    TextStrokeTransparency=0.9,
    TextStrokeColor3=colors.primary,
    ZIndex=6
})

-- Title glow effect
local titleGlow = new("TextLabel",{
    Parent=scriptHeader,
    Text="Syndicate",
    Size=titleLabel.Size,
    Position=titleLabel.Position,
    BackgroundTransparency=1,
    Font=Enum.Font.GothamBold,
    TextSize=17,
    TextColor3=colors.primary,
    TextTransparency=0.7,
    TextXAlignment=Enum.TextXAlignment.Left,
    ZIndex=5
})

-- Animated glow pulse
task.spawn(function()
    while true do
        TweenService:Create(titleGlow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            TextTransparency=0.4
        }):Play()
        task.wait(2)
        TweenService:Create(titleGlow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            TextTransparency=0.7
        }):Play()
        task.wait(2)
    end
end)

-- Separator with glow
local separator = new("Frame",{
    Parent=scriptHeader,
    Size=UDim2.new(0, 2, 0, 25),
    Position=UDim2.new(0, 95, 0.5, -12.5),
    BackgroundColor3=colors.primary,
    BackgroundTransparency=0.3,
    BorderSizePixel=0,
    ZIndex=6
})
new("UICorner",{Parent=separator, CornerRadius=UDim.new(1, 0)})
new("UIStroke",{
    Parent=separator,
    Color=colors.primary,
    Thickness=1,
    Transparency=0.7
})

local subtitleLabel = new("TextLabel",{
    Parent=scriptHeader,
    Text="Free Not For Sale",
    Size=UDim2.new(0, 150, 1, 0),
    Position=UDim2.new(0, 105, 0, 0),
    BackgroundTransparency=1,
    Font=Enum.Font.GothamBold,
    TextSize=9,
    TextColor3=colors.textDim,
    TextXAlignment=Enum.TextXAlignment.Left,
    TextTransparency=0.3,
    ZIndex=6
})

-- Minimize button in header - more polished
local btnMinHeader = new("TextButton",{
    Parent=scriptHeader,
    Size=UDim2.new(0, 30, 0, 30),
    Position=UDim2.new(1, -38, 0.5, -15),
    BackgroundColor3=colors.bg4,
    BackgroundTransparency=0.5,
    BorderSizePixel=0,
    Text="─",
    Font=Enum.Font.GothamBold,
    TextSize=18,
    TextColor3=colors.textDim,
    TextTransparency=0.3,
    AutoButtonColor=false,
    ZIndex=7
})
new("UICorner",{Parent=btnMinHeader, CornerRadius=UDim.new(0, 8)})

local btnStroke = new("UIStroke",{
    Parent=btnMinHeader,
    Color=colors.primary,
    Thickness=0,
    Transparency=0.8
})

btnMinHeader.MouseEnter:Connect(function()
    TweenService:Create(btnMinHeader, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
        BackgroundColor3=colors.galaxy1,
        BackgroundTransparency=0.2,
        TextColor3=colors.text,
        TextTransparency=0,
        Size=UDim2.new(0, 32, 0, 32)
    }):Play()
    TweenService:Create(btnStroke, TweenInfo.new(0.25), {
        Thickness=1.5,
        Transparency=0.4
    }):Play()
end)

btnMinHeader.MouseLeave:Connect(function()
    TweenService:Create(btnMinHeader, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
        BackgroundColor3=colors.bg4,
        BackgroundTransparency=0.5,
        TextColor3=colors.textDim,
        TextTransparency=0.3,
        Size=UDim2.new(0, 30, 0, 30)
    }):Play()
    TweenService:Create(btnStroke, TweenInfo.new(0.25), {
        Thickness=0,
        Transparency=0.8
    }):Play()
end)

-- Navigation Container (Below header) - PADDING DIPERBAIKI
local navContainer = new("ScrollingFrame",{
    Parent=sidebar,
    Size=UDim2.new(1, -8, 1, -12),  -- Padding kiri kanan 4px, atas bawah 6px
    Position=UDim2.new(0, 4, 0, 6),  -- Posisi dari (2,48) ke (4,6)
    BackgroundTransparency=1,
    ScrollBarThickness=2,
    ScrollBarImageColor3=colors.primary,
    BorderSizePixel=0,
    CanvasSize=UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize=Enum.AutomaticSize.Y,
    ClipsDescendants=true,
    ZIndex=5
})
new("UIListLayout",{
    Parent=navContainer,
    Padding=UDim.new(0, 4),
    SortOrder=Enum.SortOrder.LayoutOrder
})

-- Content Area (Below header, ULTRA transparent) - POSISI DIPERBAIKI
local contentBg = new("Frame",{
    Parent=win,
    Size=UDim2.new(1, -(sidebarWidth + 10), 1, -52),  -- Padding kanan 10px, bawah 52px
    Position=UDim2.new(0, sidebarWidth + 5, 0, 47),  -- Padding kiri 5px, atas 47px
    BackgroundColor3=colors.bg2,
    BackgroundTransparency=0.8,  -- Lebih transparan dari 0.7
    BorderSizePixel=0,
    ClipsDescendants=true,
    ZIndex=4
})
new("UICorner",{Parent=contentBg, CornerRadius=UDim.new(0, 12)})

-- Content area subtle border
new("UIStroke",{
    Parent=contentBg,
    Color=colors.primary,
    Thickness=1,
    Transparency=0.95  -- Lebih transparan dari 0.92
})

-- Top Bar (Page Title, ULTRA transparent) - PADDING DIPERBAIKI
local topBar = new("Frame",{
    Parent=contentBg,
    Size=UDim2.new(1, -8, 0, 32),  -- Padding kiri kanan 4px
    Position=UDim2.new(0, 4, 0, 4),  -- Padding atas 4px
    BackgroundColor3=colors.bg3,
    BackgroundTransparency=0.8,  -- Lebih transparan dari 0.7
    BorderSizePixel=0,
    ZIndex=5
})
new("UICorner",{Parent=topBar, CornerRadius=UDim.new(0, 10)})

-- Topbar glow
new("UIStroke",{
    Parent=topBar,
    Color=colors.primary,
    Thickness=1,
    Transparency=0.95  -- Lebih transparan dari 0.93
})

local pageTitle = new("TextLabel",{
    Parent=topBar,
    Text="Main Dashboard",
    Size=UDim2.new(1, -20, 1, 0),
    Position=UDim2.new(0, 12, 0, 0),
    Font=Enum.Font.GothamBold,
    TextSize=11,
    BackgroundTransparency=1,
    TextColor3=colors.text,
    TextTransparency=0.2,
    TextXAlignment=Enum.TextXAlignment.Left,
    ZIndex=6
})

-- Resize Handle - more polished
local resizeHandle = new("TextButton",{
    Parent=win,
    Size=UDim2.new(0, 18, 0, 18),
    Position=UDim2.new(1, -18, 1, -18),
    BackgroundColor3=colors.bg3,
    BackgroundTransparency=0.6,
    BorderSizePixel=0,
    Text="⋰",
    Font=Enum.Font.GothamBold,
    TextSize=11,
    TextColor3=colors.textDim,
    TextTransparency=0.4,
    AutoButtonColor=false,
    ZIndex=100
})
new("UICorner",{Parent=resizeHandle, CornerRadius=UDim.new(0, 6)})

local resizeStroke = new("UIStroke",{
    Parent=resizeHandle,
    Color=colors.primary,
    Thickness=0,
    Transparency=0.8
})

resizeHandle.MouseEnter:Connect(function()
    TweenService:Create(resizeHandle, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
        BackgroundTransparency=0.3,
        TextTransparency=0,
        Size=UDim2.new(0, 20, 0, 20)
    }):Play()
    TweenService:Create(resizeStroke, TweenInfo.new(0.25), {
        Thickness=1.5,
        Transparency=0.5
    }):Play()
end)

resizeHandle.MouseLeave:Connect(function()
    if not resizing then
        TweenService:Create(resizeHandle, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
            BackgroundTransparency=0.6,
            TextTransparency=0.4,
            Size=UDim2.new(0, 18, 0, 18)
        }):Play()
        TweenService:Create(resizeStroke, TweenInfo.new(0.25), {
            Thickness=0,
            Transparency=0.8
        }):Play()
    end
end)

-- Pages - PADDING DIPERBAIKI
local pages = {}
local currentPage = "Main"
local navButtons = {}

local function createPage(name)
    local page = new("ScrollingFrame",{
        Parent=contentBg,
        Size=UDim2.new(1, -16, 1, -44),  -- Padding kiri kanan 8px, bawah 44px
        Position=UDim2.new(0, 8, 0, 40),  -- Padding kiri 8px, atas 40px (32+8)
        BackgroundTransparency=1,
        ScrollBarThickness=3,
        ScrollBarImageColor3=colors.primary,
        BorderSizePixel=0,
        CanvasSize=UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize=Enum.AutomaticSize.Y,
        Visible=false,
        ClipsDescendants=true,
        ZIndex=5
    })
    new("UIListLayout",{
        Parent=page,
        Padding=UDim.new(0, 8),
        SortOrder=Enum.SortOrder.LayoutOrder
    })
    new("UIPadding",{
        Parent=page,
        PaddingTop=UDim.new(0, 4),
        PaddingBottom=UDim.new(0, 4),
        PaddingLeft=UDim.new(0, 0),
        PaddingRight=UDim.new(0, 0)
    })
    pages[name] = page
    return page
end

local mainPage = createPage("Main")
local teleportPage = createPage("Teleport")
local questPage = createPage("Quest")
local shopPage = createPage("Shop")
local webhookPage = createPage("Webhook")
local cameraViewPage = createPage("CameraView")
local settingsPage = createPage("Settings")
local infoPage = createPage("Info")
mainPage.Visible = true

-- LynxGUI_v2.3.lua - Galaxy Edition (REFINED)
-- BAGIAN 2: Navigation, UI Components (Toggle, Input Horizontal, Dropdown, Button, Category)

-- Nav Button - PADDING DIPERBAIKI, lebih transparan
local function createNavButton(text, icon, page, order)
    local btn = new("TextButton",{
        Parent=navContainer,
        Size=UDim2.new(1, 0, 0, 38),
        BackgroundColor3=page == currentPage and colors.bg3 or Color3.fromRGB(0, 0, 0),
        BackgroundTransparency=page == currentPage and 0.7 or 1,  -- Lebih transparan
        BorderSizePixel=0,
        Text="",
        AutoButtonColor=false,
        LayoutOrder=order,
        ZIndex=6
    })
    new("UICorner",{Parent=btn, CornerRadius=UDim.new(0, 9)})
    
    local indicator = new("Frame",{
        Parent=btn,
        Size=UDim2.new(0, 3, 0, 20),
        Position=UDim2.new(0, 0, 0.5, -10),
        BackgroundColor3=colors.primary,
        BorderSizePixel=0,
        Visible=page == currentPage,
        ZIndex=7
    })
    new("UICorner",{Parent=indicator, CornerRadius=UDim.new(1, 0)})
    
    -- Indicator glow
    new("UIStroke",{
        Parent=indicator,
        Color=colors.primary,
        Thickness=2,
        Transparency=0.7
    })
    
    local iconLabel = new("TextLabel",{
        Parent=btn,
        Text=icon,
        Size=UDim2.new(0, 30, 1, 0),
        Position=UDim2.new(0, 10, 0, 0),
        BackgroundTransparency=1,
        Font=Enum.Font.GothamBold,
        TextSize=15,
        TextColor3=page == currentPage and colors.primary or colors.textDim,
        TextTransparency=page == currentPage and 0 or 0.3,
        ZIndex=7
    })
    
    local textLabel = new("TextLabel",{
        Parent=btn,
        Text=text,
        Size=UDim2.new(1, -45, 1, 0),
        Position=UDim2.new(0, 40, 0, 0),
        BackgroundTransparency=1,
        Font=Enum.Font.GothamBold,
        TextSize=10,
        TextColor3=page == currentPage and colors.text or colors.textDim,
        TextTransparency=page == currentPage and 0.1 or 0.4,
        TextXAlignment=Enum.TextXAlignment.Left,
        ZIndex=7
    })
    
    -- Smooth hover effect
    btn.MouseEnter:Connect(function()
        if page ~= currentPage then
            TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                BackgroundTransparency=0.8  -- Lebih transparan
            }):Play()
            TweenService:Create(iconLabel, TweenInfo.new(0.3), {
                TextTransparency=0,
                TextColor3=colors.primary
            }):Play()
            TweenService:Create(textLabel, TweenInfo.new(0.3), {
                TextTransparency=0.2
            }):Play()
        end
    end)
    
    btn.MouseLeave:Connect(function()
        if page ~= currentPage then
            TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                BackgroundTransparency=1
            }):Play()
            TweenService:Create(iconLabel, TweenInfo.new(0.3), {
                TextTransparency=0.3,
                TextColor3=colors.textDim
            }):Play()
            TweenService:Create(textLabel, TweenInfo.new(0.3), {
                TextTransparency=0.4
            }):Play()
        end
    end)
    
    navButtons[page] = {btn=btn, icon=iconLabel, text=textLabel, indicator=indicator}
    
    return btn
end

local function switchPage(pageName, pageTitle_text)
    if currentPage == pageName then return end
    for _, page in pairs(pages) do page.Visible = false end
    
    for name, btnData in pairs(navButtons) do
        local isActive = name == pageName
        TweenService:Create(btnData.btn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            BackgroundColor3=isActive and colors.bg3 or Color3.fromRGB(0, 0, 0),
            BackgroundTransparency=isActive and 0.7 or 1  -- Lebih transparan
        }):Play()
        btnData.indicator.Visible = isActive
        TweenService:Create(btnData.icon, TweenInfo.new(0.3), {
            TextColor3=isActive and colors.primary or colors.textDim,
            TextTransparency=isActive and 0 or 0.3
        }):Play()
        TweenService:Create(btnData.text, TweenInfo.new(0.3), {
            TextColor3=isActive and colors.text or colors.textDim,
            TextTransparency=isActive and 0.1 or 0.4
        }):Play()
    end
    
    pages[pageName].Visible = true
    pageTitle.Text = pageTitle_text
    currentPage = pageName
end

local btnMain = createNavButton("Dashboard", "🏠", "Main", 1)
local btnTeleport = createNavButton("Teleport", "🌍", "Teleport", 2)
local btnQuest = createNavButton("Quest", "📜", "Quest", 3)
local btnShop = createNavButton("Shop", "🛒", "Shop", 3)
local btnWebhook = createNavButton("Webhook", "🔗", "Webhook", 4)
local btnCameraView = createNavButton("Camera View", "📷", "Camera View", 3)
local btnSettings = createNavButton("Settings", "⚙️", "Settings", 4)
local btnInfo = createNavButton("About", "ℹ️", "Info", 5)

btnMain.MouseButton1Click:Connect(function() switchPage("Main", "Main Dashboard") end)
btnTeleport.MouseButton1Click:Connect(function() switchPage("Teleport", "Teleport System") end)
btnQuest.MouseButton1Click:Connect(function() switchPage("Quest", "SOON!") end)
btnShop.MouseButton1Click:Connect(function() switchPage("Shop", "Shop Features") end)
btnWebhook.MouseButton1Click:Connect(function() switchPage("Webhook", "Webhook Page") end)
btnCameraView.MouseButton1Click:Connect(function() switchPage("CameraView", "SOON!") end)
btnSettings.MouseButton1Click:Connect(function() switchPage("Settings", "Settings") end)
btnInfo.MouseButton1Click:Connect(function() switchPage("Info", "About Syndicate") end)

local function makeCategory(parent, title, icon)
    local categoryFrame = new("Frame",{
        Parent=parent,
        Size=UDim2.new(1, 0, 0, 36),
        BackgroundColor3=colors.bg3,
        BackgroundTransparency=0.6,
        BorderSizePixel=0,
        AutomaticSize=Enum.AutomaticSize.Y,
        ClipsDescendants=false,
        ZIndex=6
    })
    new("UICorner",{Parent=categoryFrame, CornerRadius=UDim.new(0, 6)})
    
    local categoryStroke = new("UIStroke",{
        Parent=categoryFrame,
        Color=colors.border,
        Thickness=0,
        Transparency=0.8
    })
    
    local header = new("TextButton",{
        Parent=categoryFrame,
        Size=UDim2.new(1, 0, 0, 36),
        BackgroundTransparency=1,
        Text="",
        AutoButtonColor=false,
        ClipsDescendants=true,
        ZIndex=7
    })
    
    local titleLabel = new("TextLabel",{
        Parent=header,
        Text=title,
        Size=UDim2.new(1, -50, 1, 0),
        Position=UDim2.new(0, 8, 0, 0),
        BackgroundTransparency=1,
        Font=Enum.Font.GothamBold,
        TextSize=11,
        TextColor3=colors.text,
        TextXAlignment=Enum.TextXAlignment.Left,
        ZIndex=8
    })
    
    local arrow = new("TextLabel",{
        Parent=header,
        Text="▼",
        Size=UDim2.new(0, 20, 1, 0),
        Position=UDim2.new(1, -24, 0, 0),
        BackgroundTransparency=1,
        Font=Enum.Font.GothamBold,
        TextSize=10,
        TextColor3=colors.primary,
        ZIndex=8
    })
    
    local contentContainer = new("Frame",{
        Parent=categoryFrame,
        Size=UDim2.new(1, -16, 0, 0),
        Position=UDim2.new(0, 8, 0, 38),
        BackgroundTransparency=1,
        Visible=false,
        AutomaticSize=Enum.AutomaticSize.Y,
        ClipsDescendants=true,
        ZIndex=7
    })
    new("UIListLayout",{Parent=contentContainer, Padding=UDim.new(0, 6)})
    new("UIPadding",{Parent=contentContainer, PaddingBottom=UDim.new(0, 8)})
    
    local isOpen = false
    header.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        contentContainer.Visible = isOpen
        TweenService:Create(arrow, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Rotation=isOpen and 180 or 0}):Play()
        TweenService:Create(categoryFrame, TweenInfo.new(0.25), {
            BackgroundTransparency=isOpen and 0.4 or 0.6
        }):Play()
        TweenService:Create(categoryStroke, TweenInfo.new(0.25), {Thickness=isOpen and 1 or 0}):Play()
    end)
    
    return contentContainer
end

-- Toggle - ALIGNMENT DIPERBAIKI
local function makeToggle(parent, label, callback)
    local frame = new("Frame",{
        Parent=parent,
        Size=UDim2.new(1, 0, 0, 32),
        BackgroundTransparency=1,
        ZIndex=7
    })
    
    local labelText = new("TextLabel",{
        Parent=frame,
        Text=label,
        Size=UDim2.new(0.68, 0, 1, 0),  -- 68% untuk label
        Position=UDim2.new(0, 0, 0, 0),
        TextXAlignment=Enum.TextXAlignment.Left,
        BackgroundTransparency=1,
        TextColor3=colors.text,
        Font=Enum.Font.GothamBold,
        TextSize=9,
        TextWrapped=true,
        ZIndex=8
    })
    
    local toggleBg = new("Frame",{
        Parent=frame,
        Size=UDim2.new(0, 38, 0, 20),
        Position=UDim2.new(1, -38, 0.5, -10),  -- Align ke kanan
        BackgroundColor3=colors.bg4,
        BorderSizePixel=0,
        ZIndex=8
    })
    new("UICorner",{Parent=toggleBg, CornerRadius=UDim.new(1, 0)})
    
    local toggleCircle = new("Frame",{
        Parent=toggleBg,
        Size=UDim2.new(0, 16, 0, 16),
        Position=UDim2.new(0, 2, 0.5, -8),
        BackgroundColor3=colors.textDim,
        BorderSizePixel=0,
        ZIndex=9
    })
    new("UICorner",{Parent=toggleCircle, CornerRadius=UDim.new(1, 0)})
    
    local btn = new("TextButton",{
        Parent=toggleBg,
        Size=UDim2.new(1, 0, 1, 0),
        BackgroundTransparency=1,
        Text="",
        ZIndex=10
    })
    
    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on
        TweenService:Create(toggleBg, TweenInfo.new(0.25), {BackgroundColor3=on and colors.primary or colors.bg4}):Play()
        TweenService:Create(toggleCircle, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Position=on and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
            BackgroundColor3=on and colors.text or colors.textDim
        }):Play()
        callback(on)
    end)
end

-- Input HORIZONTAL - ALIGNMENT DIPERBAIKI & LEBIH TRANSPARAN
local function makeInput(parent, label, defaultValue, callback)
    local frame = new("Frame",{
        Parent=parent,
        Size=UDim2.new(1, 0, 0, 32),
        BackgroundTransparency=1,
        ZIndex=7
    })
    
    local lbl = new("TextLabel",{
        Parent=frame,
        Text=label,
        Size=UDim2.new(0.55, 0, 1, 0),  -- 55% untuk label
        Position=UDim2.new(0, 0, 0, 0),
        BackgroundTransparency=1,
        TextColor3=colors.text,
        TextXAlignment=Enum.TextXAlignment.Left,
        Font=Enum.Font.GothamBold,
        TextSize=9,
        ZIndex=8
    })
    
    local inputBg = new("Frame",{
        Parent=frame,
        Size=UDim2.new(0.42, 0, 0, 28),  -- 42% untuk input
        Position=UDim2.new(0.58, 0, 0.5, -14),  -- Align ke kanan
        BackgroundColor3=colors.bg4,
        BackgroundTransparency=0.4,  -- Lebih transparan dari 0.3
        BorderSizePixel=0,
        ZIndex=8
    })
    new("UICorner",{Parent=inputBg, CornerRadius=UDim.new(0, 6)})
    
    local inputStroke = new("UIStroke",{
        Parent=inputBg,
        Color=colors.border,
        Thickness=1,
        Transparency=0.7  -- Lebih transparan dari 0.6
    })
    
    local inputBox = new("TextBox",{
        Parent=inputBg,
        Size=UDim2.new(1, -12, 1, 0),
        Position=UDim2.new(0, 6, 0, 0),
        BackgroundTransparency=1,
        Text=tostring(defaultValue),
        PlaceholderText="0.00",
        Font=Enum.Font.GothamBold,
        TextSize=9,
        TextColor3=colors.text,
        PlaceholderColor3=colors.textDimmer,
        TextXAlignment=Enum.TextXAlignment.Center,
        ClearTextOnFocus=false,
        ZIndex=9
    })
    
    inputBox.Focused:Connect(function()
        TweenService:Create(inputStroke, TweenInfo.new(0.2), {
            Color=colors.primary,
            Thickness=1.5,
            Transparency=0.3
        }):Play()
    end)
    
    inputBox.FocusLost:Connect(function()
        TweenService:Create(inputStroke, TweenInfo.new(0.2), {
            Color=colors.border,
            Thickness=1,
            Transparency=0.7  -- Lebih transparan dari 0.6
        }):Play()
        
        local value = tonumber(inputBox.Text)
        if value then
            callback(value)
        else
            inputBox.Text = tostring(defaultValue)
        end
    end)
end

local function makeDropdown(parent, title, icon, items, onSelect, uniqueId)
    local dropdownFrame = new("Frame",{
        Parent=parent,
        Size=UDim2.new(1, 0, 0, 40),
        BackgroundColor3=colors.bg4,
        BackgroundTransparency=0.5,  -- Lebih transparan dari 0.4
        BorderSizePixel=0,
        AutomaticSize=Enum.AutomaticSize.Y,
        ZIndex=7,
        Name=uniqueId or "Dropdown"
    })
    new("UICorner",{Parent=dropdownFrame, CornerRadius=UDim.new(0, 6)})
    
    local dropStroke = new("UIStroke",{
        Parent=dropdownFrame,
        Color=colors.border,
        Thickness=0,
        Transparency=0.8  -- Lebih transparan dari 0.7
    })
    
    local header = new("TextButton",{
        Parent=dropdownFrame,
        Size=UDim2.new(1, -12, 0, 36),
        Position=UDim2.new(0, 6, 0, 2),
        BackgroundTransparency=1,
        Text="",
        AutoButtonColor=false,
        ZIndex=8
    })
    
    local iconLabel = new("TextLabel",{
        Parent=header,
        Text=icon,
        Size=UDim2.new(0, 24, 1, 0),
        BackgroundTransparency=1,
        Font=Enum.Font.GothamBold,
        TextSize=12,
        TextColor3=colors.primary,
        TextXAlignment=Enum.TextXAlignment.Left,
        ZIndex=9
    })
    
    local titleLabel = new("TextLabel",{
        Parent=header,
        Text=title,
        Size=UDim2.new(1, -70, 0, 14),
        Position=UDim2.new(0, 26, 0, 4),
        BackgroundTransparency=1,
        Font=Enum.Font.GothamBold,
        TextSize=9,
        TextColor3=colors.text,
        TextXAlignment=Enum.TextXAlignment.Left,
        ZIndex=9
    })
    
    local statusLabel = new("TextLabel",{
        Parent=header,
        Text="None Selected",
        Size=UDim2.new(1, -70, 0, 12),
        Position=UDim2.new(0, 26, 0, 20),
        BackgroundTransparency=1,
        Font=Enum.Font.GothamBold,
        TextSize=8,
        TextColor3=colors.textDimmer,
        TextXAlignment=Enum.TextXAlignment.Left,
        ZIndex=9
    })
    
    local arrow = new("TextLabel",{
        Parent=header,
        Text="▼",
        Size=UDim2.new(0, 24, 1, 0),
        Position=UDim2.new(1, -24, 0, 0),
        BackgroundTransparency=1,
        Font=Enum.Font.GothamBold,
        TextSize=10,
        TextColor3=colors.primary,
        ZIndex=9
    })
    
    local listContainer = new("ScrollingFrame",{
        Parent=dropdownFrame,
        Size=UDim2.new(1, -12, 0, 0),
        Position=UDim2.new(0, 6, 0, 42),
        BackgroundTransparency=1,
        Visible=false,
        AutomaticCanvasSize=Enum.AutomaticSize.Y,
        CanvasSize=UDim2.new(0, 0, 0, 0),
        ScrollBarThickness=2,
        ScrollBarImageColor3=colors.primary,
        BorderSizePixel=0,
        ClipsDescendants=true,
        ZIndex=10
    })
    new("UIListLayout",{Parent=listContainer, Padding=UDim.new(0, 4)})
    new("UIPadding",{Parent=listContainer, PaddingBottom=UDim.new(0, 8)})
    
    local isOpen = false
    local selectedItem = nil
    
    header.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        listContainer.Visible = isOpen
        
        TweenService:Create(arrow, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Rotation=isOpen and 180 or 0}):Play()
        TweenService:Create(dropdownFrame, TweenInfo.new(0.25), {
            BackgroundTransparency=isOpen and 0.35 or 0.5  -- Lebih transparan
        }):Play()
        TweenService:Create(dropStroke, TweenInfo.new(0.25), {Thickness=isOpen and 1 or 0}):Play()
        
        if isOpen then
            listContainer.Size = UDim2.new(1, -12, 0, math.min(#items * 28, 140))
        end
    end)
    
    for _, itemName in ipairs(items) do
        local itemBtn = new("TextButton",{
            Parent=listContainer,
            Size=UDim2.new(1, 0, 0, 26),
            BackgroundColor3=colors.bg4,
            BackgroundTransparency=0.6,  -- Lebih transparan dari 0.5
            BorderSizePixel=0,
            Text="",
            AutoButtonColor=false,
            ZIndex=11
        })
        new("UICorner",{Parent=itemBtn, CornerRadius=UDim.new(0, 5)})
        
        local itemStroke = new("UIStroke",{
            Parent=itemBtn,
            Color=colors.border,
            Thickness=0,
            Transparency=0.8  -- Lebih transparan dari 0.7
        })
        
        local btnLabel = new("TextLabel",{
            Parent=itemBtn,
            Text=itemName,
            Size=UDim2.new(1, -12, 1, 0),
            Position=UDim2.new(0, 6, 0, 0),
            BackgroundTransparency=1,
            Font=Enum.Font.GothamBold,
            TextSize=8,
            TextColor3=colors.textDim,
            TextXAlignment=Enum.TextXAlignment.Left,
            TextTruncate=Enum.TextTruncate.AtEnd,
            ZIndex=12
        })
        
        itemBtn.MouseEnter:Connect(function()
            if selectedItem ~= itemName then
                TweenService:Create(itemBtn, TweenInfo.new(0.2), {
                    BackgroundColor3=colors.primary,
                    BackgroundTransparency=0.3
                }):Play()
                TweenService:Create(btnLabel, TweenInfo.new(0.2), {TextColor3=colors.text}):Play()
                TweenService:Create(itemStroke, TweenInfo.new(0.2), {Thickness=1}):Play()
            end
        end)
        
        itemBtn.MouseLeave:Connect(function()
            if selectedItem ~= itemName then
                TweenService:Create(itemBtn, TweenInfo.new(0.2), {
                    BackgroundColor3=colors.bg4,
                    BackgroundTransparency=0.6
                }):Play()
                TweenService:Create(btnLabel, TweenInfo.new(0.2), {TextColor3=colors.textDim}):Play()
                TweenService:Create(itemStroke, TweenInfo.new(0.2), {Thickness=0}):Play()
            end
        end)
        
        itemBtn.MouseButton1Click:Connect(function()
            selectedItem = itemName
            statusLabel.Text = "✓ " .. itemName
            statusLabel.TextColor3 = colors.success
            onSelect(itemName)
            
            task.wait(0.1)
            isOpen = false
            listContainer.Visible = false
            TweenService:Create(arrow, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Rotation=0}):Play()
            TweenService:Create(dropdownFrame, TweenInfo.new(0.25), {
                BackgroundTransparency=0.5
            }):Play()
            TweenService:Create(dropStroke, TweenInfo.new(0.25), {Thickness=0}):Play()
        end)
    end
    
    return dropdownFrame
end

-- Button - LEBIH TRANSPARAN
local function makeButton(parent, label, callback)
    local btnFrame = new("Frame",{
        Parent=parent,
        Size=UDim2.new(1, 0, 0, 32),
        BackgroundColor3=colors.primary,
        BackgroundTransparency=0.3,  -- Lebih transparan dari 0.2
        BorderSizePixel=0,
        ZIndex=8
    })
    new("UICorner",{Parent=btnFrame, CornerRadius=UDim.new(0, 6)})
    
    local btnStroke = new("UIStroke",{
        Parent=btnFrame,
        Color=colors.primary,
        Thickness=0,
        Transparency=0.7  -- Lebih transparan dari 0.6
    })
    
    local button = new("TextButton",{
        Parent=btnFrame,
        Size=UDim2.new(1, 0, 1, 0),
        BackgroundTransparency=1,
        Text=label,
        Font=Enum.Font.GothamBold,
        TextSize=10,
        TextColor3=colors.text,
        AutoButtonColor=false,
        ZIndex=9
    })
    
    button.MouseEnter:Connect(function()
        TweenService:Create(btnFrame, TweenInfo.new(0.2), {
            BackgroundTransparency=0.1,  -- Lebih transparan dari 0
            Size=UDim2.new(1, 0, 0, 35)
        }):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.2), {Thickness=1.5}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(btnFrame, TweenInfo.new(0.2), {
            BackgroundTransparency=0.3,
            Size=UDim2.new(1, 0, 0, 32)
        }):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.2), {Thickness=0}):Play()
    end)
    
    button.MouseButton1Click:Connect(function()
        TweenService:Create(btnFrame, TweenInfo.new(0.1), {Size=UDim2.new(0.98, 0, 0, 30)}):Play()
        task.wait(0.1)
        TweenService:Create(btnFrame, TweenInfo.new(0.1), {Size=UDim2.new(1, 0, 0, 32)}):Play()
        pcall(callback)
    end)
    
    return btnFrame
end

--- MAIN
local catBlatantV2 = makeCategory(mainPage, "Blatant Tester", "🎯")

-- Toggle
makeToggle(catBlatantV2, "Blatant Tester", function(on) 
    if on then 
        blatantv2fix.Start() 
    else 
        blatantv2fix.Stop() 
    end 
end)

-- Complete Delay Input
makeInput(catBlatantV2, "Complete Delay", 0.5, function(v)
    blatantv2fix.Settings.CompleteDelay = v
    print("✅ Complete Delay set to: " .. v)
end)

-- Cancel Delay Input
makeInput(catBlatantV2, "Cancel Delay", 0.1, function(v)
    blatantv2fix.Settings.CancelDelay = v
    print("✅ Cancel Delay set to: " .. v)
end)

-- supoort
local catSupport = makeCategory(mainPage, "Support Features", "🛠️")

makeToggle(catSupport, "No Fishing Animation", function(on)
    if on then
        NoFishingAnimation.StartWithDelay()
    else
        NoFishingAnimation.Stop()
    end
end)

makeToggle(catSupport, "Disable Cutscenes", function(on)
    if on then
        local success = DisableCutscenes.Start()
        if success then
            Notify.Send("Disable Cutscenes", "✓ Semua cutscenes dimatikan!", 4)
        else
            Notify.Send("Disable Cutscenes", "⚠ Sudah aktif!", 3)
        end
    else
        local success = DisableCutscenes.Stop()
        if success then
            Notify.Send("Disable Cutscenes", "✓ Cutscenes kembali normal.", 4)
        else
            Notify.Send("Disable Cutscenes", "⚠ Sudah nonaktif!", 3)
        end
    end
end)

-- Toggle Skin Effect
makeToggle(catSupport, "Disable Skin Effect", function(on)
    if on then
        DisableExtras.StartSkinEffect()
        Notify.Send("Disable Skin Effect", "✓ Skin effect dihapus!", 4)
    else
        DisableExtras.StopSkinEffect()
        Notify.Send("Disable Skin Effect", "Skin effect bisa muncul kembali.", 3)
    end
end)

local locationItems = {}
for name, _ in pairs(TeleportModule.Locations) do
    table.insert(locationItems, name)
end
table.sort(locationItems)

makeDropdown(teleportPage, "Teleport to Location", "📍", locationItems, function(selectedLocation)
    TeleportModule.TeleportTo(selectedLocation)
end, "LocationTeleport")

local playerItems = {}
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= localPlayer then
        table.insert(playerItems, player.Name)
    end
end
table.sort(playerItems)

local catSell = makeCategory(shopPage, "Sell All", "💰")

makeButton(catSell, "Sell All Now", function()
    if AutoSell and AutoSell.SellOnce then
        AutoSell.SellOnce()
    end
end)

local catAFK = makeCategory(settingsPage, "Anti-AFK Protection", "🧍‍♂️")

makeToggle(catAFK, "Enable Anti-AFK", function(on)
    if on then
        AntiAFK.Start()
    else
        AntiAFK.Stop()
    end
end)

local catBoost = makeCategory(settingsPage, "FPS Booster", "⚡")

makeToggle(catBoost, "Enable FPS Booster", function(on)
    if not FPSBooster then
        Notify.Send("FPS Booster", "Module FPSBooster gagal dimuat!", 3)
        return
    end

    if on then
        FPSBooster.Enable()
        Notify.Send("FPS Booster", "FPS Booster diaktifkan!", 3)
    else
        FPSBooster.Disable()
        Notify.Send("FPS Booster", "FPS Booster dimatikan.", 3)
    end
end)


local catFPS = makeCategory(settingsPage, "FPS Unlocker", "🎞️")

makeDropdown(catFPS, "Select FPS Limit", "⚙️", {"60 FPS", "90 FPS", "120 FPS", "240 FPS"}, function(selected)
    local fpsValue = tonumber(selected:match("%d+"))
    if fpsValue and UnlockFPS and UnlockFPS.SetCap then
        UnlockFPS.SetCap(fpsValue)
    end
end, "FPSDropdown")

local HideStats = loadstring(game:HttpGet("https://raw.githubusercontent.com/hahahahehe9911-ui/syndicate/refs/heads/main/moduls/hides.lua"))()
local hideStatsLoaded = (HideStats ~= nil)

if not hideStatsLoaded then
    warn("⚠️ HideStats module failed to load")
else
    print("✅ HideStats module loaded successfully")
end  -- ⬅️ HAPUS PARENTHESIS DI SINI

-- ==== SETTINGS PAGE - HIDE STATS CATEGORY ====
-- Letakkan ini di bagian Settings Page Anda (setelah FPS Unlocker category)

local catHideStats = makeCategory(settingsPage, "Hide Stats Identifier", "👤")

-- ============================
-- INFO CONTAINER
-- ============================
local hideStatsInfoContainer = new("Frame", {
    Parent = catHideStats,
    Size = UDim2.new(1, 0, 0, 85),
    BackgroundColor3 = colors.bg3,
    BackgroundTransparency = 0.8,
    BorderSizePixel = 0,
    ZIndex = 7
})

new("UICorner", {
    Parent = hideStatsInfoContainer,
    CornerRadius = UDim.new(0, 8)
})

new("UIStroke", {
    Parent = hideStatsInfoContainer,
    Color = colors.border,
    Thickness = 1,
    Transparency = 0.95
})

local hideStatsInfoText = new("TextLabel", {
    Parent = hideStatsInfoContainer,
    Size = UDim2.new(1, -24, 1, -24),
    Position = UDim2.new(0, 12, 0, 12),
    BackgroundTransparency = 1,
    Text = [[📌 HIDE STATS INFO
━━━━━━━━━━━━━━━━━━━━━━
Sembunyikan nama dan level asli Anda!
Masukkan fake name & level di bawah.]],
    Font = Enum.Font.GothamBold,
    TextSize = 11,
    TextColor3 = colors.text,
    TextTransparency = 0.2,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    ZIndex = 8
})

-- ============================
-- TOGGLE ENABLE HIDE STATS
-- ============================
makeToggle(catHideStats, "⚡ Enable Hide Stats", function(on)
    if not hideStatsLoaded or not HideStats then
        Notify.Send("Hide Stats", "Module Hide Stats belum dimuat, tunggu sebentar...", 3)
        return
    end
    
    if on then
        HideStats.Enable()
        Notify.Send("Hide Stats ✨", "Hide Stats aktif! '-Syndicate-' berkilau di atas nama.", 3)
    else
        HideStats.Disable()
        Notify.Send("Hide Stats", "Hide Stats dimatikan.", 3)
    end
end)

-- ============================
-- INPUT FAKE NAME
-- ============================
local currentFakeName = "Guest"

local fakeNameContainer = new("Frame", {
    Parent = catHideStats,
    Size = UDim2.new(1, 0, 0, 80),
    BackgroundColor3 = colors.bg2,
    BackgroundTransparency = 0.8,
    BorderSizePixel = 0,
    ZIndex = 7
})

new("UICorner", {
    Parent = fakeNameContainer,
    CornerRadius = UDim.new(0, 8)
})

new("UIStroke", {
    Parent = fakeNameContainer,
    Color = colors.border,
    Thickness = 1,
    Transparency = 0.95
})

local fakeNameLabel = new("TextLabel", {
    Parent = fakeNameContainer,
    Size = UDim2.new(1, -20, 0, 22),
    Position = UDim2.new(0, 10, 0, 8),
    BackgroundTransparency = 1,
    Text = "Fake Name",
    Font = Enum.Font.GothamBold,
    TextSize = 11,
    TextColor3 = colors.text,
    TextTransparency = 0.2,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 8
})

local fakeNameTextBox = new("TextBox", {
    Parent = fakeNameContainer,
    Size = UDim2.new(1, -20, 0, 38),
    Position = UDim2.new(0, 10, 0, 35),
    BackgroundColor3 = colors.bg3,
    BackgroundTransparency = 0.6,
    BorderSizePixel = 0,
    Text = "",
    PlaceholderText = "Enter fake name...",
    Font = Enum.Font.Gotham,
    TextSize = 9,
    TextColor3 = colors.text,
    TextTransparency = 0.2,
    PlaceholderColor3 = colors.textDimmer,
    TextXAlignment = Enum.TextXAlignment.Left,
    ClearTextOnFocus = false,
    ZIndex = 8
})

new("UICorner", {
    Parent = fakeNameTextBox,
    CornerRadius = UDim.new(0, 6)
})

new("UIStroke", {
    Parent = fakeNameTextBox,
    Color = colors.border,
    Thickness = 1,
    Transparency = 0.9
})

new("UIPadding", {
    Parent = fakeNameTextBox,
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8)
})

fakeNameTextBox.FocusLost:Connect(function(enterPressed)
    local value = fakeNameTextBox.Text
    if value and value ~= "" then
        currentFakeName = value
        
        if hideStatsLoaded and HideStats then
            HideStats.SetFakeName(value)
            Notify.Send("Hide Stats 👤", "Fake name diubah: " .. value, 2)
        else
            Notify.Send("Warning", "Module belum loaded, nama tersimpan sementara", 3)
        end
    end
end)

-- ============================
-- INPUT FAKE LEVEL
-- ============================
local currentFakeLevel = "1"

local fakeLevelContainer = new("Frame", {
    Parent = catHideStats,
    Size = UDim2.new(1, 0, 0, 80),
    BackgroundColor3 = colors.bg2,
    BackgroundTransparency = 0.8,
    BorderSizePixel = 0,
    ZIndex = 7
})

new("UICorner", {
    Parent = fakeLevelContainer,
    CornerRadius = UDim.new(0, 8)
})

new("UIStroke", {
    Parent = fakeLevelContainer,
    Color = colors.border,
    Thickness = 1,
    Transparency = 0.95
})

local fakeLevelLabel = new("TextLabel", {
    Parent = fakeLevelContainer,
    Size = UDim2.new(1, -20, 0, 22),
    Position = UDim2.new(0, 10, 0, 8),
    BackgroundTransparency = 1,
    Text = "Fake Level",
    Font = Enum.Font.GothamBold,
    TextSize = 11,
    TextColor3 = colors.text,
    TextTransparency = 0.2,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 8
})

local fakeLevelTextBox = new("TextBox", {
    Parent = fakeLevelContainer,
    Size = UDim2.new(1, -20, 0, 38),
    Position = UDim2.new(0, 10, 0, 35),
    BackgroundColor3 = colors.bg3,
    BackgroundTransparency = 0.6,
    BorderSizePixel = 0,
    Text = "",
    PlaceholderText = "Enter fake level...",
    Font = Enum.Font.Gotham,
    TextSize = 9,
    TextColor3 = colors.text,
    TextTransparency = 0.2,
    PlaceholderColor3 = colors.textDimmer,
    TextXAlignment = Enum.TextXAlignment.Left,
    ClearTextOnFocus = false,
    ZIndex = 8
})

new("UICorner", {
    Parent = fakeLevelTextBox,
    CornerRadius = UDim.new(0, 6)
})

new("UIStroke", {
    Parent = fakeLevelTextBox,
    Color = colors.border,
    Thickness = 1,
    Transparency = 0.9
})

new("UIPadding", {
    Parent = fakeLevelTextBox,
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8)
})

fakeLevelTextBox.FocusLost:Connect(function(enterPressed)
    local value = fakeLevelTextBox.Text
    if value and value ~= "" then
        currentFakeLevel = value
        
        if hideStatsLoaded and HideStats then
            HideStats.SetFakeLevel(value)
            Notify.Send("Hide Stats 📊", "Fake level diubah: " .. value, 2)
        else
            Notify.Send("Warning", "Module belum loaded, level tersimpan sementara", 3)
        end
    end
end)

-- Load Webhook Module via SecurityLoader
local WebhookModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hahahahehe9911-ui/syndicate/refs/heads/main/moduls/hook.lua"))()
local webhookLoadSuccess = (WebhookModule ~= nil)

if not webhookLoadSuccess then
    warn("⚠️ Webhook module failed to load")
else
    print("✅ Webhook module loaded successfully")
end

-- ============================
-- WEBHOOK CATEGORY IN WEBHOOK PAGE
-- ============================
local catWebhook = makeCategory(webhookPage, "Discord Webhook Fish Caught", "🔔")

-- Info Container
local webhookInfoContainer = new("Frame", {
    Parent = catWebhook,
    Size = UDim2.new(1, 0, 0, 85),
    BackgroundColor3 = colors.bg3,
    BackgroundTransparency = 0.8,
    BorderSizePixel = 0,
    ZIndex = 7
})

new("UICorner", {
    Parent = webhookInfoContainer,
    CornerRadius = UDim.new(0, 8)
})

new("UIStroke", {
    Parent = webhookInfoContainer,
    Color = colors.border,
    Thickness = 1,
    Transparency = 0.95
})

local webhookInfoText = new("TextLabel", {
    Parent = webhookInfoContainer,
    Size = UDim2.new(1, -24, 1, -24),
    Position = UDim2.new(0, 12, 0, 12),
    BackgroundTransparency = 1,
    Text = [[📌 WEBHOOK INFO
━━━━━━━━━━━━━━━━━━━━━━
Kirim notifikasi Discord saat menangkap ikan!
Masukkan Discord Webhook URL Anda di bawah.]],
    Font = Enum.Font.GothamBold,
    TextSize = 11,
    TextColor3 = colors.text,
    TextTransparency = 0.2,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    ZIndex = 8
})

-- Input untuk Webhook URL (Custom Implementation untuk fix input hilang)
local currentWebhookURL = ""

-- Container untuk input webhook URL
local webhookInputContainer = new("Frame", {
    Parent = catWebhook,
    Size = UDim2.new(1, 0, 0, 80),
    BackgroundColor3 = colors.bg2,
    BackgroundTransparency = 0.8,
    BorderSizePixel = 0,
    ZIndex = 7
})

new("UICorner", {
    Parent = webhookInputContainer,
    CornerRadius = UDim.new(0, 8)
})

new("UIStroke", {
    Parent = webhookInputContainer,
    Color = colors.border,
    Thickness = 1,
    Transparency = 0.95
})

-- Label
local webhookLabel = new("TextLabel", {
    Parent = webhookInputContainer,
    Size = UDim2.new(1, -20, 0, 22),
    Position = UDim2.new(0, 10, 0, 8),
    BackgroundTransparency = 1,
    Text = "Discord Webhook URL",
    Font = Enum.Font.GothamBold,
    TextSize = 11,
    TextColor3 = colors.text,
    TextTransparency = 0.2,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 8
})

-- TextBox untuk input
local webhookTextBox = new("TextBox", {
    Parent = webhookInputContainer,
    Size = UDim2.new(1, -20, 0, 38),
    Position = UDim2.new(0, 10, 0, 35),
    BackgroundColor3 = colors.bg3,
    BackgroundTransparency = 0.6,
    BorderSizePixel = 0,
    Text = "",
    PlaceholderText = "https://discord.com/api/webhooks/...",
    Font = Enum.Font.Gotham,
    TextSize = 9,
    TextColor3 = colors.text,
    TextTransparency = 0.2,
    PlaceholderColor3 = colors.textDimmer,
    TextXAlignment = Enum.TextXAlignment.Left,
    ClearTextOnFocus = false,
    ZIndex = 8
})

new("UICorner", {
    Parent = webhookTextBox,
    CornerRadius = UDim.new(0, 6)
})

new("UIStroke", {
    Parent = webhookTextBox,
    Color = colors.border,
    Thickness = 1,
    Transparency = 0.9
})

new("UIPadding", {
    Parent = webhookTextBox,
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8)
})

webhookTextBox.FocusLost:Connect(function(enterPressed)
    local value = webhookTextBox.Text
    if value and value ~= "" then
        currentWebhookURL = value
        if webhookLoadSuccess and WebhookModule then
            WebhookModule:SetWebhookURL(value)
            Notify.Send("Webhook 🔔", "Webhook URL tersimpan!", 2)
        else
            Notify.Send("Warning", "Module belum loaded, URL tersimpan sementara", 3)
        end
    end
end)

-- Input untuk Discord User ID
local currentDiscordID = ""

local discordIDContainer = new("Frame", {
    Parent = catWebhook,
    Size = UDim2.new(1, 0, 0, 80),
    BackgroundColor3 = colors.bg2,
    BackgroundTransparency = 0.8,
    BorderSizePixel = 0,
    ZIndex = 7
})

new("UICorner", {
    Parent = discordIDContainer,
    CornerRadius = UDim.new(0, 8)
})

new("UIStroke", {
    Parent = discordIDContainer,
    Color = colors.border,
    Thickness = 1,
    Transparency = 0.95
})

local discordIDLabel = new("TextLabel", {
    Parent = discordIDContainer,
    Size = UDim2.new(1, -20, 0, 22),
    Position = UDim2.new(0, 10, 0, 8),
    BackgroundTransparency = 1,
    Text = "Discord User ID (Optional - untuk mention)",
    Font = Enum.Font.GothamBold,
    TextSize = 11,
    TextColor3 = colors.text,
    TextTransparency = 0.2,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 8
})

local discordIDTextBox = new("TextBox", {
    Parent = discordIDContainer,
    Size = UDim2.new(1, -20, 0, 38),
    Position = UDim2.new(0, 10, 0, 35),
    BackgroundColor3 = colors.bg3,
    BackgroundTransparency = 0.6,
    BorderSizePixel = 0,
    Text = "",
    PlaceholderText = "123456789012345678",
    Font = Enum.Font.Gotham,
    TextSize = 9,
    TextColor3 = colors.text,
    TextTransparency = 0.2,
    PlaceholderColor3 = colors.textDimmer,
    TextXAlignment = Enum.TextXAlignment.Left,
    ClearTextOnFocus = false,
    ZIndex = 8
})

new("UICorner", {
    Parent = discordIDTextBox,
    CornerRadius = UDim.new(0, 6)
})

new("UIStroke", {
    Parent = discordIDTextBox,
    Color = colors.border,
    Thickness = 1,
    Transparency = 0.9
})

new("UIPadding", {
    Parent = discordIDTextBox,
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8)
})

discordIDTextBox.FocusLost:Connect(function(enterPressed)
    local value = discordIDTextBox.Text
    currentDiscordID = value
    if webhookLoadSuccess and WebhookModule then
        WebhookModule:SetDiscordUserID(value)
        if value ~= "" then
            Notify.Send("Webhook 🔔", "Discord ID tersimpan!", 2)
        end
    end
end)

-- ============================
-- RARITY FILTER SECTION
-- ============================

local AllRarities = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "SECRET"}
local selectedRarities = {}

local rarityInfoContainer = new("Frame", {
    Parent = catWebhook,
    Size = UDim2.new(1, 0, 0, 80),
    BackgroundColor3 = colors.bg3,
    BackgroundTransparency = 0.8,
    BorderSizePixel = 0,
    ZIndex = 7
})

new("UICorner", {
    Parent = rarityInfoContainer,
    CornerRadius = UDim.new(0, 8)
})

new("UIStroke", {
    Parent = rarityInfoContainer,
    Color = colors.border,
    Thickness = 1,
    Transparency = 0.95
})

local rarityInfoText = new("TextLabel", {
    Parent = rarityInfoContainer,
    Size = UDim2.new(1, -24, 1, -24),
    Position = UDim2.new(0, 12, 0, 12),
    BackgroundTransparency = 1,
    Text = [[RARITY FILTER
━━━━━━━━━━━━━━━━━━━━━━
Pilih rarity ikan yang akan dikirim ke Discord.
Klik pada rarity untuk toggle ON/OFF.
Kosongkan untuk kirim semua rarity.]],
    Font = Enum.Font.GothamBold,
    TextSize = 11,
    TextColor3 = colors.text,
    TextTransparency = 0.2,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    ZIndex = 8
})

-- Container untuk checkboxes
local checkboxContainer = new("Frame", {
    Parent = catWebhook,
    Size = UDim2.new(1, 0, 0, 240),
    BackgroundColor3 = colors.bg2,
    BackgroundTransparency = 0.8,
    BorderSizePixel = 0,
    ZIndex = 7
})

new("UICorner", {
    Parent = checkboxContainer,
    CornerRadius = UDim.new(0, 8)
})

new("UIStroke", {
    Parent = checkboxContainer,
    Color = colors.border,
    Thickness = 1,
    Transparency = 0.95
})

local rarityColors = {
    Common = Color3.fromRGB(150, 150, 150),
    Uncommon = Color3.fromRGB(85, 255, 85),
    Rare = Color3.fromRGB(85, 170, 255),
    Epic = Color3.fromRGB(170, 85, 255),
    Legendary = Color3.fromRGB(255, 200, 85),
    Mythic = Color3.fromRGB(255, 85, 85),
    SECRET = Color3.fromRGB(85, 255, 220)
}

local function createRarityCheckbox(parent, rarityName, yPos)
    local checkboxRow = new("Frame", {
        Parent = parent,
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, yPos),
        BackgroundColor3 = colors.bg3,
        BackgroundTransparency = 0.8,
        BorderSizePixel = 0,
        ZIndex = 8
    })
    
    new("UICorner", {
        Parent = checkboxRow,
        CornerRadius = UDim.new(0, 6)
    })
    
    local rowStroke = new("UIStroke", {
        Parent = checkboxRow,
        Color = colors.border,
        Thickness = 0,
        Transparency = 0.8
    })
    
    local checkbox = new("TextButton", {
        Parent = checkboxRow,
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(0, 8, 0, 3),
        BackgroundColor3 = colors.bg1,
        BackgroundTransparency = 0.4,
        BorderSizePixel = 0,
        Text = "",
        ZIndex = 9
    })
    
    new("UICorner", {
        Parent = checkbox,
        CornerRadius = UDim.new(0, 4)
    })
    
    local checkboxStroke = new("UIStroke", {
        Parent = checkbox,
        Color = rarityColors[rarityName] or colors.border,
        Thickness = 2,
        Transparency = 0.7
    })
    
    local checkmark = new("TextLabel", {
        Parent = checkbox,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "✓",
        Font = Enum.Font.GothamBold,
        TextSize = 18,
        TextColor3 = colors.text,
        Visible = false,
        ZIndex = 10
    })
    
    local label = new("TextLabel", {
        Parent = checkboxRow,
        Size = UDim2.new(1, -45, 1, 0),
        Position = UDim2.new(0, 40, 0, 0),
        BackgroundTransparency = 1,
        Text = rarityName,
        Font = Enum.Font.GothamBold,
        TextSize = 9,
        TextColor3 = colors.text,
        TextTransparency = 0.1,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 9
    })
    
    local isSelected = false
    
    local function toggle()
        isSelected = not isSelected
        checkmark.Visible = isSelected
        
        if isSelected then
            if not table.find(selectedRarities, rarityName) then
                table.insert(selectedRarities, rarityName)
            end
            TweenService:Create(checkbox, TweenInfo.new(0.25), {
                BackgroundColor3 = rarityColors[rarityName],
                BackgroundTransparency = 0.2
            }):Play()
            TweenService:Create(checkboxStroke, TweenInfo.new(0.25), {
                Transparency = 0.3
            }):Play()
            TweenService:Create(checkboxRow, TweenInfo.new(0.25), {
                BackgroundTransparency = 0.6
            }):Play()
            TweenService:Create(rowStroke, TweenInfo.new(0.25), {
                Thickness = 1,
                Color = rarityColors[rarityName]
            }):Play()
        else
            local idx = table.find(selectedRarities, rarityName)
            if idx then
                table.remove(selectedRarities, idx)
            end
            TweenService:Create(checkbox, TweenInfo.new(0.25), {
                BackgroundColor3 = colors.bg1,
                BackgroundTransparency = 0.4
            }):Play()
            TweenService:Create(checkboxStroke, TweenInfo.new(0.25), {
                Transparency = 0.7
            }):Play()
            TweenService:Create(checkboxRow, TweenInfo.new(0.25), {
                BackgroundTransparency = 0.8
            }):Play()
            TweenService:Create(rowStroke, TweenInfo.new(0.25), {
                Thickness = 0,
                Color = colors.border
            }):Play()
        end
        
        if webhookLoadSuccess and WebhookModule then
            WebhookModule:SetEnabledRarities(selectedRarities)
        end
        
        local statusText = #selectedRarities > 0 
            and "Selected: " .. table.concat(selectedRarities, ", ")
            or "Filter cleared - All rarities will be sent"
        Notify.Send("Rarity Filter 🎯", statusText, 2)
    end
    
    local toggleBtn = new("TextButton", {
        Parent = checkboxRow,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 10
    })
    
    toggleBtn.MouseButton1Click:Connect(toggle)
    
    toggleBtn.MouseEnter:Connect(function()
        TweenService:Create(checkboxRow, TweenInfo.new(0.2), {
            BackgroundColor3 = colors.bg4,
            BackgroundTransparency = 0.6
        }):Play()
        TweenService:Create(label, TweenInfo.new(0.2), {
            TextTransparency = 0
        }):Play()
    end)
    
    toggleBtn.MouseLeave:Connect(function()
        TweenService:Create(checkboxRow, TweenInfo.new(0.2), {
            BackgroundColor3 = colors.bg3,
            BackgroundTransparency = isSelected and 0.6 or 0.8
        }):Play()
        TweenService:Create(label, TweenInfo.new(0.2), {
            TextTransparency = 0.1
        }):Play()
    end)
    
    return {
        checkbox = checkbox,
        checkmark = checkmark,
        isSelected = function() return isSelected end,
        setSelected = function(value)
            if isSelected ~= value then
                toggle()
            end
        end
    }
end

local checkboxes = {}
for i, rarityName in ipairs(AllRarities) do
    local yPosition = (i - 1) * 33 + 5
    checkboxes[rarityName] = createRarityCheckbox(checkboxContainer, rarityName, yPosition)
end

makeButton(catWebhook, "✓ Select All Rarities", function()
    for _, rarity in ipairs(AllRarities) do
        if checkboxes[rarity] and not checkboxes[rarity].isSelected() then
            checkboxes[rarity].setSelected(true)
        end
    end
    Notify.Send("Rarity Filter 🎯", "All rarities selected!", 2)
end)

makeButton(catWebhook, "✗ Clear All Selections", function()
    for _, rarity in ipairs(AllRarities) do
        if checkboxes[rarity] and checkboxes[rarity].isSelected() then
            checkboxes[rarity].setSelected(false)
        end
    end
    Notify.Send("Rarity Filter 🎯", "Filter cleared - All rarities will be sent", 2)
end)

makeButton(catWebhook, "⭐ Select High Rarity Only", function()
    local highRarities = {"Epic", "Legendary", "Mythic", "SECRET"}
    for _, rarity in ipairs(AllRarities) do
        if checkboxes[rarity] and checkboxes[rarity].isSelected() then
            checkboxes[rarity].setSelected(false)
        end
    end
    for _, rarity in ipairs(highRarities) do
        if checkboxes[rarity] and not checkboxes[rarity].isSelected() then
            checkboxes[rarity].setSelected(true)
        end
    end
    Notify.Send("Rarity Filter 🎯", "High rarities selected: " .. table.concat(highRarities, ", "), 3)
end)

local selectedRaritiesDisplay = new("Frame", {
    Parent = catWebhook,
    Size = UDim2.new(1, 0, 0, 70),
    BackgroundColor3 = colors.bg2,
    BackgroundTransparency = 0.8,
    BorderSizePixel = 0,
    ZIndex = 7
})

new("UICorner", {
    Parent = selectedRaritiesDisplay,
    CornerRadius = UDim.new(0, 8)
})

local displayStroke = new("UIStroke", {
    Parent = selectedRaritiesDisplay,
    Color = colors.border,
    Thickness = 1,
    Transparency = 0.95
})

local selectedRaritiesLabel = new("TextLabel", {
    Parent = selectedRaritiesDisplay,
    Size = UDim2.new(1, -20, 1, -20),
    Position = UDim2.new(0, 10, 0, 10),
    BackgroundTransparency = 1,
    Text = "Active Filter: None (All rarities will be sent)",
    Font = Enum.Font.GothamBold,
    TextSize = 11,
    TextColor3 = colors.text,
    TextTransparency = 0.2,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    ZIndex = 8
})

task.spawn(function()
    while true do
        task.wait(0.5)
        if #selectedRarities > 0 then
            selectedRaritiesLabel.Text = "Active Filter: " .. table.concat(selectedRarities, ", ")
            TweenService:Create(selectedRaritiesLabel, TweenInfo.new(0.3), {
                TextColor3 = colors.success,
                TextTransparency = 0
            }):Play()
            TweenService:Create(displayStroke, TweenInfo.new(0.3), {
                Color = colors.success,
                Transparency = 0.7
            }):Play()
        else
            selectedRaritiesLabel.Text = "Active Filter: None (All rarities will be sent)"
            TweenService:Create(selectedRaritiesLabel, TweenInfo.new(0.3), {
                TextColor3 = colors.warning,
                TextTransparency = 0
            }):Play()
            TweenService:Create(displayStroke, TweenInfo.new(0.3), {
                Color = colors.border,
                Transparency = 0.95
            }):Play()
        end
    end
end)

makeToggle(catWebhook, "Enable Webhook", function(on)
    if not webhookLoadSuccess then
        Notify.Send("Error ❌", "Webhook module belum di-load! Tunggu sebentar...", 3)
        task.spawn(function()
            task.wait(1)
            loadWebhookModule()
        end)
        return
    end
    if not WebhookModule then
        Notify.Send("Error ❌", "Webhook module error!", 3)
        return
    end
    if on then
        if not currentWebhookURL or currentWebhookURL == "" then
            Notify.Send("Error ❌", "Masukkan Webhook URL terlebih dahulu!", 3)
            return
        end
        local success = WebhookModule:Start()
        if success then
            local filterInfo = #selectedRarities > 0 
                and " (Filter: " .. table.concat(selectedRarities, ", ") .. ")"
                or " (All rarities)"
            Notify.Send("Webhook 🔔", "Webhook logging aktif!" .. filterInfo, 4)
        else
            Notify.Send("Error ❌", "Gagal mengaktifkan webhook!", 3)
        end
    else
        local success = WebhookModule:Stop()
        if success then
            Notify.Send("Webhook 🔔", "Webhook logging dinonaktifkan.", 3)
        end
    end
end)

makeButton(catWebhook, "Test Webhook Connection", function()
    if not webhookLoadSuccess or not WebhookModule then
        Notify.Send("Error ❌", "Webhook module belum di-load!", 3)
        return
    end
    if not currentWebhookURL or currentWebhookURL == "" then
        Notify.Send("Error ❌", "Masukkan Webhook URL terlebih dahulu!", 3)
        return
    end
    local HttpService = game:GetService("HttpService")
    local requestFunc = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    if requestFunc then
        local filterText = #selectedRarities > 0 
            and "\n**Filter Active:** " .. table.concat(selectedRarities, ", ")
            or "\n**Filter:** All rarities enabled"
        local testPayload = {
            embeds = {{
                title = "🎣 Webhook Test Successful!",
                description = "Your Discord webhook is working correctly!\n\nSyncdicate GUI is ready to send fish notifications." .. filterText,
                color = 3447003,
                footer = {
                    text = "Syncdicate Webhook Test • " .. os.date("%m/%d/%Y %H:%M"),
                    icon_url = "https://cdn.discordapp.com/attachments/1447313630969462916/1453393959484395615/87fefb558e82737cde11be69ed19a738.png?ex=695d1c1a&is=695bca9a&hm=e7f93d39f132dcf40db09f529ffb790333372c2ee8a976891abe8c6b68e28c2d&"
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }}
        }
        local success, err = pcall(function()
            requestFunc({
                Url = currentWebhookURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode(testPayload)
            })
        end)
        if success then
            Notify.Send("Success ✅", "Test message sent! Check Discord.", 4)
        else
            Notify.Send("Error ❌", "Test failed: " .. tostring(err), 4)
        end
    else
        Notify.Send("Error ❌", "HTTP request function tidak ditemukan!", 3)
    end
end)


local statusContainer = new("Frame", {
    Parent = catWebhook,
    Size = UDim2.new(1, 0, 0, 50),
    BackgroundColor3 = colors.bg3,
    BackgroundTransparency = 0.8,
    BorderSizePixel = 0,
    ZIndex = 7
})

new("UICorner", {
    Parent = statusContainer,
    CornerRadius = UDim.new(0, 8)
})

new("UIStroke", {
    Parent = statusContainer,
    Color = colors.border,
    Thickness = 1,
    Transparency = 0.95
})

local statusText = new("TextLabel", {
    Parent = statusContainer,
    Size = UDim2.new(1, -20, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    Text = "Status: Module Loading...",
    Font = Enum.Font.GothamBold,
    TextSize = 11,
    TextColor3 = colors.warning,
    TextTransparency = 0.2,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 8
})

task.spawn(function()
    while true do
        task.wait(1)
        if webhookLoadSuccess and WebhookModule then
            if WebhookModule:IsRunning() then
                TweenService:Create(statusText, TweenInfo.new(0.3), {
                    TextColor3 = colors.success
                }):Play()
                statusText.Text = "Status: 🟢 Active & Monitoring"
            else
                TweenService:Create(statusText, TweenInfo.new(0.3), {
                    TextColor3 = colors.warning
                }):Play()
                statusText.Text = "Status: 🟡 Ready (Not Active)"
            end
        else
            TweenService:Create(statusText, TweenInfo.new(0.3), {
                TextColor3 = colors.danger
            }):Play()
            statusText.Text = "Status: 🔴 Module Not Loaded"
        end
    end
end)

-- ==== INFO PAGE ====
local infoContainer = new("Frame",{
    Parent=infoPage,
    Size=UDim2.new(1, 0, 0, 420),
    BackgroundColor3=colors.bg3,
    BackgroundTransparency=0.6,  -- Lebih transparan dari 0.5
    BorderSizePixel=0,
    ZIndex=6
})
new("UICorner",{Parent=infoContainer, CornerRadius=UDim.new(0, 8)})
new("UIStroke",{
    Parent=infoContainer,
    Color=colors.border,
    Thickness=1,
    Transparency=0.7  -- Lebih transparan dari 0.6
})

local infoText = new("TextLabel",{
    Parent=infoContainer,
    Size=UDim2.new(1, -24, 0, 80),
    Position=UDim2.new(0, 12, 0, 12),
    BackgroundTransparency=1,
    Text=[[
# Syndicate v2.9 
Free Not For Sale
━━━━━━━━━━━━━━━━━━━━━━
━━━━━━━━━━━━━━━━━━━━━━
Created with by s1n
Refined Edition 2026
    ]],
    Font=Enum.Font.Gotham,
    TextSize=9,
    TextColor3=colors.text,
    TextWrapped=true,
    TextXAlignment=Enum.TextXAlignment.Left,
    TextYAlignment=Enum.TextYAlignment.Top,
    ZIndex=7
})

-- Tambahkan TextButton untuk link
local linkButton = new("TextButton",{
    Parent=infoContainer,
    Size=UDim2.new(1, -24, 0, 20),
    Position=UDim2.new(0, 12, 0, 90),
    BackgroundTransparency=1,
    Text="🔗 Discord: https://discord.gg/syncontop",
    Font=Enum.Font.GothamBold,
    TextSize=9,
    TextColor3=Color3.fromRGB(88, 101, 242), -- Warna Discord
    TextXAlignment=Enum.TextXAlignment.Left,
    ZIndex=7
})

linkButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/syncontop") -- Copy link ke clipboard
    linkButton.Text = "✅ Link copied to clipboard!"
    wait(2)
    linkButton.Text = "🔗 Discord: https://discord.gg/syncontop"
end)

-- ==== MINIMIZE SYSTEM ====
local minimized = false
local icon
local savedIconPos = UDim2.new(0, 20, 0, 100)

local function createMinimizedIcon()
    if icon then return end
    
    icon = new("ImageLabel",{
        Parent=gui,
        Size=UDim2.new(0, 50, 0, 50),
        Position=savedIconPos,
        BackgroundColor3=colors.bg2,
        BackgroundTransparency=0.3,  -- Lebih transparan dari 0.2
        BorderSizePixel=0,
        Image="rbxassetid://90595173624203",
        ScaleType=Enum.ScaleType.Fit,
        ZIndex=100
    })
    new("UICorner",{Parent=icon, CornerRadius=UDim.new(0, 10)})
    new("UIStroke",{
        Parent=icon,
        Color=colors.primary,
        Thickness=2,
        Transparency=0.5  -- Lebih transparan dari 0.4
    })
    
    local logoText = new("TextLabel",{
        Parent=icon,
        Text="L",
        Size=UDim2.new(1, 0, 1, 0),
        Font=Enum.Font.GothamBold,
        TextSize=28,
        BackgroundTransparency=1,
        TextColor3=colors.primary,
        Visible=icon.Image == "",
        ZIndex=101
    })
    
    local dragging, dragStart, startPos, dragMoved = false, nil, nil, false
    
    icon.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging, dragMoved, dragStart, startPos = true, false, input.Position, icon.Position
        end
    end)
    
    icon.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            if math.sqrt(delta.X^2 + delta.Y^2) > 5 then 
                dragMoved = true 
            end
            local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            TweenService:Create(icon, TweenInfo.new(0.05), {Position=newPos}):Play()
        end
    end)
    
   icon.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if dragging then
                dragging = false
                savedIconPos = icon.Position
                if not dragMoved then
                    bringToFront()  -- ⬅️ TAMBAHKAN INI
                    win.Visible = true
                    TweenService:Create(win, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Size=windowSize,
                        Position=UDim2.new(0.5, -windowSize.X.Offset/2, 0.5, -windowSize.Y.Offset/2)
                    }):Play()
                    if icon then 
                        icon:Destroy() 
                        icon = nil 
                    end
                    minimized = false
                end
            end
        end
    end)
end

btnMinHeader.MouseButton1Click:Connect(function()
    if not minimized then
        local targetPos = UDim2.new(0.5, 0, 0.5, 0)
        TweenService:Create(win, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size=UDim2.new(0, 0, 0, 0),
            Position=targetPos
        }):Play()
        task.wait(0.35)
        win.Visible = false
        createMinimizedIcon()
        minimized = true
    end
end)

-- ==== DRAGGING SYSTEM (From Header) - Smoother ====
local dragging, dragStart, startPos = false, nil, nil

scriptHeader.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        bringToFront()  -- ⬅️ TAMBAHKAN INI
        dragging, dragStart, startPos = true, input.Position, win.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        local newPos = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
        TweenService:Create(win, TweenInfo.new(0.1, Enum.EasingStyle.Quint), {Position=newPos}):Play()
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
        dragging = false 
    end
end)

-- ==== RESIZING SYSTEM - Smoother ====
local resizing = false
local resizeStart, startSize = nil, nil

resizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing, resizeStart, startSize = true, input.Position, win.Size
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - resizeStart
        
        local newWidth = math.clamp(
            startSize.X.Offset + delta.X,
            minWindowSize.X,
            maxWindowSize.X
        )
        local newHeight = math.clamp(
            startSize.Y.Offset + delta.Y,
            minWindowSize.Y,
            maxWindowSize.Y
        )
        
        local newSize = UDim2.new(0, newWidth, 0, newHeight)
        TweenService:Create(win, TweenInfo.new(0.1, Enum.EasingStyle.Quint), {Size=newSize}):Play()
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
        resizing = false 
    end
end)

-- ==== OPENING ANIMATION - More dramatic ====
task.spawn(function()
    win.Size = UDim2.new(0, 0, 0, 0)
    win.Position = UDim2.new(0.5, -windowSize.X.Offset/2, 0.5, -windowSize.Y.Offset/2)
    win.BackgroundTransparency = 1
    
    task.wait(0.1)
    
    -- Expand with bounce
    TweenService:Create(win, TweenInfo.new(0.7, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        Size=windowSize
    }):Play()
    
    -- Fade in
    TweenService:Create(win, TweenInfo.new(0.5), {
        BackgroundTransparency=0.25  -- Lebih transparan dari 0.15
    }):Play()
end)

print("━━━━━━━━━━━━━━━━━━━━━━")
print("✨ Syndicate GUI v2.3 ")
print("FREE NOT FOR SALE")
print("━━━━━━━━━━━━━━━━━━━━━━")
print("💎 Created by Syndicate")
print("━━━━━━━━━━━━━━━━━━━━━━")
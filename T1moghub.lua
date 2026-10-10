--[========================================================]--
-- Script: T1moghub - MM2 Ultimate + Telegram Contact (Roblox)
-- Engineer: TWKS
-- Language: Lua / Luau (Executor Environment)
--[========================================================]--

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Таблицы локализации (США/EN, Канада/FR, Мексика/ES, Панама/ES, Перу/ES, Русский/RU)
local languages = {
    ["Russian"] = {
        welcome = "Добро пожаловать в T1moghub",
        esp = "ESP (ПОДСВЕТКА РОЛЕЙ)",
        fov = "УГОЛ ОБЗОРА (FOV): ",
        hitbox = "РАСШИРЕНИЕ ХИТБОКСОВ",
        noclip = "ПРОХОЖДЕНИЕ СКВОЗЬ СТЕНЫ",
        coins = "АВТО СБОР МОНЕТ",
        spin = "КРУТИЛКА (SPINBOT)",
        antiaim = "АНТИ-АИМ (JITTER)",
        shoot = "АВТО ВЫСТРЕЛ ПО УБИЙЦЕ",
        autogun = "АВТО ПОДБОР ПИСТОЛЕТА",
        memesound = "МЕМ ЗВУК ПОПАДАНИЯ: ",
        flingsh = "ФЛИНГ ШЕРИФА",
        flingmu = "ФЛИНГ УБИЙЦЫ",
        speed = "СПИДХАК / БУСТ",
        fly = "ПОЛЕТ (FLY)",
        flyspeed = "СКОРОСТЬ ПОЛЕТА: ",
        skin = "СКИНЧЕЙДЖЕР ГОДЛЕЙ",
        langbtn = "ЯЗЫК: РУССКИЙ",
        activeSkin = "Активный сет: ",
        none = "Нет"
    },
    ["USA"] = {
        welcome = "Welcome to T1moghub",
        esp = "ESP (ROLE HIGHLIGHT)",
        fov = "FOV: ",
        hitbox = "HITBOX EXPAND",
        noclip = "NOCLIP",
        coins = "AUTO FARM COINS",
        spin = "SPINBOT",
        antiaim = "ANTI-AIM (JITTER)",
        shoot = "SHOOT MURDERER",
        autogun = "AUTO GRAB GUN",
        memesound = "MEME HIT SOUND: ",
        flingsh = "FLING SHERIFF",
        flingmu = "FLING MURDERER",
        speed = "SPEED GLITCH / BOOST",
        fly = "FLY",
        flyspeed = "FLY SPEED: ",
        skin = "GODLY SKINCHANGER",
        langbtn = "LANGUAGE: USA",
        activeSkin = "Active Set: ",
        none = "None"
    },
    ["Canada"] = {
        welcome = "Bienvenue sur T1moghub",
        esp = "ESP (ROLES)",
        fov = "CHAMP DE VISION: ",
        hitbox = "HITBOX",
        noclip = "TRAVERSER LES MURS",
        coins = "AUTO PIECES",
        spin = "ROTOR (SPINBOT)",
        antiaim = "ANTI-AIM",
        shoot = "TIRER MEURTRIER",
        autogun = "AUTO RAMASSER PISTOLET",
        memesound = "SON MEME HIT: ",
        flingsh = "PROJETER SHERIFF",
        flingmu = "PROJETER MEURTRIER",
        speed = "VITESSE BOOST",
        fly = "VOLER",
        flyspeed = "VITESSE DE VOL: ",
        skin = "CHANGER DE SKINS",
        langbtn = "LANGUE: CANADA",
        activeSkin = "Set actif: ",
        none = "Aucun"
    },
    ["Mexico"] = {
        welcome = "Bienvenido a T1moghub",
        esp = "ESP (ROLES)",
        fov = "FOV: ",
        hitbox = "EXTENDER HITBOX",
        noclip = "ATRAVESAR PAREDES",
        coins = "AUTOFARM MONEDAS",
        spin = "GIRAR (SPINBOT)",
        antiaim = "ANTI-AIM",
        shoot = "DISPARAR ASESINO",
        autogun = "AUTO RECOGER PISTOLA",
        memesound = "SONIDO MEME HIT: ",
        flingsh = "LANZAR SHERIFF",
        flingmu = "LANZAR ASESINO",
        speed = "GLITCH DE VELOCIDAD",
        fly = "VOLAR",
        flyspeed = "VELOCIDAD DE VUELO: ",
        skin = "CAMBIADOR DE SKINS",
        langbtn = "IDIOMA: MEXICO",
        activeSkin = "Set activo: ",
        none = "Ninguno"
    },
    ["Panama"] = {
        welcome = "Bienvenido a T1moghub",
        esp = "ESP (ROLES)",
        fov = "FOV: ",
        hitbox = "EXPANDIR HITBOX",
        noclip = "SIN COLISION",
        coins = "MONEDAS AUTO",
        spin = "SPINBOT",
        antiaim = "ANTI-AIM",
        shoot = "DISPARAR ASESINO",
        autogun = "AUTO AGARRAR PISTOLA",
        memesound = "SONIDO MEME HIT: ",
        flingsh = "LANZAR SHERIFF",
        flingmu = "LANZAR ASESINO",
        speed = "VELOCIDAD BOOST",
        fly = "VUELO",
        flyspeed = "VELOCIDAD VUELO: ",
        skin = "SKINCHANGER",
        langbtn = "IDIOMA: PANAMA",
        activeSkin = "Set activo: ",
        none = "Ninguno"
    },
    ["Peru"] = {
        welcome = "Bienvenido a T1moghub",
        esp = "ESP (ROLES)",
        fov = "FOV: ",
        hitbox = "HITBOX EXPANDIDO",
        noclip = "NOCLIP",
        coins = "AUTOFARM MONEDAS",
        spin = "SPINBOT",
        antiaim = "ANTI-AIM",
        shoot = "DISPARAR ASESINO",
        autogun = "AUTO COGER PISTOLA",
        memesound = "SONIDO MEME HIT: ",
        flingsh = "LANZAR SHERIFF",
        flingmu = "LANZAR ASESINO",
        speed = "VELOCIDAD",
        fly = "VOLAR",
        flyspeed = "VELOCIDAD VUELO: ",
        skin = "SKINCHANGER",
        langbtn = "IDIOMA: PERU",
        activeSkin = "Set activo: ",
        none = "Ninguno"
    }
}

local langKeys = {"Russian", "USA", "Canada", "Mexico", "Panama", "Peru"}
local currentLangIndex = 1
local curLang = languages["Russian"]

-- База данных звуков из мeмов с Roblox ID (Audio Assets)
local memeSounds = {
    {Name = "Bruh", ID = "rbxassetid://4590657391"},
    {Name = "Vine Boom", ID = "rbxassetid://5153737002"},
    {Name = "Metal Pipe", ID = "rbxassetid://8253108097"},
    {Name = "Sigma Horn", ID = "rbxassetid://9069609204"},
    {Name = "Airhorn", ID = "rbxassetid://138084457"},
    {Name = "Emotional Damage", ID = "rbxassetid://9069612089"},
    {Name = "Taco Bell", ID = "rbxassetid://4612375178"}
}
local currentMemeIndex = 1

-- Экран загрузки с приветствием T1moghub
local LoadGui = Instance.new("ScreenGui")
LoadGui.Name = "T1moghub_Loading"
LoadGui.Parent = CoreGui
LoadGui.ResetOnSpawn = false

local LoadFrame = Instance.new("Frame")
LoadFrame.Parent = LoadGui
LoadFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
LoadFrame.BorderSizePixel = 0
LoadFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LoadFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadFrame.Size = UDim2.new(0, 0, 0, 0)
LoadFrame.ClipsDescendants = true

local LoadText = Instance.new("TextLabel")
LoadText.Parent = LoadFrame
LoadText.BackgroundTransparency = 1
LoadText.Size = UDim2.new(1, 0, 1, 0)
LoadText.Font = Enum.Font.GothamBold
LoadText.Text = curLang.welcome
LoadText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadText.TextSize = 18
LoadText.TextTransparency = 1

LoadFrame:TweenSize(UDim2.new(0, 380, 0, 90), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.4, true)
task.wait(0.4)
TweenService:Create(LoadText, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
task.wait(2.2)
TweenService:Create(LoadText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
LoadFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.4, true)
task.wait(0.4)
LoadGui:Destroy()

-- Создание главного графического интерфейса
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "T1moghub_MM2_Ultimate"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.5, -210, 0.5, -400)
Frame.Size = UDim2.new(0, 420, 0, 800)
Frame.Active = true
Frame.Draggable = true

local Header = Instance.new("TextLabel")
Header.Parent = Frame
Header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Header.BorderSizePixel = 0
Header.Size = UDim2.new(1, 0, 0, 32)
Header.Font = Enum.Font.GothamBold
Header.Text = "T1moghub // MM2 + CONTACTS"
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.TextSize = 13

-- Функция генерации кнопок управления интерфейса
local function createButton(posY, text)
    local btn = Instance.new("TextButton")
    btn.Parent = Frame
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.BorderSizePixel = 0
    btn.Position = UDim2.new(0.08, 0, posY, 0)
    btn.Size = UDim2.new(0.84, 0, 0, 24)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 80, 80)
    btn.TextSize = 11
    return btn
end

local BtnLang = createButton(0.042, curLang.langbtn)
local BtnESP = createButton(0.076, curLang.esp .. ": OFF")
local BtnFOV = createButton(0.110, curLang.fov .. "90")
local BtnHitbox = createButton(0.144, curLang.hitbox .. ": OFF")
local BtnNoclip = createButton(0.178, curLang.noclip .. ": OFF")
local BtnCoins = createButton(0.212, curLang.coins .. ": OFF")
local BtnSpin = createButton(0.246, curLang.spin .. ": OFF")
local BtnAntiAim = createButton(0.280, curLang.antiaim .. ": OFF")
local BtnShootMurder = createButton(0.314, curLang.shoot .. ": OFF")
local BtnAutoGun = createButton(0.348, curLang.autogun .. ": OFF")
local BtnMemeSound = createButton(0.382, curLang.memesound .. memeSounds[currentMemeIndex].Name)
local BtnFlingSheriff = createButton(0.416, curLang.flingsh .. ": OFF")
local BtnFlingMurder = createButton(0.450, curLang.flingmu .. ": OFF")
local BtnSpeedGlitch = createButton(0.484, curLang.speed .. ": OFF")
local BtnFly = createButton(0.518, curLang.fly .. ": OFF")
local BtnFlySpeed = createButton(0.552, curLang.flyspeed .. "50")
local BtnSkinChanger = createButton(0.586, curLang.skin .. ": OFF")

-- Список сетов годлей
local godlySets = {"Corrupt Set", "Harvester Set", "Darkbringer / Lightbringer", "Icepiercer Set", "Evergun / Everschythe", "Candy Set", "Bat Set", "Elderwood Set"}
local currentSetIndex = 1

local SkinChangerLabel = Instance.new("TextLabel")
SkinChangerLabel.Parent = Frame
SkinChangerLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SkinChangerLabel.BorderSizePixel = 0
SkinChangerLabel.Position = UDim2.new(0.08, 0, 0.625, 0)
SkinChangerLabel.Size = UDim2.new(0.84, 0, 0, 24)
SkinChangerLabel.Font = Enum.Font.Gotham
SkinChangerLabel.Text = curLang.activeSkin .. curLang.none
SkinChangerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SkinChangerLabel.TextSize = 11

-- Плашка связи в настройках / интерфейсе
local ContactLabel = Instance.new("TextLabel")
ContactLabel.Parent = Frame
ContactLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ContactLabel.BorderSizePixel = 0
ContactLabel.Position = UDim2.new(0.08, 0, 0.68, 0)
ContactLabel.Size = UDim2.new(0.84, 0, 0, 30)
ContactLabel.Font = Enum.Font.GothamBold
ContactLabel.Text = "Связаться: @Aloeverakk (telegram)"
ContactLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
ContactLabel.TextSize = 12

-- Текст подсказки горячей клавиши скрытия меню
local ToggleKeyText = Instance.new("TextLabel")
ToggleKeyText.Parent = Frame
ToggleKeyText.BackgroundTransparency = 1
ToggleKeyText.Position = UDim2.new(0.08, 0, 0.95, 0)
ToggleKeyText.Size = UDim2.new(0.84, 0, 0, 22)
ToggleKeyText.Font = Enum.Font.Gotham
ToggleKeyText.Text = "Toggle Menu: LeftControl | T1moghub"
ToggleKeyText.TextColor3 = Color3.fromRGB(150, 150, 150)
ToggleKeyText.TextSize = 11

-- Переменные состояний модулей
local espEnabled = false
local customFov = 90
local hitboxEnabled = false
local noclipEnabled = false
local coinsEnabled = false
local spinEnabled = false
local antiAimEnabled = false
local shootMurderEnabled = false
local autoGunEnabled = false
local flingSheriffEnabled = false
local flingMurderEnabled = false
local speedGlitchEnabled = false
local flyEnabled = false
local flySpeed = 50
local skinChangerEnabled = false

local currentAngle = 0
local spinSpeed = 35
local espCache = {}
local lastShotTick = 0

local function playMemeHitSound()
    local sound = Instance.new("Sound")
    sound.SoundId = memeSounds[currentMemeIndex].ID
    sound.Volume = 2
    sound.Parent = SoundService
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

local function updateTexts()
    BtnLang.Text = curLang.langbtn
    BtnESP.Text = curLang.esp .. ": " .. (espEnabled and "ON" or "OFF")
    BtnFOV.Text = curLang.fov .. tostring(customFov)
    BtnHitbox.Text = curLang.hitbox .. ": " .. (hitboxEnabled and "ON" or "OFF")
    BtnNoclip.Text = curLang.noclip .. ": " .. (noclipEnabled and "ON" or "OFF")
    BtnCoins.Text = curLang.coins .. ": " .. (coinsEnabled and "ON" or "OFF")
    BtnSpin.Text = curLang.spin .. ": " .. (spinEnabled and "ON" or "OFF")
    BtnAntiAim.Text = curLang.antiaim .. ": " .. (antiAimEnabled and "ON" or "OFF")
    BtnShootMurder.Text = curLang.shoot .. ": " .. (shootMurderEnabled and "ON" or "OFF")
    BtnAutoGun.Text = curLang.autogun .. ": " .. (autoGunEnabled and "ON" or "OFF")
    BtnMemeSound.Text = curLang.memesound .. memeSounds[currentMemeIndex].Name
    BtnFlingSheriff.Text = curLang.flingsh .. ": " .. (flingSheriffEnabled and "ON" or "OFF")
    BtnFlingMurder.Text = curLang.flingmu .. ": " .. (flingMurderEnabled and "ON" or "OFF")
    BtnSpeedGlitch.Text = curLang.speed .. ": " .. (speedGlitchEnabled and "ON" or "OFF")
    BtnFly.Text = curLang.fly .. ": " .. (flyEnabled and "ON" or "OFF")
    BtnFlySpeed.Text = curLang.flyspeed .. tostring(flySpeed)
    BtnSkinChanger.Text = curLang.skin .. ": " .. (skinChangerEnabled and "ON" or "OFF")
    SkinChangerLabel.Text = curLang.activeSkin .. (skinChangerEnabled and godlySets[currentSetIndex] or curLang.none)
end

BtnLang.MouseButton1Click:Connect(function()
    currentLangIndex = currentLangIndex % #langKeys + 1
    local selectedKey = langKeys[currentLangIndex]
    curLang = languages[selectedKey]
    updateTexts()
end)

BtnMemeSound.MouseButton1Click:Connect(function()
    currentMemeIndex = currentMemeIndex % #memeSounds + 1
    updateTexts()
    playMemeHitSound()
end)

BtnESP.MouseButton1Click:Connect(function() espEnabled = not espEnabled; updateTexts() end)
BtnFOV.MouseButton1Click:Connect(function()
    if customFov == 90 then customFov = 120
    elseif customFov == 120 then customFov = 70
    else customFov = 90 end
    Camera.FieldOfView = customFov
    updateTexts()
end)
BtnHitbox.MouseButton1Click:Connect(function() hitboxEnabled = not hitboxEnabled; updateTexts() end)
BtnNoclip.MouseButton1Click:Connect(function() noclipEnabled = not noclipEnabled; updateTexts() end)
BtnCoins.MouseButton1Click:Connect(function() coinsEnabled = not coinsEnabled; updateTexts() end)
BtnSpin.MouseButton1Click:Connect(function() spinEnabled = not spinEnabled; updateTexts() end)
BtnAntiAim.MouseButton1Click:Connect(function() antiAimEnabled = not antiAimEnabled; updateTexts() end)
BtnShootMurder.MouseButton1Click:Connect(function() shootMurderEnabled = not shootMurderEnabled; updateTexts() end)
BtnAutoGun.MouseButton1Click:Connect(function() autoGunEnabled = not autoGunEnabled; updateTexts() end)
BtnFlingSheriff.MouseButton1Click:Connect(function() flingSheriffEnabled = not flingSheriffEnabled; updateTexts() end)
BtnFlingMurder.MouseButton1Click:Connect(function() flingMurderEnabled = not flingMurderEnabled; updateTexts() end)
BtnSpeedGlitch.MouseButton1Click:Connect(function() speedGlitchEnabled = not speedGlitchEnabled; updateTexts() end)
BtnFly.MouseButton1Click:Connect(function() flyEnabled = not flyEnabled; updateTexts() end)
BtnFlySpeed.MouseButton1Click:Connect(function()
    if flySpeed == 50 then flySpeed = 100
    elseif flySpeed == 100 then flySpeed = 150
    elseif flySpeed == 150 then flySpeed = 200
    else flySpeed = 50 end
    updateTexts()
end)
BtnSkinChanger.MouseButton1Click:Connect(function() skinChangerEnabled = not skinChangerEnabled; updateTexts() end)

SkinChangerLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        currentSetIndex = currentSetIndex % #godlySets + 1
        updateTexts()
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.LeftControl then
        Frame.Visible = not Frame.Visible
    end
end)

local function getPlayerRole(player)
    if not player.Character then return "Innocent" end
    local backpack = player:FindFirstChild("Backpack")
    local character = player.Character
    local items = {}
    if backpack then for _, item in ipairs(backpack:GetChildren()) do table.insert(items, item.Name) end end
    for _, item in ipairs(character:GetChildren()) do table.insert(items, item.Name) end
    
    for _, name in ipairs(items) do
        if name == "Gun" or name == "Revolver" then return "Sheriff"
        elseif name == "Knife" then return "Murderer" end
    end
    return "Innocent"
end

local function getMurderer()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and getPlayerRole(player) == "Murderer" then return player end
    end
    return nil
end

local function getSheriff()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and getPlayerRole(player) == "Sheriff" then return player end
    end
    return nil
end

local function createEspHighlight(player)
    if player == LocalPlayer then return end
    local hl = Instance.new("Highlight")
    hl.Name = "T1moghub_ESP"
    hl.Adornee = player.Character
    hl.Parent = CoreGui
    hl.FillTransparency = 0.5
    hl.OutlineTransparency = 0
    espCache[player] = hl
end

local function removeEspHighlight(player)
    if espCache[player] then
        espCache[player]:Destroy()
        espCache[player] = nil
    end
end

Players.PlayerRemoving:Connect(function(player) removeEspHighlight(player) end)

local function applyFling(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    local myChar = LocalPlayer.Character
    if not myChar or not targetRoot then return end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    
    myRoot.CFrame = targetRoot.CFrame
    myRoot.Velocity = Vector3.new(30000, 30000, 30000)
    myRoot.RotVelocity = Vector3.new(30000, 30000, 30000)
end

local function applySkinChanger()
    if not skinChangerEnabled then return end
    local activeSetName = godlySets[currentSetIndex]
    local containers = {LocalPlayer.Backpack, LocalPlayer.Character}
    for _, container in ipairs(containers) do
        if container then
            for _, item in ipairs(container:GetChildren()) do
                if item:IsA("Tool") then
                    if item.Name == "Knife" then
                        if activeSetName == "Corrupt Set" then item.Name = "Corrupt Knife"
                        elseif activeSetName == "Harvester Set" then item.Name = "Harvester"
                        elseif activeSetName == "Icepiercer Set" then item.Name = "Icepiercer"
                        elseif activeSetName == "Evergun / Everschythe" then item.Name = "Everschythe"
                        elseif activeSetName == "Candy Set" then item.Name = "Sugar"
                        elseif activeSetName == "Bat Set" then item.Name = "Bat"
                        elseif activeSetName == "Elderwood Set" then item.Name = "Elderwood Scythe"
                        else item.Name = "Godly Knife" end
                    elseif item.Name == "Gun" or item.Name == "Revolver" then
                        if activeSetName == "Corrupt Set" then item.Name = "Corrupt Gun"
                        elseif activeSetName == "Harvester Set" then item.Name = "Icepiercer Gun"
                        elseif activeSetName == "Darkbringer / Lightbringer" then item.Name = "Darkbringer"
                        elseif activeSetName == "Icepiercer Set" then item.Name = "ICERUNNER"
                        elseif activeSetName == "Evergun / Everschythe" then item.Name = "Evergun"
                        elseif activeSetName == "Candy Set" then item.Name = "Candy"
                        elseif activeSetName == "Elderwood Set" then item.Name = "Elderwood Revolver"
                        else item.Name = "Godly Gun" end
                    end
                end
            end
        end
    end
end

RunService.Stepped:Connect(function()
    local character = LocalPlayer.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChild("Humanoid")
    
    if espEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local hl = espCache[player]
                if not hl and player.Character then
                    createEspHighlight(player)
                    hl = espCache[player]
                end
                if hl and player.Character then
                    hl.Adornee = player.Character
                    local role = getPlayerRole(player)
                    if role == "Murderer" then
                        hl.FillColor = Color3.fromRGB(255, 0, 0)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    elseif role == "Sheriff" then
                        hl.FillColor = Color3.fromRGB(0, 0, 255)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    else
                        hl.FillColor = Color3.fromRGB(0, 255, 0)
                        hl.OutlineColor = Color3.fromRGB(0, 0, 0)
                    end
                end
            end
        end
    else
        for player, _ in pairs(espCache) do removeEspHighlight(player) end
    end
    
    if noclipEnabled then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
    
    if hitboxEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local pRoot = player.Character:FindFirstChild("HumanoidRootPart")
                if pRoot then
                    pRoot.Size = Vector3.new(4, 4, 4)
                    pRoot.Transparency = 0.7
                    pRoot.CanCollide = false
                end
            end
        end
    end
    
    if coinsEnabled and rootPart then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj.Name == "Coin_Server" or obj.Name == "Coin" then
                if obj:IsA("BasePart") then
                    rootPart.CFrame = obj.CFrame
                    task.wait(0.1)
                    break
                end
            end
        end
    end
    
    if rootPart and not flyEnabled then
        if spinEnabled then
            currentAngle = (currentAngle + spinSpeed) % 360
            local currentPos = rootPart.CFrame.Position
            rootPart.CFrame = CFrame.new(currentPos) * CFrame.Angles(0, math.rad(currentAngle), 0)
        elseif antiAimEnabled then
            local randomOffset = math.random(-90, 90)
            local currentPos = rootPart.CFrame.Position
            rootPart.CFrame = CFrame.new(currentPos) * CFrame.Angles(0, math.rad(randomOffset), 0)
        end
    end
    
    if shootMurderEnabled then
        local gunTool = character:FindFirstChild("Gun") or character:FindFirstChild("Revolver") or LocalPlayer.Backpack:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Revolver")
        if gunTool then
            local murderer = getMurderer()
            if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
                if gunTool.Parent == LocalPlayer.Backpack then
                    gunTool.Parent = character
                end
                gunTool:Activate()
                
                if tick() - lastShotTick > 1.2 then
                    lastShotTick = tick()
                    playMemeHitSound()
                end
            end
        end
    end
    
    if autoGunEnabled and rootPart then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj.Name == "GunDrop" or obj.Name == "Gun" and obj:IsA("BasePart") then
                rootPart.CFrame = obj.CFrame
                task.wait(0.1)
                break
            end
        end
    end
    
    if flingSheriffEnabled then
        local sheriff = getSheriff()
        if sheriff then applyFling(sheriff) end
    end
    if flingMurderEnabled then
        local murderer = getMurderer()
        if murderer then applyFling(murderer) end
    end
    
    if speedGlitchEnabled and humanoid and rootPart and not flyEnabled then
        if humanoid.MoveDirection.Magnitude > 0 then
            character:TranslateBy(humanoid.MoveDirection * 0.5)
        end
    end
    
    if flyEnabled and rootPart then
        local moveDir = humanoid.MoveDirection
        local camCFrame = Camera.CFrame
        local velocity = Vector3.new(0, 0, 0)
        if moveDir.Magnitude > 0 then
            velocity = (camCFrame.LookVector * moveDir.Z + camCFrame.RightVector * moveDir.X).Unit * flySpeed
        end
        rootPart.Velocity = velocity
        if humanoid then humanoid.PlatformStand = true end
    else
        if humanoid and humanoid.PlatformStand and not flyEnabled then
            humanoid.PlatformStand = false
        end
    end
    
    if skinChangerEnabled then
        applySkinChanger()
    end
end)

-- Script Mobile - Anime Final Quest (Completo)
local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Criar Interface
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local StatusLabel = Instance.new("TextLabel")
local AtacarBtn = Instance.new("TextButton")
local DespertarBtn = Instance.new("TextButton")
local TeleportBtn = Instance.new("TextButton")
local CurarBtn = Instance.new("TextButton")
local AntiAfkBtn = Instance.new("TextButton")
local FecharBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "MobileAutoFarm"

-- Fundo
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 280, 0, 330)
Frame.Position = UDim2.new(0.5, -140, 0.6, -165)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BackgroundTransparency = 0.2
Frame.BorderSizePixel = 0

-- Título
Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "⚔️ AUTO FARM COMPLETO ⚔️"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.BackgroundTransparency = 1
Title.TextScaled = true

-- Status
StatusLabel.Parent = Frame
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0, 45)
StatusLabel.Text = "📱 Status: Parado"
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextSize = 13

-- Botões
AtacarBtn.Parent = Frame
AtacarBtn.Size = UDim2.new(0, 240, 0, 38)
AtacarBtn.Position = UDim2.new(0.5, -120, 0, 85)
AtacarBtn.Text = "⚔️ ATACAR OFF ⚔️"
AtacarBtn.BackgroundColor3 = Color3.fromRGB(139, 0, 139)
AtacarBtn.TextColor3 = Color3.new(1, 1, 1)
AtacarBtn.TextSize = 14

DespertarBtn.Parent = Frame
DespertarBtn.Size = UDim2.new(0, 240, 0, 38)
DespertarBtn.Position = UDim2.new(0.5, -120, 0, 128)
DespertarBtn.Text = "⚡ DESPERTAR OFF ⚡"
DespertarBtn.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
DespertarBtn.TextColor3 = Color3.new(1, 1, 1)
DespertarBtn.TextSize = 14

TeleportBtn.Parent = Frame
TeleportBtn.Size = UDim2.new(0, 240, 0, 38)
TeleportBtn.Position = UDim2.new(0.5, -120, 0, 171)
TeleportBtn.Text = "🌀 TELEPORTE OFF 🌀"
TeleportBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 139)
TeleportBtn.TextColor3 = Color3.new(1, 1, 1)
TeleportBtn.TextSize = 14

CurarBtn.Parent = Frame
CurarBtn.Size = UDim2.new(0, 240, 0, 38)
CurarBtn.Position = UDim2.new(0.5, -120, 0, 214)
CurarBtn.Text = "💊 AUTO CURA OFF 💊"
CurarBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
CurarBtn.TextColor3 = Color3.new(1, 1, 1)
CurarBtn.TextSize = 14

AntiAfkBtn.Parent = Frame
AntiAfkBtn.Size = UDim2.new(0, 240, 0, 30)
AntiAfkBtn.Position = UDim2.new(0.5, -120, 0, 257)
AntiAfkBtn.Text = "🛡️ ANTI-AFK OFF 🛡️"
AntiAfkBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AntiAfkBtn.TextColor3 = Color3.new(1, 1, 1)
AntiAfkBtn.TextSize = 13

FecharBtn.Parent = Frame
FecharBtn.Size = UDim2.new(0, 60, 0, 25)
FecharBtn.Position = UDim2.new(1, -70, 0, 5)
FecharBtn.Text = "❌"
FecharBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
FecharBtn.TextColor3 = Color3.new(1, 1, 1)
FecharBtn.TextSize = 14

-- Variáveis
local atacar = false
local despertar = false
local teleportar = false
local curar = false
local antiAfk = false

-- ========== FUNÇÃO: ACHAR INIMIGO MAIS PRÓXIMO ==========
local function getClosestEnemy()
    local inimigo = nil
    local distancia = 50
    
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name ~= player.Name and obj:FindFirstChild("Humanoid") then
            local humano = obj:FindFirstChild("Humanoid")
            if humano and humano.Health > 0 then
                local parte = obj:FindFirstChild("HumanoidRootPart")
                if parte and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (parte.Position - player.Character.HumanoidRootPart.Position).magnitude
                    if dist < distancia then
                        distancia = dist
                        inimigo = obj
                    end
                end
            end
        end
    end
    return inimigo, distancia
end

-- ========== FUNÇÃO: TELEPORTE PARA INIMIGO ==========
local function teleportarInimigo()
    while teleportar do
        local inimigo, dist = getClosestEnemy()
        
        if inimigo and inimigo:FindFirstChild("HumanoidRootPart") then
            local posInimigo = inimigo.HumanoidRootPart.Position
            local novaPos = Vector3.new(posInimigo.X, posInimigo.Y + 2, posInimigo.Z)
            
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(novaPos)
                StatusLabel.Text = "📱 Status: 🌀 Teleportando..."
            end
        end
        
        task.wait(1) -- Teleporta a cada 1 segundo
    end
end

-- ========== FUNÇÃO: ATAQUE ==========
local function atacarInimigos()
    while atacar do
        local inimigo, dist = getClosestEnemy()
        
        if inimigo and inimigo:FindFirstChild("HumanoidRootPart") and dist < 30 then
            -- Mira no inimigo
            player.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position, inimigo.HumanoidRootPart.Position)
            
            -- Simula toque na tela (M1)
            local VirtualInput = game:GetService("VirtualInputManager")
            VirtualInput:SendMouseButtonEvent(500, 300, 0, true, game, 0)
            VirtualInput:SendMouseButtonEvent(500, 300, 0, false, game, 0)
            
            StatusLabel.Text = "📱 Status: ⚔️ Atacando..."
        else
            StatusLabel.Text = "📱 Status: 🔍 Procurando..."
        end
        
        task.wait(0.15)
    end
end

-- ========== FUNÇÃO: DESPERTAR ==========
local function ativarDespertar()
    while despertar do
        local achou = false
        
        -- Procura botão de despertar na tela
        for _, obj in ipairs(player.PlayerGui:GetDescendants()) do
            if obj:IsA("TextButton") or obj:IsA("ImageButton") then
                local texto = (obj.Text or ""):lower()
                if texto:find("despertar") or texto:find("waking") or texto:find("awaken") or texto:find("rage") or texto:find("ult") then
                    obj:Click()
                    achou = true
                    StatusLabel.Text = "📱 Status: ⚡ Despertar!"
                    break
                end
            end
        end
        
        -- Tenta tecla R
        if not achou then
            keypress("R")
            task.wait(0.1)
            keyrelease("R")
        end
        
        task.wait(3)
    end
end

-- ========== FUNÇÃO: AUTO CURA ==========
local function autoCurar()
    while curar do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local vida = player.Character.Humanoid.Health
            local maxVida = player.Character.Humanoid.MaxHealth
            
            -- Se vida menor que 40%
            if vida < maxVida * 0.4 then
                -- Procura botão de cura
                local curou = false
                for _, obj in ipairs(player.PlayerGui:GetDescendants()) do
                    if obj:IsA("TextButton") then
                        local texto = (obj.Text or ""):lower()
                        if texto:find("cura") or texto:find("heal") or texto:find("poção") or texto:find("potion") or texto:find("vida") then
                            obj:Click()
                            curou = true
                            StatusLabel.Text = "📱 Status: 💊 Curando..."
                            break
                        end
                    end
                end
                
                -- Tenta tecla Q (comum para cura)
                if not curou then
                    keypress("Q")
                    task.wait(0.1)
                    keyrelease("Q")
                end
            end
        end
        task.wait(1)
    end
end

-- ========== ANTI-AFK ==========
local function ativarAntiAfk()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        if antiAfk then
            vu:CaptureController()
            vu:ClickButton2(Vector2.new())
        end
    end)
end

-- ========== BOTÕES ==========
AtacarBtn.MouseButton1Click:Connect(function()
    atacar = not atacar
    if atacar then
        AtacarBtn.Text = "⚔️ ATACAR ON ⚔️"
        AtacarBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        task.spawn(atacarInimigos)
    else
        AtacarBtn.Text = "⚔️ ATACAR OFF ⚔️"
        AtacarBtn.BackgroundColor3 = Color3.fromRGB(139, 0, 139)
    end
    StatusLabel.Text = "📱 Status: " .. (atacar and "⚔️ Atacando" or "Parado")
end)

DespertarBtn.MouseButton1Click:Connect(function()
    despertar = not despertar
    if despertar then
        DespertarBtn.Text = "⚡ DESPERTAR ON ⚡"
        DespertarBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        task.spawn(ativarDespertar)
    else
        DespertarBtn.Text = "⚡ DESPERTAR OFF ⚡"
        DespertarBtn.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
    end
end)

TeleportBtn.MouseButton1Click:Connect(function()
    teleportar = not teleportar
    if teleportar then
        TeleportBtn.Text = "🌀 TELEPORTE ON 🌀"
        TeleportBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
        task.spawn(teleportarInimigo)
    else
        TeleportBtn.Text = "🌀 TELEPORTE OFF 🌀"
        TeleportBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 139)
    end
end)

CurarBtn.MouseButton1Click:Connect(function()
    curar = not curar
    if curar then
        CurarBtn.Text = "💊 AUTO CURA ON 💊"
        CurarBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        task.spawn(autoCurar)
    else
        CurarBtn.Text = "💊 AUTO CURA OFF 💊"
        CurarBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    end
end)

AntiAfkBtn.MouseButton1Click:Connect(function()
    antiAfk = not antiAfk
    if antiAfk then
        AntiAfkBtn.Text = "🛡️ ANTI-AFK ON 🛡️"
        AntiAfkBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        ativarAntiAfk()
    else
        AntiAfkBtn.Text = "🛡️ ANTI-AFK OFF 🛡️"
        AntiAfkBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end
end)

FecharBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    atacar = false
    despertar = false
    teleportar = false
    curar = false
    antiAfk = false
    print("✅ Interface fechada")
end)

print("✅ Script Mobile COMPLETO carregado!")
print("📱 Funções: Ataque | Despertar | Teleporte | Auto Cura | Anti-AFK")

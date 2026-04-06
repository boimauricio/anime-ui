-- Script Mobile - Anime Final Quest (100% Automático + Minimizável)
local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Variáveis
local atacar = false
local despertar = false
local teleportar = false
local curar = false
local antiAfk = false
local habilidades = false
local coletar = false
local minimizado = false

-- Interface Principal
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local StatusLabel = Instance.new("TextLabel")
local BotoesFrame = Instance.new("Frame") -- Frame para os botões (será minimizado)

-- Botões
local AtacarBtn = Instance.new("TextButton")
local DespertarBtn = Instance.new("TextButton")
local TeleportBtn = Instance.new("TextButton")
local CurarBtn = Instance.new("TextButton")
local AntiAfkBtn = Instance.new("TextButton")
local HabilidadesBtn = Instance.new("TextButton")
local ColetarBtn = Instance.new("TextButton")
local MinimizarBtn = Instance.new("TextButton")
local FecharBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "MobileAutoFarm"

-- Frame principal (arrastável)
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 280, 0, 420)
Frame.Position = UDim2.new(0.5, -140, 0.55, -210)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BackgroundTransparency = 0.2
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true  -- PERMITE MOVER O PAINEL

-- Título
Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "⚔️ AUTO FARM 100% ⚔️"
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

-- Frame dos botões (será minimizado)
BotoesFrame.Parent = Frame
BotoesFrame.Size = UDim2.new(1, 0, 1, -80)
BotoesFrame.Position = UDim2.new(0, 0, 0, 80)
BotoesFrame.BackgroundTransparency = 1

-- Botões (dentro do BotoesFrame)
local function criarBotao(texto, posY, cor, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = BotoesFrame
    btn.Size = UDim2.new(0, 240, 0, 38)
    btn.Position = UDim2.new(0.5, -120, 0, posY)
    btn.Text = texto
    btn.BackgroundColor3 = cor
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 14
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local atacarBtn = criarBotao("⚔️ ATACAR OFF ⚔️", 5, Color3.fromRGB(139, 0, 139), function()
    atacar = not atacar
    atacarBtn.Text = atacar and "⚔️ ATACAR ON ⚔️" or "⚔️ ATACAR OFF ⚔️"
    atacarBtn.BackgroundColor3 = atacar and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(139, 0, 139)
    if atacar then task.spawn(atacarInimigos) end
end)

local despertarBtn = criarBotao("⚡ DESPERTAR OFF ⚡", 48, Color3.fromRGB(139, 0, 0), function()
    despertar = not despertar
    despertarBtn.Text = despertar and "⚡ DESPERTAR ON ⚡" or "⚡ DESPERTAR OFF ⚡"
    despertarBtn.BackgroundColor3 = despertar and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(139, 0, 0)
    if despertar then task.spawn(ativarDespertar) end
end)

local teleportBtn = criarBotao("🌀 TELEPORTE OFF 🌀", 91, Color3.fromRGB(0, 100, 139), function()
    teleportar = not teleportar
    teleportBtn.Text = teleportar and "🌀 TELEPORTE ON 🌀" or "🌀 TELEPORTE OFF 🌀"
    teleportBtn.BackgroundColor3 = teleportar and Color3.fromRGB(0, 150, 200) or Color3.fromRGB(0, 100, 139)
    if teleportar then task.spawn(teleportarInimigo) end
end)

local curarBtn = criarBotao("💊 AUTO CURA OFF 💊", 134, Color3.fromRGB(0, 100, 0), function()
    curar = not curar
    curarBtn.Text = curar and "💊 AUTO CURA ON 💊" or "💊 AUTO CURA OFF 💊"
    curarBtn.BackgroundColor3 = curar and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(0, 100, 0)
    if curar then task.spawn(autoCurar) end
end)

local antiAfkBtn = criarBotao("🛡️ ANTI-AFK OFF 🛡️", 177, Color3.fromRGB(30, 30, 30), function()
    antiAfk = not antiAfk
    antiAfkBtn.Text = antiAfk and "🛡️ ANTI-AFK ON 🛡️" or "🛡️ ANTI-AFK OFF 🛡️"
    antiAfkBtn.BackgroundColor3 = antiAfk and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(30, 30, 30)
    if antiAfk then ativarAntiAfk() end
end)

local habilidadesBtn = criarBotao("✨ HABILIDADES OFF ✨", 220, Color3.fromRGB(255, 140, 0), function()
    habilidades = not habilidades
    habilidadesBtn.Text = habilidades and "✨ HABILIDADES ON ✨" or "✨ HABILIDADES OFF ✨"
    habilidadesBtn.BackgroundColor3 = habilidades and Color3.fromRGB(200, 100, 0) or Color3.fromRGB(255, 140, 0)
    if habilidades then task.spawn(usarHabilidades) end
end)

local coletarBtn = criarBotao("💰 AUTO COLETAR OFF 💰", 263, Color3.fromRGB(0, 100, 139), function()
    coletar = not coletar
    coletarBtn.Text = coletar and "💰 AUTO COLETAR ON 💰" or "💰 AUTO COLETAR OFF 💰"
    coletarBtn.BackgroundColor3 = coletar and Color3.fromRGB(0, 150, 150) or Color3.fromRGB(0, 100, 139)
    if coletar then task.spawn(autoColetar) end
end)

-- Botão Minimizar (X)
MinimizarBtn.Parent = Frame
MinimizarBtn.Size = UDim2.new(0, 50, 0, 25)
MinimizarBtn.Position = UDim2.new(1, -110, 0, 5)
MinimizarBtn.Text = "➖"
MinimizarBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
MinimizarBtn.TextColor3 = Color3.new(1, 1, 1)
MinimizarBtn.TextSize = 18

-- Botão Fechar (❌)
FecharBtn.Parent = Frame
FecharBtn.Size = UDim2.new(0, 50, 0, 25)
FecharBtn.Position = UDim2.new(1, -55, 0, 5)
FecharBtn.Text = "❌"
FecharBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
FecharBtn.TextColor3 = Color3.new(1, 1, 1)
FecharBtn.TextSize = 14

-- Minimizar
MinimizarBtn.MouseButton1Click:Connect(function()
    minimizado = not minimizado
    if minimizado then
        BotoesFrame.Visible = false
        StatusLabel.Visible = false
        Frame.Size = UDim2.new(0, 280, 0, 50)
        MinimizarBtn.Text = "➕"
    else
        BotoesFrame.Visible = true
        StatusLabel.Visible = true
        Frame.Size = UDim2.new(0, 280, 0, 420)
        MinimizarBtn.Text = "➖"
    end
end)

-- Fechar tudo
FecharBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    atacar = false
    despertar = false
    teleportar = false
    curar = false
    antiAfk = false
    habilidades = false
    coletar = false
end)

-- ========== FUNÇÕES (resistentes a respawn) ==========
function getClosestEnemy()
    local inimigo, distancia = nil, 50
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

function atacarInimigos()
    while atacar do
        local inimigo, dist = getClosestEnemy()
        if inimigo and inimigo:FindFirstChild("HumanoidRootPart") and dist < 30 and player.Character then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position, inimigo.HumanoidRootPart.Position)
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

function teleportarInimigo()
    while teleportar do
        local inimigo = getClosestEnemy()
        if inimigo and inimigo:FindFirstChild("HumanoidRootPart") and player.Character then
            local posInimigo = inimigo.HumanoidRootPart.Position
            player.Character.HumanoidRootPart.CFrame = CFrame.new(posInimigo.X, posInimigo.Y + 2, posInimigo.Z)
            StatusLabel.Text = "📱 Status: 🌀 Teleportando..."
        end
        task.wait(1)
    end
end

function ativarDespertar()
    while despertar do
        local achou = false
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
        if not achou then
            keypress("R")
            task.wait(0.1)
            keyrelease("R")
        end
        task.wait(3)
    end
end

function autoCurar()
    while curar do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local vida = player.Character.Humanoid.Health
            local maxVida = player.Character.Humanoid.MaxHealth
            if vida < maxVida * 0.4 then
                for _, obj in ipairs(player.PlayerGui:GetDescendants()) do
                    if obj:IsA("TextButton") then
                        local texto = (obj.Text or ""):lower()
                        if texto:find("cura") or texto:find("heal") or texto:find("poção") or texto:find("potion") or texto:find("vida") then
                            obj:Click()
                            StatusLabel.Text = "📱 Status: 💊 Curando..."
                            break
                        end
                    end
                end
            end
        end
        task.wait(1)
    end
end

function usarHabilidades()
    local ataques = {"Explosão", "Rugido", "Gigantesco"}
    while habilidades do
        for _, obj in ipairs(player.PlayerGui:GetDescendants()) do
            if obj:IsA("TextButton") then
                for _, hab in ipairs(ataques) do
                    if obj.Text:find(hab) then
                        obj:Click()
                        StatusLabel.Text = "📱 Status: ✨ " .. hab .. "!"
                        task.wait(0.5)
                        break
                    end
                end
            end
        end
        task.wait(2)
    end
end

function autoColetar()
    while coletar do
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (obj.Name:lower():find("moeda") or obj.Name:lower():find("coin") or obj.Name:lower():find("item") or obj.Name:lower():find("loot")) then
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = obj:FindFirstChild("HumanoidRootPart").CFrame
                    StatusLabel.Text = "📱 Status: 💰 Coletando..."
                    task.wait(0.3)
                end
            end
        end
        task.wait(0.5)
    end
end

function ativarAntiAfk()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        if antiAfk then
            vu:CaptureController()
            vu:ClickButton2(Vector2.new())
        end
    end)
end

-- Loop principal (mantém o script vivo)
task.spawn(function()
    while true do
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            task.wait(1)
        end
        task.wait()
    end
end)

print("✅ Script 100% Automático carregado!")
print("📱 Funções: Ataque | Despertar | Teleporte | Cura | Anti-AFK | Habilidades | Coletar")
print("✨ Painel pode ser movido (arraste) | ➖ minimiza | ❌ fecha")

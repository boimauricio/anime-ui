-- Script Mobile COMPLETO - Anime Final Quest
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Criar Interface
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local StatusLabel = Instance.new("TextLabel")
local AtacarBtn = Instance.new("TextButton")
local CurarBtn = Instance.new("TextButton")
local DespertarBtn = Instance.new("TextButton")
local FlutuarBtn = Instance.new("TextButton")
local FecharBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "AFQ_Complete"

-- Fundo
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 280, 0, 320)
Frame.Position = UDim2.new(0.5, -140, 0.6, -160)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BackgroundTransparency = 0.15
Frame.BorderSizePixel = 0

-- Título
Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "⚔️ AUTO FARM COMPLETO ⚔️"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.TextScaled = true

-- Status
StatusLabel.Parent = Frame
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Position = UDim2.new(0, 0, 0, 40)
StatusLabel.Text = "Status: 💤 Parado"
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextSize = 13

-- Botões
local botoes = {
    {texto = "⚡ DESPERTAR OFF ⚡", posY = 75, cor = Color3.fromRGB(255, 69, 0)},
    {texto = "🌊 FLUTUAR OFF 🌊", posY = 115, cor = Color3.fromRGB(0, 150, 200)},
    {texto = "🗡️ ATACAR OFF 🗡️", posY = 155, cor = Color3.fromRGB(139, 92, 246)},
    {texto = "💊 AUTO CURA OFF 💊", posY = 195, cor = Color3.fromRGB(40, 45, 70)},
    {texto = "✨ HABILIDADES OFF ✨", posY = 235, cor = Color3.fromRGB(255, 215, 0)},
    {texto = "❌ FECHAR ❌", posY = 280, cor = Color3.fromRGB(200, 50, 50)}
}

local DespertarBtn = Instance.new("TextButton")
local FlutuarBtn = Instance.new("TextButton")
local AtacarBtn = Instance.new("TextButton")
local CurarBtn = Instance.new("TextButton")
local HabilidadesBtn = Instance.new("TextButton")
local FecharBtn = Instance.new("TextButton")

DespertarBtn.Parent = Frame
FlutuarBtn.Parent = Frame
AtacarBtn.Parent = Frame
CurarBtn.Parent = Frame
HabilidadesBtn.Parent = Frame
FecharBtn.Parent = Frame

DespertarBtn.Size = FlutuarBtn.Size = AtacarBtn.Size = CurarBtn.Size = HabilidadesBtn.Size = UDim2.new(0, 240, 0, 30)
FecharBtn.Size = UDim2.new(0, 240, 0, 30)
DespertarBtn.Position = UDim2.new(0.5, -120, 0, 75)
FlutuarBtn.Position = UDim2.new(0.5, -120, 0, 115)
AtacarBtn.Position = UDim2.new(0.5, -120, 0, 155)
CurarBtn.Position = UDim2.new(0.5, -120, 0, 195)
HabilidadesBtn.Position = UDim2.new(0.5, -120, 0, 235)
FecharBtn.Position = UDim2.new(0.5, -120, 0, 280)

DespertarBtn.Text = "⚡ DESPERTAR OFF ⚡"
FlutuarBtn.Text = "🌊 FLUTUAR OFF 🌊"
AtacarBtn.Text = "🗡️ ATACAR OFF 🗡️"
CurarBtn.Text = "💊 AUTO CURA OFF 💊"
HabilidadesBtn.Text = "✨ HABILIDADES OFF ✨"
FecharBtn.Text = "❌ FECHAR ❌"

for _, btn in ipairs({DespertarBtn, FlutuarBtn, AtacarBtn, CurarBtn, HabilidadesBtn, FecharBtn}) do
    btn.BackgroundColor3 = Color3.fromRGB(40, 45, 70)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 13
    btn.BorderSizePixel = 0
end

-- Variáveis
local atacar = false
local curar = false
local despertar = false
local flutuar = false
local habilidades = false
local ataqueLoop = nil
local curaLoop = nil
local despertarLoop = nil
local flutuarLoop = nil
local habilidadesLoop = nil

-- ========== FUNÇÃO DESPERTAR ==========
local function ativarDespertar()
    while despertar do
        -- Procura a barrinha vermelha (despertar)
        for _, v in ipairs(player.PlayerGui:GetDescendants()) do
            if v:IsA("ImageLabel") and v.BackgroundColor3 == Color3.fromRGB(255, 0, 0) then
                v:Click()
                StatusLabel.Text = "Status: ⚡ Despertar ativado!"
            end
        end
        
        -- Tenta ativar com tecla (se tiver)
        keypress("R")
        task.wait(0.1)
        keyrelease("R")
        
        task.wait(5) -- Espera recarregar
    end
end

-- ========== FUNÇÃO FLUTUAR ==========
local function flutuarInimigos()
    while flutuar do
        local inimigo = nil
        local distancia = 30
        
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v.Name ~= player.Name and v:FindFirstChild("Humanoid") then
                local humano = v:FindFirstChild("Humanoid")
                if humano and humano.Health > 0 then
                    local parte = v:FindFirstChild("HumanoidRootPart")
                    if parte and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = (parte.Position - player.Character.HumanoidRootPart.Position).magnitude
                        if dist < distancia then
                            distancia = dist
                            inimigo = v
                        end
                    end
                end
            end
        end
        
        if inimigo and inimigo:FindFirstChild("HumanoidRootPart") then
            -- Flutua acima do inimigo (5 studs acima)
            local posInimigo = inimigo.HumanoidRootPart.Position
            local novaPos = Vector3.new(posInimigo.X, posInimigo.Y + 5, posInimigo.Z)
            player.Character.HumanoidRootPart.CFrame = CFrame.new(novaPos)
            StatusLabel.Text = "Status: 🌊 Flutuando sobre inimigo"
        end
        
        task.wait(0.5)
    end
end

-- ========== FUNÇÃO ATAQUE ==========
local function atacarInimigos()
    while atacar do
        local inimigo = nil
        local distancia = 50
        
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v.Name ~= player.Name and v:FindFirstChild("Humanoid") then
                local humano = v:FindFirstChild("Humanoid")
                if humano and humano.Health > 0 then
                    local parte = v:FindFirstChild("HumanoidRootPart")
                    if parte and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = (parte.Position - player.Character.HumanoidRootPart.Position).magnitude
                        if dist < distancia then
                            distancia = dist
                            inimigo = v
                        end
                    end
                end
            end
        end
        
        if inimigo and inimigo:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position, inimigo.HumanoidRootPart.Position)
            local VirtualInput = game:GetService("VirtualInputManager")
            VirtualInput:SendMouseButtonEvent(500, 300, 0, true, game, 0)
            VirtualInput:SendMouseButtonEvent(500, 300, 0, false, game, 0)
            StatusLabel.Text = "Status: 🗡️ Atacando..."
        else
            StatusLabel.Text = "Status: 🔍 Procurando..."
        end
        
        task.wait(0.2)
    end
end

-- ========== FUNÇÃO AUTO CURA ==========
local function autoCurar()
    while curar do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local vida = player.Character.Humanoid.Health
            local maxVida = player.Character.Humanoid.MaxHealth
            
            if vida < maxVida * 0.4 then -- 40% da vida
                -- Teleport para a cura (procura item de cura)
                for _, v in ipairs(workspace:GetDescendants()) do
                    if v:IsA("Model") and (v.Name:lower():find("cura") or v.Name:lower():find("heal") or v.Name:lower():find("potion")) then
                        local posCura = v:FindFirstChild("HumanoidRootPart")
                        if posCura then
                            player.Character.HumanoidRootPart.CFrame = posCura.CFrame
                            StatusLabel.Text = "Status: 💊 Teleport para cura!"
                            task.wait(0.5)
                            break
                        end
                    end
                end
                
                -- Procura botão de cura
                for _, v in ipairs(player.PlayerGui:GetDescendants()) do
                    if v:IsA("TextButton") then
                        local texto = v.Text:lower()
                        if texto:find("cura") or texto:find("heal") or texto:find("poção") then
                            v:Click()
                            StatusLabel.Text = "Status: 💊 Curando..."
                            break
                        end
                    end
                end
            end
        end
        task.wait(1)
    end
end

-- ========== FUNÇÃO HABILIDADES ==========
local function usarHabilidades()
    local habilidadesList = {"Rugido", "Meteoro", "Lance de Gigante", "Apagador"}
    
    while habilidades do
        -- Procura botões das habilidades na tela
        for _, v in ipairs(player.PlayerGui:GetDescendants()) do
            if v:IsA("TextButton") then
                for _, hab in ipairs(habilidadesList) do
                    if v.Text:find(hab) then
                        v:Click()
                        StatusLabel.Text = "Status: ✨ Usando " .. hab .. " ✨"
                        task.wait(0.5)
                        break
                    end
                end
            end
        end
        
        -- Tenta usar teclas numericas
        for i = 1, 4 do
            keypress(tostring(i))
            task.wait(0.1)
            keyrelease(tostring(i))
        end
        
        task.wait(2)
    end
end

-- ========== ANTI-AFK ==========
local function startAntiAFK()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
    end)
end

-- ========== BOTÕES ==========
DespertarBtn.MouseButton1Click:Connect(function()
    despertar = not despertar
    if despertar then
        DespertarBtn.Text = "⚡ DESPERTAR ON ⚡"
        DespertarBtn.BackgroundColor3 = Color3.fromRGB(255, 69, 0)
        task.spawn(ativarDespertar)
    else
        DespertarBtn.Text = "⚡ DESPERTAR OFF ⚡"
        DespertarBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 70)
    end
end)

FlutuarBtn.MouseButton1Click:Connect(function()
    flutuar = not flutuar
    if flutuar then
        FlutuarBtn.Text = "🌊 FLUTUAR ON 🌊"
        FlutuarBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
        task.spawn(flutuarInimigos)
    else
        FlutuarBtn.Text = "🌊 FLUTUAR OFF 🌊"
        FlutuarBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 70)
    end
end)

AtacarBtn.MouseButton1Click:Connect(function()
    atacar = not atacar
    if atacar then
        AtacarBtn.Text = "🗡️ ATACAR ON 🗡️"
        AtacarBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
        task.spawn(atacarInimigos)
    else
        AtacarBtn.Text = "🗡️ ATACAR OFF 🗡️"
        AtacarBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 70)
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
        CurarBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 70)
    end
end)

HabilidadesBtn.MouseButton1Click:Connect(function()
    habilidades = not habilidades
    if habilidades then
        HabilidadesBtn.Text = "✨ HABILIDADES ON ✨"
        HabilidadesBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        task.spawn(usarHabilidades)
    else
        HabilidadesBtn.Text = "✨ HABILIDADES OFF ✨"
        HabilidadesBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 70)
    end
end)

FecharBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    atacar = false
    curar = false
    despertar = false
    flutuar = false
    habilidades = false
    print("Interface fechada")
end)

-- Iniciar Anti-AFK
startAntiAFK()

print("✅ Script COMPLETO carregado!")
print("📱 Todas as funções ativadas!")

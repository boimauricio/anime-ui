-- Script Mobile Completo - Anime Final Quest
local player = game.Players.LocalPlayer

-- Criar Interface (tabela flutuante)
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local AtacarBtn = Instance.new("TextButton")
local CurarBtn = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "MobileUI"

-- Fundo da interface
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 250, 0, 180)
Frame.Position = UDim2.new(0.5, -125, 0.7, -90)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BackgroundTransparency = 0.2
Frame.BorderSizePixel = 0

-- Título
Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "⚔️ AUTO FARM ⚔️"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.TextScaled = true

-- Status
StatusLabel.Parent = Frame
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0, 40)
StatusLabel.Text = "Status: 💤 Parado"
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextSize = 14

-- Botão Atacar
AtacarBtn.Parent = Frame
AtacarBtn.Size = UDim2.new(0, 200, 0, 40)
AtacarBtn.Position = UDim2.new(0.5, -100, 0, 80)
AtacarBtn.Text = "▶️ ATACAR OFF ▶️"
AtacarBtn.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
AtacarBtn.TextColor3 = Color3.new(1, 1, 1)
AtacarBtn.TextSize = 16

-- Botão Curar
CurarBtn.Parent = Frame
CurarBtn.Size = UDim2.new(0, 200, 0, 35)
CurarBtn.Position = UDim2.new(0.5, -100, 0, 125)
CurarBtn.Text = "💊 AUTO CURA OFF 💊"
CurarBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 70)
CurarBtn.TextColor3 = Color3.new(1, 1, 1)
CurarBtn.TextSize = 14

-- Variáveis de controle
local atacar = false
local curar = false
local ataqueLoop = nil
local curaLoop = nil

-- ========== FUNÇÃO ATAQUE ==========
local function atacarInimigos()
    while atacar do
        -- Procura inimigo mais próximo
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
        
        -- Ataca se achou inimigo
        if inimigo and inimigo:FindFirstChild("HumanoidRootPart") then
            -- Mira no inimigo
            player.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position, inimigo.HumanoidRootPart.Position)
            -- Simula clique na tela
            local VirtualInput = game:GetService("VirtualInputManager")
            VirtualInput:SendMouseButtonEvent(500, 300, 0, true, game, 0)
            VirtualInput:SendMouseButtonEvent(500, 300, 0, false, game, 0)
            StatusLabel.Text = "Status: ⚔️ Atacando..."
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
            
            -- Se vida menor que 50%, tenta curar
            if vida < maxVida * 0.5 then
                -- Procura botão de cura na tela
                local curou = false
                for _, v in ipairs(player.PlayerGui:GetDescendants()) do
                    if v:IsA("TextButton") then
                        local texto = v.Text:lower()
                        if texto:find("cura") or texto:find("heal") or texto:find("poção") or texto:find("potion") then
                            v:Click()
                            StatusLabel.Text = "Status: 💊 Curando..."
                            curou = true
                            break
                        end
                    end
                end
                
                -- Se não achou botão, tenta tecla Q
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
local function startAntiAFK()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
        StatusLabel.Text = "Status: 🔄 Anti-AFK ativado"
    end)
end

-- ========== BOTÕES ==========
-- Botão Atacar
AtacarBtn.MouseButton1Click:Connect(function()
    atacar = not atacar
    if atacar then
        AtacarBtn.Text = "⏸️ ATACAR ON ⏸️"
        AtacarBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
        StatusLabel.Text = "Status: 🎯 Atacando..."
        task.spawn(atacarInimigos)
    else
        AtacarBtn.Text = "▶️ ATACAR OFF ▶️"
        AtacarBtn.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
        StatusLabel.Text = "Status: 💤 Parado"
    end
end)

-- Botão Curar
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

-- Iniciar Anti-AFK automaticamente
startAntiAFK()

print("✅ Script Mobile Completo carregado!")
print("📱 Use os botões para ligar/desligar as funções")

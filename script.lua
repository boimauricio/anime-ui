-- Script Mobile - Anime Final Quest (Painel Azul - Modo Foda)
local player = game.Players.LocalPlayer

-- Criar Interface
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local StatusLabel = Instance.new("TextLabel")
local BotoesFrame = Instance.new("Frame")

-- Botões
local PrincipalBtn = Instance.new("TextButton")
local DespertarBtn = Instance.new("TextButton")
local TeleportBtn = Instance.new("TextButton")
local AntiAfkBtn = Instance.new("TextButton")
local MinimizarBtn = Instance.new("TextButton")
local FecharBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "AutoFarmFoda"

-- PAINEL AZUL FODA
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 300, 0, 350)
Frame.Position = UDim2.new(0.5, -150, 0.55, -175)
Frame.BackgroundColor3 = Color3.fromRGB(10, 20, 50) -- Azul escuro foda
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
-- Borda brilhante
local UICorner = Instance.new("UICorner")
UICorner.Parent = Frame
UICorner.CornerRadius = UDim.new(0, 12)

-- Título FODA
Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "⚔️ MODO FODA ⚔️"
Title.TextColor3 = Color3.fromRGB(0, 200, 255) -- Azul clarinho foda
Title.BackgroundTransparency = 1
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold

-- Status
StatusLabel.Parent = Frame
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0, 50)
StatusLabel.Text = "💤 Status: Parado"
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextSize = 14

-- Frame dos botões
BotoesFrame.Parent = Frame
BotoesFrame.Size = UDim2.new(1, 0, 1, -90)
BotoesFrame.Position = UDim2.new(0, 0, 0, 85)
BotoesFrame.BackgroundTransparency = 1

-- Função para criar botões bonitos
local function criarBotao(texto, posY, cor, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = BotoesFrame
    btn.Size = UDim2.new(0, 260, 0, 45)
    btn.Position = UDim2.new(0.5, -130, 0, posY)
    btn.Text = texto
    btn.BackgroundColor3 = cor
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 16
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    local btnCorner = Instance.new("UICorner")
    btnCorner.Parent = btn
    btnCorner.CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Variáveis
local principal = false
local despertar = false
local teleportar = false
local antiAfk = false

-- Botão PRINCIPAL (liga tudo)
local principalBtn = criarBotao("🔥 INICIAR TUDO OFF", 5, Color3.fromRGB(0, 100, 200), function()
    principal = not principal
    if principal then
        principalBtn.Text = "🔥 INICIAR TUDO ON 🔥"
        principalBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
        StatusLabel.Text = "💪 Status: MODO FODA ATIVADO!"
        task.spawn(atacarInimigos)
        task.spawn(usarHabilidades)
        task.spawn(pegarCura)
    else
        principalBtn.Text = "🔥 INICIAR TUDO OFF"
        principalBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        StatusLabel.Text = "💤 Status: Parado"
    end
end)

-- Botão Despertar
local despertarBtn = criarBotao("⚡ DESPERTAR OFF", 60, Color3.fromRGB(100, 50, 150), function()
    despertar = not despertar
    despertarBtn.Text = despertar and "⚡ DESPERTAR ON ⚡" or "⚡ DESPERTAR OFF"
    despertarBtn.BackgroundColor3 = despertar and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(100, 50, 150)
    if despertar then task.spawn(ativarDespertar) end
end)

-- Botão Teleporte
local teleportBtn = criarBotao("🌀 TELEPORTE OFF", 115, Color3.fromRGB(0, 150, 150), function()
    teleportar = not teleportar
    teleportBtn.Text = teleportar and "🌀 TELEPORTE ON 🌀" or "🌀 TELEPORTE OFF"
    teleportBtn.BackgroundColor3 = teleportar and Color3.fromRGB(0, 200, 200) or Color3.fromRGB(0, 150, 150)
    if teleportar then task.spawn(teleportarInimigo) end
end)

-- Botão Anti-AFK
local antiAfkBtn = criarBotao("🛡️ ANTI-AFK OFF", 170, Color3.fromRGB(80, 80, 100), function()
    antiAfk = not antiAfk
    antiAfkBtn.Text = antiAfk and "🛡️ ANTI-AFK ON 🛡️" or "🛡️ ANTI-AFK OFF"
    antiAfkBtn.BackgroundColor3 = antiAfk and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(80, 80, 100)
    if antiAfk then ativarAntiAfk() end
end)

-- Botões Minimizar e Fechar
MinimizarBtn.Parent = Frame
MinimizarBtn.Size = UDim2.new(0, 50, 0, 30)
MinimizarBtn.Position = UDim2.new(1, -110, 0, 8)
MinimizarBtn.Text = "➖"
MinimizarBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 150)
MinimizarBtn.TextColor3 = Color3.new(1, 1, 1)
MinimizarBtn.TextSize = 20
MinimizarBtn.BorderSizePixel = 0
local miniCorner = Instance.new("UICorner")
miniCorner.Parent = MinimizarBtn
miniCorner.CornerRadius = UDim.new(0, 6)

FecharBtn.Parent = Frame
FecharBtn.Size = UDim2.new(0, 50, 0, 30)
FecharBtn.Position = UDim2.new(1, -55, 0, 8)
FecharBtn.Text = "❌"
FecharBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
FecharBtn.TextColor3 = Color3.new(1, 1, 1)
FecharBtn.TextSize = 16
FecharBtn.BorderSizePixel = 0
local fecharCorner = Instance.new("UICorner")
fecharCorner.Parent = FecharBtn
fecharCorner.CornerRadius = UDim.new(0, 6)

-- Minimizar
local minimizado = false
MinimizarBtn.MouseButton1Click:Connect(function()
    minimizado = not minimizado
    if minimizado then
        BotoesFrame.Visible = false
        StatusLabel.Visible = false
        Frame.Size = UDim2.new(0, 300, 0, 60)
        MinimizarBtn.Text = "➕"
    else
        BotoesFrame.Visible = true
        StatusLabel.Visible = true
        Frame.Size = UDim2.new(0, 300, 0, 350)
        MinimizarBtn.Text = "➖"
    end
end)

-- Fechar
FecharBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    principal = false
    despertar = false
    teleportar = false
    antiAfk = false
end)

-- ========== FUNÇÕES ==========

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
    while principal do
        local inimigo, dist = getClosestEnemy()
        if inimigo and inimigo:FindFirstChild("HumanoidRootPart") and dist < 30 and player.Character then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position, inimigo.HumanoidRootPart.Position)
            -- Clica no botão M1 da interface
            for _, btn in ipairs(player.PlayerGui:GetDescendants()) do
                if btn:IsA("TextButton") and (btn.Text == "M1" or btn.Text:find("M1")) then
                    btn:Click()
                    break
                end
            end
            StatusLabel.Text = "⚔️ Status: Atacando..."
        end
        task.wait(0.15)
    end
end

function teleportarInimigo()
    while teleportar do
        local inimigo = getClosestEnemy()
        if inimigo and inimigo:FindFirstChild("HumanoidRootPart") and player.Character then
            local pos = inimigo.HumanoidRootPart.Position
            player.Character.HumanoidRootPart.CFrame = CFrame.new(pos.X, pos.Y + 2, pos.Z)
        end
        task.wait(1)
    end
end

function ativarDespertar()
    while despertar do
        -- Verifica barra vermelha na tela
        for _, obj in ipairs(player.PlayerGui:GetDescendants()) do
            if obj:IsA("TextLabel") and obj.Text:match("%d+%%") then
                local percentual = tonumber(obj.Text:match("%d+"))
                if percentual and percentual >= 100 then
                    -- Clica no botão IMPACTO IMPOSSIVEL
                    for _, btn in ipairs(player.PlayerGui:GetDescendants()) do
                        if btn:IsA("TextButton") and (btn.Text == "IMPACTO IMPOSSIVEL" or btn.Text:find("IMPACTO")) then
                            btn:Click()
                            StatusLabel.Text = "⚡ Status: Despertar ativado!"
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
    local habilidadesList = {"EXPLOSAO GIGANTE", "RUGIDO", "GIGANTESCO"}
    while principal do
        for _, btn in ipairs(player.PlayerGui:GetDescendants()) do
            if btn:IsA("TextButton") then
                for _, hab in ipairs(habilidadesList) do
                    if btn.Text == hab or btn.Text:find(hab) then
                        btn:Click()
                        StatusLabel.Text = "✨ Usando " .. hab
                        task.wait(0.5)
                        break
                    end
                end
            end
        end
        task.wait(2)
    end
end

function pegarCura()
    while principal do
        -- Procura item de cura no chão
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (obj.Name:lower():find("cura") or obj.Name:lower():find("vida") or obj.Name:lower():find("hp") or obj.Name:lower():find("potion") or obj.Name:lower():find("heart")) then
                local parte = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("PrimaryPart")
                if parte and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = parte.CFrame
                    StatusLabel.Text = "💊 Pegando cura..."
                    task.wait(0.3)
                    break
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

print("✅ Painel Azul - MODO FODA carregado!")
print("💙 Clique em INICIAR TUDO para ativar ataque + habilidades + cura")

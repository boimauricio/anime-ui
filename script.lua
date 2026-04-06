-- ============================================
-- 🔷 SCRIPT MODO FODA V2 - ANIME FINAL QUEST 🔷
-- 🔷 ESPECIAL PARA DELTA NO CELULAR 🔷
-- ============================================
local player = game.Players.LocalPlayer
local ligado = false

-- ========== CRIAR PAINEL AZUL ==========
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local StatusLabel = Instance.new("TextLabel")
local IniciarBtn = Instance.new("TextButton")
local FecharBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "AutoFarmFodaV2"

-- Painel principal
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 280, 0, 180)
Frame.Position = UDim2.new(0.5, -140, 0.55, -90)
Frame.BackgroundColor3 = Color3.fromRGB(10, 20, 50)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.Parent = Frame
UICorner.CornerRadius = UDim.new(0, 12)

-- Título
Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "⚔️ MODO FODA V2 ⚔️"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
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

-- Botão Iniciar/Parar
IniciarBtn.Parent = Frame
IniciarBtn.Size = UDim2.new(0, 200, 0, 50)
IniciarBtn.Position = UDim2.new(0.5, -100, 0, 90)
IniciarBtn.Text = "▶ INICIAR FARM"
IniciarBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
IniciarBtn.TextColor3 = Color3.new(1, 1, 1)
IniciarBtn.TextSize = 18
IniciarBtn.Font = Enum.Font.GothamBold
IniciarBtn.BorderSizePixel = 0

local btnCorner = Instance.new("UICorner")
btnCorner.Parent = IniciarBtn
btnCorner.CornerRadius = UDim.new(0, 8)

-- Botão Fechar
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

-- ========== FUNÇÕES ÚTEIS ==========

-- Função para clicar em botões da interface
local function clicarBotao(nomeBotao)
    for _, btn in ipairs(player.PlayerGui:GetDescendants()) do
        if btn:IsA("TextButton") and (btn.Text == nomeBotao or btn.Text:find(nomeBotao)) then
            btn:Click()
            return true
        end
    end
    return false
end

-- Função para encontrar o inimigo mais próximo
function getClosestEnemy()
    local inimigo, distancia = nil, 60
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

-- Função para andar em círculos (agrupamento)
local angulo = 0
function andarEmCirculos()
    angulo = angulo + 0.5
    local raio = 15
    local center = player.Character.HumanoidRootPart.Position
    local x = center.X + math.cos(math.rad(angulo)) * raio
    local z = center.Z + math.sin(math.rad(angulo)) * raio
    local y = center.Y
    player.Character.Humanoid:MoveTo(Vector3.new(x, y, z))
end

-- ========== SISTEMAS DO FARM ==========

-- Ataque automático + agrupamento
task.spawn(function()
    while ligado do
        local inimigo, dist = getClosestEnemy()
        
        if inimigo and inimigo:FindFirstChild("HumanoidRootPart") and dist < 35 and player.Character then
            -- Olha pro inimigo
            player.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position, inimigo.HumanoidRootPart.Position)
            -- Ataca
            clicarBotao("M1")
            StatusLabel.Text = "⚔️ Atacando..."
        else
            -- Sem inimigo perto, anda em círculos (agrupa os inimigos)
            andarEmCirculos()
            StatusLabel.Text = "🌀 Agrupando inimigos..."
        end
        
        task.wait(0.2)
    end
end)

-- Usar habilidades automaticamente
task.spawn(function()
    local habilidades = {"EXPLOSAO GIGANTE", "RUGIDO", "GIGANTESCO"}
    while ligado do
        for _, hab in ipairs(habilidades) do
            clicarBotao(hab)
            task.wait(0.3)
        end
        task.wait(2)
    end
end)

-- Pegar cura no chão
task.spawn(function()
    while ligado do
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
end)

-- Despertar automático (Ultimate)
task.spawn(function()
    while ligado do
        for _, obj in ipairs(player.PlayerGui:GetDescendants()) do
            if obj:IsA("TextLabel") and obj.Text:match("%d+%%") then
                local percentual = tonumber(obj.Text:match("%d+"))
                if percentual and percentual >= 100 then
                    clicarBotao("IMPACTO IMPOSSIVEL")
                    StatusLabel.Text = "⚡ DESPERTAR ATIVADO! ⚡"
                    task.wait(1)
                end
            end
        end
        task.wait(0.5)
    end
end)

-- Anti-AFK
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    if ligado then
        local vu = game:GetService("VirtualUser")
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
    end
end)

-- ========== BOTÕES DO PAINEL ==========

IniciarBtn.MouseButton1Click:Connect(function()
    ligado = not ligado
    if ligado then
        IniciarBtn.Text = "⏸ PARAR FARM"
        IniciarBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        StatusLabel.Text = "💪 FARM ATIVADO!"
    else
        IniciarBtn.Text = "▶ INICIAR FARM"
        IniciarBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        StatusLabel.Text = "💤 Farm parado"
    end
end)

FecharBtn.MouseButton1Click:Connect(function()
    ligado = false
    ScreenGui:Destroy()
end)

print("✅ MODO FODA V2 CARREGADO!")
print("💙 Clique em INICIAR FARM no painel azul")

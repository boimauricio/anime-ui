-- ============================================
-- ANIME FINAL QUEST - AUTO FARM 100%
-- COM BOTÃO FLUTUANTE PRA LIGAR/DESLIGAR
-- ============================================

local player = game.Players.LocalPlayer
local ligado = true
local espera = task.wait

-- ========== CRIAR BOTÃO NA TELA ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoFarmGUI"
screenGui.Parent = player.PlayerGui

local botao = Instance.new("TextButton")
botao.Size = UDim2.new(0, 150, 0, 50)
botao.Position = UDim2.new(0.8, 0, 0.05, 0)
botao.Text = "🔴 DESLIGAR"
botao.TextSize = 18
botao.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
botao.TextColor3 = Color3.fromRGB(255, 255, 255)
botao.Parent = screenGui

-- Arredondar bordas
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = botao

-- Função do botão
botao.MouseButton1Click:Connect(function()
    ligado = not ligado
    if ligado then
        botao.Text = "🔴 DESLIGAR"
        botao.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        print("✅ Script LIGADO")
    else
        botao.Text = "🟢 LIGAR"
        botao.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        print("⛔ Script DESLIGADO")
    end
end)

-- ========== FUNÇÕES DO SCRIPT ==========
local function clicarBotao(nomeBotao)
    for _, btn in ipairs(player.PlayerGui:GetDescendants()) do
        if btn:IsA("TextButton") and (btn.Text == nomeBotao or string.find(btn.Text, nomeBotao)) then
            btn:Click()
            return true
        end
    end
    return false
end

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

local angulo = 0
function andarEmCirculos()
    angulo = angulo + 0.5
    local raio = 12
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local center = player.Character.HumanoidRootPart.Position
        local x = center.X + math.cos(math.rad(angulo)) * raio
        local z = center.Z + math.sin(math.rad(angulo)) * raio
        player.Character.Humanoid:MoveTo(Vector3.new(x, center.Y, z))
    end
end

function pegarItens()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Handle") and obj.Name == "Heart" then
            local parte = obj:FindFirstChild("Handle")
            if parte and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (parte.Position - player.Character.HumanoidRootPart.Position).magnitude
                if dist < 15 then
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(parte.Position)
                    espera(0.1)
                end
            end
        end
    end
end

-- ========== LOOPS PRINCIPAIS ==========
task.spawn(function()
    while true do
        if ligado then
            local inimigo, dist = getClosestEnemy()
            if inimigo and inimigo:FindFirstChild("HumanoidRootPart") and dist < 40 and player.Character then
                local hrp = player.Character.HumanoidRootPart
                local alvoHrp = inimigo.HumanoidRootPart
                if hrp and alvoHrp then
                    hrp.CFrame = CFrame.new(hrp.Position, alvoHrp.Position)
                end
                clicarBotao("Lock")
                clicarBotao("M1")
            else
                andarEmCirculos()
            end
        end
        espera(0.15)
    end
end)

task.spawn(function()
    local habilidades = {"Skill", "Ultimate", "Awakening", "Despertar"}
    while true do
        if ligado then
            for _, hab in ipairs(habilidades) do
                clicarBotao(hab)
                espera(0.8)
            end
        end
        espera(2)
    end
end)

task.spawn(function()
    while true do
        if ligado then
            pegarItens()
        end
        espera(1)
    end
end)

task.spawn(function()
    while true do
        if ligado then
            clicarBotao("Skip")
            clicarBotao("Next")
            clicarBotao("Replay")
            clicarBotao("Again")
        end
        espera(3)
    end
end)

print("✅ ANIME FINAL QUEST - AUTO FARM CARREGADO!")
print("🟢 Botão vermelho no canto direito da tela para ligar/desligar")

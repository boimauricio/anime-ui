-- ============================================
-- SCRIPT DE TESTE - TENTA VÁRIOS BOTÕES
-- ============================================

local player = game.Players.LocalPlayer
local ligado = true

-- Lista de possíveis nomes para cada ação
local possiveisAtaques = {"M1", "Click", "Atacar", "Attack", "Golpe", "Bater"}
local possiveisLock = {"Lock", "Lock-On", "Mira", "Target"}
local possiveisHabilidades = {"Skill", "Q", "E", "R", "F", "Ultimate", "Ult", "Despertar", "Awakening"}

local function clicarBotao(listaNomes)
    for _, nome in ipairs(listaNomes) do
        for _, btn in ipairs(player.PlayerGui:GetDescendants()) do
            if btn:IsA("TextButton") and (btn.Text == nome or string.find(btn.Text, nome)) then
                btn:Click()
                print("✅ Clicou em: " .. nome)
                return true
            end
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

-- CRIAR BOTÃO NA TELA
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local botao = Instance.new("TextButton")
botao.Size = UDim2.new(0, 150, 0, 50)
botao.Position = UDim2.new(0.8, 0, 0.05, 0)
botao.Text = "🔴 DESLIGAR"
botao.TextSize = 18
botao.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
botao.Parent = screenGui

botao.MouseButton1Click:Connect(function()
    ligado = not ligado
    if ligado then
        botao.Text = "🔴 DESLIGAR"
        botao.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    else
        botao.Text = "🟢 LIGAR"
        botao.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    end
end)

-- LOOP PRINCIPAL
task.spawn(function()
    while true do
        if ligado then
            local inimigo, dist = getClosestEnemy()
            if inimigo and dist < 40 and player.Character then
                -- Tenta ativar Lock
                clicarBotao(possiveisLock)
                -- Tenta atacar
                clicarBotao(possiveisAtaques)
                -- Tenta usar habilidades
                clicarBotao(possiveisHabilidades)
            end
        end
        task.wait(0.2)
    end
end)

print("✅ SCRIPT DE TESTE CARREGADO!")
print("🔴 Botão no canto direito para ligar/desligar")
print("📝 Olhe no console do executor para ver quais botões foram clicados")

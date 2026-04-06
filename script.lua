-- ============================================
-- 🔷 SCRIPT MODO FODA V2 - COMPLETO 🔷
-- ATAQUE + AGRUPAMENTO + HABILIDADES + CURA + DESPERTAR
-- ============================================
local player = game.Players.LocalPlayer
local ligado = true  -- Já começa ligado

-- ========== FUNÇÃO PARA CLICAR ==========
local function clicarBotao(nomeBotao)
    for _, btn in ipairs(player.PlayerGui:GetDescendants()) do
        if btn:IsA("TextButton") and (btn.Text == nomeBotao or btn.Text:find(nomeBotao)) then
            btn:Click()
            return true
        end
    end
    return false
end

-- ========== ACHAR INIMIGO ==========
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

-- ========== ANDAR EM CÍRCULOS (agrupar) ==========
local angulo = 0
function andarEmCirculos()
    angulo = angulo + 0.5
    local raio = 15
    local center = player.Character.HumanoidRootPart.Position
    local x = center.X + math.cos(math.rad(angulo)) * raio
    local z = center.Z + math.sin(math.rad(angulo)) * raio
    player.Character.Humanoid:MoveTo(Vector3.new(x, center.Y, z))
end

-- ========== ATAQUE + AGRUPAMENTO ==========
task.spawn(function()
    while ligado do
        local inimigo, dist = getClosestEnemy()
        if inimigo and inimigo:FindFirstChild("HumanoidRootPart") and dist < 35 and player.Character then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position, inimigo.HumanoidRootPart.Position)
            clicarBotao("M1")
        else
            andarEmCirculos()
        end
        task.wait(0.2)
    end
end)

-- ========== HABILIDADES ==========
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

-- ========== PEGAR CURA ==========
task.spawn(function()
    while ligado do
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj

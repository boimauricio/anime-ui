-- ============================================
-- SCRIPT SIMPLES - ATAQUE + DESPERTAR
-- PARA DELTA NO CELULAR
-- ============================================
local player = game.Players.LocalPlayer
local ligado = true  -- Já começa ligado!

-- ========== FUNÇÃO PARA CLICAR NOS BOTÕES ==========
local function clicarBotao(nomeBotao)
    for _, btn in ipairs(player.PlayerGui:GetDescendants()) do
        if btn:IsA("TextButton") and (btn.Text == nomeBotao or btn.Text:find(nomeBotao)) then
            btn:Click()
            return true
        end
    end
    return false
end

-- ========== ATAQUE AUTOMÁTICO (M1) ==========
task.spawn(function()
    while ligado do
        clicarBotao("M1")
        task.wait(0.15)  -- Ataque rápido
    end
end)

-- ========== DESPERTAR AUTOMÁTICO (Quando chegar em 100%) ==========
task.spawn(function()
    while ligado do
        -- Procura a barra de porcentagem (ex: "25.00%")
        for _, obj in ipairs(player.PlayerGui:GetDescendants()) do
            if obj:IsA("TextLabel") and obj.Text:match("%d+%%") then
                local percentual = tonumber(obj.Text:match("%d+"))
                if percentual and percentual >= 100 then
                    clicarBotao("IMPACTO IMPOSSIVEL")
                    print("⚡ DESPERTAR ATIVADO!")
                    task.wait(2)  -- Espera pra não ativar várias vezes
                end
            end
        end
        task.wait(0.5)
    end
end)

print("✅ SCRIPT SIMPLES ATIVADO!")
print("⚔️ Atacando automaticamente")
print("⚡ Vai ativar o despertar quando chegar a 100%")

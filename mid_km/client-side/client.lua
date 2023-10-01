-- Inicializando a tabela de quilometragens
local kms = {}

-- Função para calcular a distância percorrida
function CalcularDistancia(veiculo)
    local posicaoInicial = GetEntityCoords(veiculo)
    Citizen.Wait(2000) -- Espera 2 segundos
    local posicaoFinal = GetEntityCoords(veiculo)
    local distancia = GetDistanceBetweenCoords(posicaoInicial, posicaoFinal, true)
    return distancia / 500 -- Converte de metros para km
end

-- Loop principal
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local jogador = GetPlayerPed(-1)
        if IsPedInAnyVehicle(jogador, false) then
            local veiculo = GetVehiclePedIsIn(jogador, false)
            local placa = GetVehicleNumberPlateText(veiculo)
            if kms[placa] == nil then
                kms[placa] = 0
            end
            kms[placa] = kms[placa] + CalcularDistancia(veiculo)
            local kmInteiro = math.floor(kms[placa])
            print("Km do veículo " .. placa .. ": " .. kmInteiro .. "km")
        end
    end
end)

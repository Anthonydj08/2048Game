-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local movimentos = require 'movimentos'

local background = display.newImage("images/background.png")
background:scale(2, 2)

local screenW, screenH, halfW, halfH = display.viewableContentWidth,
                                       display.viewableContentHeight,
                                       display.viewableContentWidth * 0.5,
                                       display.viewableContentHeight * 0.5
numeroColunas = 4
larguraColuna = math.floor(screenW / numeroColunas)

textoTela = {}
tab = {}
placar = 0;

function getPosicaoColuna(numColuna) return (numColuna - 1) * larguraColuna end

vetor= {}
function iniciaVetor()
    for i = 1, 4 do
        vetor[i] = {}
        for j = 1, 4 do
            vetor[i][j] = 0
        end
    end
end
 

local function novoJogo(event)
    local pontuacao = display.newImage("images/back.png", 240, -8)
    pontuacao:scale(1, 0.5)
    for i = 1, numeroColunas do
        textoTela[i] = {}
        tab[i] = {}
        for j = 1, 4 do

            local coluna = i + 0.5
            local linha = j * 75 - 10

            x = getPosicaoColuna(coluna)
            y = linha

            local options = 
            {
                text = "",     
                x = x,
                y = y,
               
                font = native.systemFont,   
                fontSize = 40,
            }
            local options2 = 
            {
                text = "",     
                x = 240,
                y = 5,
               
                font = native.systemFont,   
                fontSize = 30,
            }
            local options3 = 
            {
                text = "Pontuação",     
                x = 240,
                y = -20,
               
                font = native.systemFont,   
                fontSize = 20,
            }
            
            local myRectangle = display.newRect(x, y, 75, 75)

            local cubo = display.newImage("images/back.png", x, y)
            cubo:scale(0.63, 0.61)

            textoTela[i][j] = display.newText(options)
            textoTela[i][j].y = y
            textoTela[i][j].x = x
            textoTela[i][j]:setFillColor( 0, 0, 0 )

            nomePlacar = display.newText(options3)
            nomePlacar:setFillColor(1,1,1)

            placarTela = display.newText(options2)
            placarTela:setFillColor(1, 1, 1)
        end
    end
    iniciaVetor()
end

function random()
    math.randomseed(os.time())
    num = math.random(4)
    if (num <= 2) then
        return 2
    else
        return 4
    end
end

function verificaPosicao(i, j)
    if(vetor[i][j] ~= 0 ) then
        return false
    else
        return true
    end
end

function checkGameOver()
    contador = 0;
    for i = 1, 4 do
        for j = 1, 4 do
            if(vetor[i][j] == 0) then
            contador = contador + 1
            end
        end
    end
    if (contador == 0) then
        novoJogo()
    else
        return false
    end
end

function numeroAleatorio()
checkGameOver()
    local count = 0;
    while ( count == 0) do
        local num1 = math.random(4)
        local num2 = math.random(4)
        
        --textoTela[num1][num2].text = vetor[random()][random()]
        placarTela.text = placar
        if (verificaPosicao(num1, num2)) then
            vetor[num1][num2] = random()
            for i = 1, 4 do
                for j = 1, 4 do
                    if (textoTela[i][j] ~= 0) then
                        textoTela[i][j].text = vetor[i][j]
                        count = 1
                    else
                        count = 0
                    end
                    --print("textoTela",textoTela[i][j].text, " vetor", vetor[i][j])
                end
            end
        else
        end
    end
end

local function irCima(event)
    if (event.phase == "ended") then
        for k = 1, #vetor do
            for i = 4, 1, -1 do
              for j = 1, #vetor do
                while ((vetor[i][j-1] == 0) and (vetor[i][j]~=0)) do
                  vetor[i][j-1] = vetor[i][j];
                  vetor[i][j] = 0;
                  i = 4;
                end
                if vetor[i][j-1] == vetor[i][j] then
                  vetor[i][j] = vetor[i][j-1]*2;
                  placar =  placar + vetor[i][j];
                  vetor[i][j-1] = 0;
                end
              end
            end
          end
        numeroAleatorio()
    end   
end
local function irBaixo(event)
    if (event.phase == "ended") then
        for k = 1, #vetor do
            for i = 4, 1, -1 do
              for j = 1, #vetor do
                while ((vetor[i][j+1] == 0) and (vetor[i][j]~=0)) do
                  vetor[i][j+1] = vetor[i][j];
                  vetor[i][j] = 0;
                  i = 4;
                end
                if vetor[i][j+1] == vetor[i][j] then
                  vetor[i][j] = vetor[i][j+1]*2;
                  placar =  placar + vetor[i][j];
                  vetor[i][j+1] = 0;
                end
              end
            end
          end
        numeroAleatorio()
    end
end
local function irEsquerda(event)
    if (event.phase == "ended") then 
        for k = 1, #vetor do
            for i = 4, 2, -1 do
                for j = 1, #vetor do
                    while ((vetor[i-1][j] == 0) and (vetor[i][j]~=0)) do
                        vetor[i-1][j] = vetor[i][j];
                        vetor[i][j] = 0;
                        i = 4;
                    end
                    if vetor[i-1][j] == vetor[i][j] then
                        vetor[i][j] = vetor[i-1][j]*2;
                        placar =  placar + vetor[i][j];
                        vetor[i-1][j] = 0;
                    end
                end
            end
        end
        numeroAleatorio()
    end
end

local function irDireita(event)
    if (event.phase == "ended") then
        for k = 1, #vetor do
            for i = 1, 3, 1 do
                for j = 4, 1, -1 do
                    while ((vetor[i+1][j] == 0) and (vetor[i][j]~=0)) do
                        vetor[i+1][j] = vetor[i][j];
                        vetor[i][j] = 0;
                        i = 3;
                    end
                    if vetor[i+1][j] == vetor[i][j] then
                        vetor[i+1][j] = vetor[i][j]*2;
                        placar =  placar + vetor[i][j];
                        vetor[i][j] = 0;
                    end
                end
            end 
        end
        numeroAleatorio()
    end
end

--botao novo jogo


local iniciaJogo = display.newText("Novo Jogo", 160, 180, native.systemFont, 25)
iniciaJogo:setFillColor(0, 0.5, 1)
iniciaJogo:addEventListener("touch", novoJogo)

local cima = display.newImage("images/up.png")
local baixo = display.newImage("images/down.png")

local esquerda = display.newImage("images/left.png")
local direita = display.newImage("images/right.png")

cima:addEventListener("touch", irCima)
baixo:addEventListener("touch", irBaixo)
esquerda:addEventListener("touch", irEsquerda)
direita:addEventListener("touch", irDireita)

cima:scale(0.1, 0.1)
baixo:scale(0.1, 0.1)
esquerda:scale(0.1, 0.1)
direita:scale(0.1, 0.1)

cima:translate(70, 400)
baixo:translate(130, 400)
esquerda:translate(190, 400)
direita:translate(250, 400)

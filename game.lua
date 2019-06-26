local composer = require("composer")
local movimentos = require("movimentos")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create(event)

    local function gotoMenu()
        composer.setVariable( "finalScore", placar )
        composer.removeScene( "game" )
        composer.gotoScene( "menu", { time=800, effect="slideRight" } )
        display.remove(grupo)
    end


    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen



    local background = display.newImageRect(sceneGroup, "images/background.png",
                                            800, 1400)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local screenW, screenH, halfW, halfH = display.viewableContentWidth,
                                           display.viewableContentHeight,
                                           display.viewableContentWidth * 0.5,
                                           display.viewableContentHeight * 0.5
    numeroColunas = 4
    larguraColuna = math.floor(screenW / numeroColunas)

    vetor = {}
    textoTela = {}
    placar = 0
    
    function getPosicaoColuna(numColuna)
        return (numColuna - 1) * larguraColuna
    end
    
    function iniciaVetor()
        for i = 1, 4 do
            vetor[i] = {}
            for j = 1, 4 do
                vetor[i][j] = 0
            end
        end
    end

    function desenhaTabuleiro()
        for i = 1, numeroColunas do
            textoTela[i] = {}
            for j = 1, 4 do

                local coluna = i + 0.5
                local linha = j * 75 - 10

                x = getPosicaoColuna(coluna)
                y = linha

                local options = {
                    parent = sceneGroup,
                    text = "",
                    x = x,
                    y = y,

                    font = "Exo2-Medium.ttf",
                    fontSize = 40
                }
                local options2 = {
                    parent = sceneGroup,
                    text = "0",
                    x = 240,
                    y = 5,

                    font = "Exo2-Medium.ttf",
                    fontSize = 30
                }
                local options3 = {
                    parent = sceneGroup,
                    text = "Pontuação",
                    x = 240,
                    y = -20,

                    font = "Exo2-Medium.ttf",
                    fontSize = 20
                }
                local myRectangle = display.newRect(sceneGroup ,x, y, 75, 75)

                local cubo = display.newImage(sceneGroup, "images/back.png", x, y)
                cubo:scale(0.63, 0.61)

                textoTela[i][j] = display.newText(options)
                textoTela[i][j].y = y
                textoTela[i][j].x = x
                textoTela[i][j]:setFillColor(1, 1, 1)
                
                pontuacaoBack = display.newImage(sceneGroup, "images/back.png", 240, -5)
                pontuacaoBack:scale(1, 0.4)

                nomePlacar = display.newText(options3)
                nomePlacar:setFillColor(1, 1, 1)

                placarTela = display.newText(options2)
                placarTela:setFillColor(1, 1, 1)

                resetarBack = display.newImage(sceneGroup, "images/back.png", 130, -5)
                resetarBack:scale(0.3, 0.3)

                resetar = display.newImage(sceneGroup, "images/reload.png", 130, -5)
                resetar:scale(0.5, 0.5)

                menuBack = display.newImage(sceneGroup, "images/back.png", 60, -5)
                menuBack:scale(0.3, 0.3)

                gameOverBack = display.newImage(sceneGroup, "images/back.png", display.contentCenterX, display.contentCenterY)
                gameOverBack:scale(1.5, 1)
                gameOverBack:setFillColor(0.5,0.5,0.5, 0.7)
                gameOverBack.isVisible = false

                menu = display.newImage(sceneGroup, "images/home.png", 60, -5)
                menu:scale(0.5, 0.5)
                menu:addEventListener( "tap", gotoMenu )
               
            end
        end
        iniciaVetor()
        resetar:addEventListener("touch", novoJogo)
    end

    function novoJogo1(event)
        gameOverBack.isVisible = false
        placar = 0
        for i = 1, 4 do
            for j = 1, 4 do
                vetor[i][j] = 0
                textoTela[i][j].text = 0
            end
        end
        numeroAleatorio()
    end

    function novoJogo(event)
        
        if (event.phase == "began") then
            
        print(placar)
        composer.setVariable( "finalScore", placar )
        gameOverBack.isVisible = false
        placar = 0
        for i = 1, 4 do
            for j = 1, 4 do
                vetor[i][j] = 0
                textoTela[i][j].text = 0
            end
        end
        numeroAleatorio()
        end
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

    function gameOver()
        gameOverBack.isVisible = true
        gameOver = display.newText(sceneGroup, "Game over", display.contentCenterX, display.contentCenterY, "Exo2-Medium.ttf", 35)
        gameOver:setFillColor(1, 1, 1)
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
            return true
        else
            return false
        end
    end

    function numeroAleatorio()
        local count = 0;
        if checkGameOver() then
            composer.setVariable( "finalScore", placar )
            gameOver()
        else
            while ( count == 0) do
                local num1 = math.random(4)
                local num2 = math.random(4)
            
                placarTela.text = placar
                
                if (verificaPosicao(num1, num2)) then
                    vetor[num1][num2] = random()
                    for i = 1, 4 do
                        for j = 1, 4 do
                            if(vetor[i][j] == 0) then
                                textoTela[i][j]:setFillColor(0.8, 0.75, 0.70)
                            elseif(vetor[i][j] == 2) then
                                textoTela[i][j]:setFillColor(0.160, 0.384, 1)
                            elseif(vetor[i][j] == 4) then
                                textoTela[i][j]:setFillColor(0, 0.568, 0.917)
                            elseif(vetor[i][j] == 8) then
                                textoTela[i][j]:setFillColor(0, 0.721, 0.831)
                            elseif(vetor[i][j] == 16) then
                                textoTela[i][j]:setFillColor(0, 0.749, 0.647)
                            elseif(vetor[i][j] == 32) then
                                textoTela[i][j]:setFillColor(0, 0.784, 0.325)
                            elseif(vetor[i][j] == 64) then
                                textoTela[i][j]:setFillColor(0.392, 0.866, 0.090)
                            elseif(vetor[i][j] == 128) then
                                textoTela[i][j]:setFillColor(0.682, 0.917, 0)
                            elseif(vetor[i][j] == 256) then
                                textoTela[i][j]:setFillColor(1, 0.839, 0)
                            elseif(vetor[i][j] == 512) then
                                textoTela[i][j]:setFillColor(1, 0.670, 0)
                            elseif(vetor[i][j] == 1024) then
                                textoTela[i][j]:setFillColor(1, 0.427, 0)
                            elseif(vetor[i][j] == 2048) then
                                textoTela[i][j]:setFillColor(0.866, 0.172, 0)
                            else 
                                textoTela[i][j]:setFillColor(1,1,1)
                            end
                            if (textoTela[i][j] ~= 0) then
                                textoTela[i][j].text = vetor[i][j]
                                count = 1
                            else
                                count = 0
                            end
                        end
                    end
                else
                end
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

    local cima = display.newImage(sceneGroup, "images/up.png")
    local baixo = display.newImage(sceneGroup, "images/down.png")

    local esquerda = display.newImage(sceneGroup, "images/left.png")
    local direita = display.newImage(sceneGroup, "images/right.png")

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

    desenhaTabuleiro()
    novoJogo1()
end

-- show()
function scene:show(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif (phase == "did") then
        -- Code here runs when the scene is entirely on screen

    end
end

-- hide()
function scene:hide(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif (phase == "did") then
        -- Code here runs immediately after the scene goes entirely off screen

        
        composer.removeScene( "game" )
    end
end

-- destroy()
function scene:destroy(event)

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
-- -----------------------------------------------------------------------------------

return scene

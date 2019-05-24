-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local background = display.newImage("images/background.png")
background:scale(2, 2)
--[[
local opcoesTexto = {
    text = "2048",
    x = display.contentCenterX,
    y = 10,
    fontSize = 18,
    align = "center"
}

local texto = display.newText(opcoesTexto)
texto:setFillColor(1, 1, 0)

local grupo1 = display.newGroup()
local grupo2 = display.newGroup()

local myBox1 = display.newRect(20, 20, 70, 70)
local myBox2 = display.newRect(60, 130, 70, 70)
local myBox3 = display.newRect(60, 200, 70, 70)
local myBox4 = display.newRect(60, 270, 70, 70)

local myBox5 = display.newRect(130, 60, 70, 70)
local myBox6 = display.newRect(130, 130, 70, 70)
local myBox7 = display.newRect(130, 200, 70, 70)
local myBox8 = display.newRect(130, 270, 70, 70)

local myBox9 = display.newRect(200, 60, 70, 70)
local myBox10 = display.newRect(200, 130, 70, 70)
local myBox11 = display.newRect(200, 200, 70, 70)
local myBox12 = display.newRect(200, 270, 70, 70)

local myBox13 = display.newRect(270, 60, 70, 70)
local myBox14 = display.newRect(270, 130, 70, 70)
local myBox15 = display.newRect(270, 200, 70, 70)
local myBox16 = display.newRect(270, 270, 70, 70)

myBox1:setFillColor(1, 0, 0, 1)
myBox2:setFillColor(1, 1, 0, 1)
myBox3:setFillColor(1, 0, 0, 1)
myBox4:setFillColor(1, 1, 0, 1)

myBox5:setFillColor(1, 1, 0, 1)
myBox6:setFillColor(1, 0, 0, 1)
myBox7:setFillColor(1, 1, 0, 1)
myBox8:setFillColor(1, 0, 0, 1)

myBox9:setFillColor(1, 0, 0, 1)
myBox10:setFillColor(1, 1, 0, 1)
myBox11:setFillColor(1, 0, 0, 1)
myBox12:setFillColor(1, 1, 0, 1)

myBox13:setFillColor(1, 1, 0, 1)
myBox14:setFillColor(1, 0, 0, 1)
myBox15:setFillColor(1, 1, 0, 1)
myBox16:setFillColor(1, 0, 0, 1)

grupo1:insert(
    myBox1,
    myBox3,
    myBox5,
    myBox6,
    myBox7,
    myBox8,
    myBox9,
    myBox10,
    myBox11,
    myBox12,
    myBox13,
    myBox14,
    myBox15,
    myBox16
)
grupo2:insert(myBox2, myBox4)

grupo2.x = 60
grupo2.y = 130
grupo1.x = 60
grupo1.y = 60


local function mudarCor(event)
    myBox1:setFillColor(0, 1, 1, 1)
    print("teste")
end

myBox1:addEventListener("touch", mudarCor)
]]--


-- Screen size
local screenW, screenH, halfW, halfH =
    display.viewableContentWidth,
    display.viewableContentHeight,
    display.viewableContentWidth * 0.5,
    display.viewableContentHeight * 0.5


numeroColunas = 4
larguraColuna = math.floor(screenW / numeroColunas)
tab = {}

tab2 = {}


for i = 0, 4 do
    tab2[i] = {}
      for j = 0, 4 do
        tab2[i][j] = 0
      end
  end


function getPosicaoColuna(numColuna)
    return (numColuna - 1) * larguraColuna
end
function getLarguraColuna(numColuna)
    return numColuna * larguraColuna
end

local function novoJogo(event)
    for i = 1, numeroColunas do
        tab[i] = {}
        for j = 1, 4 do
    
            local coluna = i + 0.5
            local linha = j * 75 - 10
    
            x = getPosicaoColuna(coluna)
            y = linha
            print("coluna", x, "linha", y)
        
            local myRectangle = display.newRoundedRect( x, y, 75, 75, 3 )
            myRectangle.strokeWidth = 1
            myRectangle:setFillColor( 0.5 )
            myRectangle:setStrokeColor( 1, 1,1 )
    
           -- tab[i][j] = display.newText(" ", x, y, native.systemFont, 40 )
        end
    end
end


function random()
    math.randomseed(os.time())
    num = math.random(4);
    if(num <= 2) then
        return 2
    else 
        return 4
    end
end

function randomX()
    math.randomseed(os.time())
    num = math.random(4);
    if(num == 1) then
        return 40
    elseif(num == 2) then
        return 120
    elseif(num == 3) then
        return 200
    elseif(num == 4) then
        return 280
    end
end

function randomY()
    math.randomseed(os.time())
    num = math.random(4);
    if(num == 1) then
        return 65
    elseif(num == 2) then
        return 140
    elseif(num == 3) then
        return 215
    elseif(num == 4) then
        return 290
    end
end

function desenhaGrid()
    for i = 1, 4 do
      for j = 1, 4 do
        tab[i][j] = display.newText(random(), randomX(), randomY(), native.systemFont, 40 )
      end
    end
  end

--movimentos
local function irCima(event)
    for k = 1, #tab2 do
        for i = 4, 2, -1 do
          for j = 1, #tab2 do
            while ((tab2[i-1][j] == 0) and (tab2[i][j]~=0)) do
              tab2[i-1][j] = tab2[i][j];
              

              tab[i][j] = display.newText(tab2[i][j], randomX(), randomY(), native.systemFont, 40 )
              tab2[i][j] = 0
              i = 4;
            end
            if tab2[i-1][j] == tab2[i][j] then
              tab2[i][j] = tab2[i-1][j]*2;
              --placar =  placar + tab2[i][j];
              tab[i][j] = display.newText(tab2[i][j], randomX(), randomY(), native.systemFont, 40 )
              tab2[i-1][j] = 0;
            end
          end
        end
      end
      desenhaGrid();
      --gerarTile();
    end
   
    

local function irBaixo(event) 

end
local function irEsquerda(event) 

end
local function irDireita(event) 

end

local iniciaJogo = display.newText("Novo Jogo", 160, 180, native.systemFont, 25 )
iniciaJogo:setFillColor( 0, 0.5, 1 )

local cima = display.newImage("images/up.png")
local baixo = display.newImage("images/down.png")

local esquerda = display.newImage("images/left.png")
local direita = display.newImage("images/right.png")

cima:addEventListener("touch", irCima)
baixo:addEventListener("touch", irBaixo)
esquerda:addEventListener("touch", irEsquerda)
direita:addEventListener("touch", irDireita)
iniciaJogo:addEventListener("touch", novoJogo)

cima:scale(0.1, 0.1)
baixo:scale(0.1, 0.1)
esquerda:scale(0.1, 0.1)
direita:scale(0.1, 0.1)

cima:translate(70, 400)
baixo:translate(130, 400)
esquerda:translate(190, 400)
direita:translate(250, 400)



--teste

function gerarTile()
    for i = 0, 1 do
      r1 = random();
      --esp.sleep(1)
      r2 = random();
      if(tab[r1][r2]~= 0) then
      
      else
        t = r1;
        h = r2;
        break;
      end
    end
  
    if(count %2 ==0) then
      tab[t][h]=2;
      count = count + 1;
    else
      tab[t][h]=4;
      count = count + 1;
    end
end
--/teste

tab = {};
count = 0;

for i = 0, 4 do
  tab[i] = {}
    for j = 0, 4 do
      tab[i][j] = 0
    end
end


function checkGameOver()
 contador = 0;
  for i = 1, 4 do
    for j = 1, 4 do
      if(tab[i][j] == 0) then
        contador = contador + 1;
      end
    end
  end
  if (contador == 0) then
    return true;
  else
    return false;
  end
end


function ganhou()
  for i = 1, 4 do
    for j = 1, 4 do
      if(tab[i][j] == 2048) then
        return true;
      end
    end
  end
end

placar = 0;

function defineplacar()
  for i = 1, 4 do
    for j = 1, 4 do
       placar = placar + tab[i][j];
    end
  end
end


function desenhaGrid()
  for i = 1, 4 do
    print()
    for j = 1, 4 do
        io.write("[" .. tab[i][j] .. "]" )
    end
  end
end

function direita()
  for j = 4, 1, -1 do
    for i = 1, 4, 1 do
      while ((tab[i][j] == 0) and (tab[i][j-1]~=0)) do
        tab[i][j] = tab[i][j-1];
        tab[i][j-1] = 0;
        j = 3;
      end
      if tab[i][j] == tab[i][j-1] then
        tab[i][j] = tab[i][j]*2;
        tab[i][j-1] = 0;
      end
    end
  end
end

function esquerda()
  for j = 1, 3, 1 do
    for i = 1, 4, 1 do
      while ((tab[i][j] == 0) and (tab[i][j+1]~=0)) do
        tab[i][j] = tab[i][j+1];
        tab[i][j+1] = 0;
        j = 0;
      end
      if tab[i][j] == tab[i][j+1] then
        tab[i][j] = tab[i][j+1]*2;
        tab[i][j] = 0;
      end
    end
  end
end

function cima()
  for i = 4, 1, -1 do
    for j = 1, 4, 1 do
      while ((tab[i-1][j] == 0) and (tab[i][j]~=0)) do
        tab[i-1][j] = tab[i][j];
        tab[i][j] = 0;
        j = 3;
      end
      if tab[i-1][j] == tab[i][j] then
        tab[i-1][j] = tab[i][j]*2;
        tab[i][j] = 0;
      end
    end
  end
end

function baixo()
  for i = 1, 3, 1 do
    for j = 4, 1, -1 do
      while ((tab[i+1][j] == 0) and (tab[i][j]~=0)) do
        tab[i+1][j] = tab[i][j];
        tab[i][j] = 0;
        i = 3;
      end
      if tab[i+1][j] == tab[i][j] then
        tab[i+1][j] = tab[i][j]*2;
        tab[i][j] = 0;
      end
    end
  end
end

esp = require 'posix'
function random()
  math.randomseed(os.time())
  num =  math.random(4);
  return num
end

function gerarTile()
  for i = 0, 1 do
    r1 = random();
    esp.sleep(1)
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

function executar()

l = 1;
  while l == 1 do
    io.write("Digite o lado:");
    lado = io.read();

    if(lado == "e" or lado =="E") then
      esquerda();
    elseif(lado == "d" or lado == "D") then
      direita();
    elseif(lado == "c" or lado == "C") then
      cima();
    elseif(lado == "b" or lado == "B") then
      baixo();
    end
    if(ganhou()) then
      io.write("Você ganhou");
      l = 2;
    end
    if(checkGameOver() == true) then
      io.write("Game Over");
      l = 2;
    end
  gerarTile();
  desenhaGrid();
  defineplacar();
  io.write(placar);
  end
end
executar();

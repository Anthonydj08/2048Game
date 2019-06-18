
tab = {};
count = 0;
placar = 0;

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
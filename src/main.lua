local jogo = require 'game'
local movimentos = require 'movimentos'

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
  print();
  print("placar: " .. placar);
  end
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
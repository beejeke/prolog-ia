/* 2) Definir la relación selecciona(X,L1,L2), que se verifique si L2 es la lista obtenida eliminando una
ocurrencia de X en L1. Por ejemplo,
?‐ selecciona(a,[a,b,a],L).
L = [b, a];
L = [a, b]; */

selecciona(X,[X|T],T).
selecciona(X,[Y|L1],[Y|L2]):- 
  selecciona(X,L1,L2).

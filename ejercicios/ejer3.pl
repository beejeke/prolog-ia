/* 3) Definir la relación inserta(X,L1,L2) que se verifique si L2 es una lista obtenida insertando X en L1. */

inserta(X,L1,L2):-
  selecciona(X,L2,L1).
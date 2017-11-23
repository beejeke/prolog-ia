/* Problema de asignación de apartamentos */

1. Definir predicado "higher"
2. Definir predicado "not_adyacent"
3. Definir puzzle(L):-
      permutation(L,[juan,antonio,ana,maria,luis]),
      L = [Atico,Piso4,Piso3,Piso3,Bajo],
      juan \== Atico,
      antonio \== Bajo
      ana \== Atico
      ana \== Bajo
      higher(luis,antonio, L),
      not_adyacent(maria,ana, L),
      not_adyacent(ana,antonio, L).


      ? puzzle(L).
      ? puzzle([A,B,C,D,E]).
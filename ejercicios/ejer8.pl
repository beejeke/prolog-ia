/* 8) Definir la relación factorial(+X,?Y), que se verifique si Y es el factorial de X de dos formas, usando y
sin usar acumuladores. Por ejemplo:
?‐ factorial(3,X).
X = 6 */

factorial(1,1).
factorial(X,Y):-
  X > 1,
  X1 is X-1,
  factorial(X1,Y1),
  Y is X * Y1.
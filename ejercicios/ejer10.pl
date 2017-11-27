/* Definir la relación mcd(+X,+Y,?Z) que se verifique si Z es el máximo común divisor de X e Y. Por
ejemplo:
?‐ mcd(10,15,X).
X = 5 */

mcd(X,X,X).
mcd(X,Y,Z):-
  X < Y,
  Y1 is Y - X,
  mcd(X,Y1,Z).
  mcd(X,Y,Z):-
    X > Y,
  mcd(Y,X,Z).
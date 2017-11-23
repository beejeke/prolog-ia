/* 6) Definir la relación maximo(+X,+Y,?Z), que se verifique si Z es el máximo de X e Y. Por ejemplo:
?‐ maximo(2,3,X).
X=3
?‐ max */


maximo(X,Y,X):-
X >= Y.
maximo(X,Y,Y):-
X < Y.
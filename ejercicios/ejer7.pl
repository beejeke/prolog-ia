/*  7) Definir la relación minimo(+X,+Y,?Z), que se verifique si Z es el mínimo de X e Y. Por ejemplo:
?‐ minimo(2,3,X).
X=2
?‐ minimo(3,2,X).
X=2 */

minimo(X,Y,X):-
X =< Y.
minimo(X,Y,Y):-
X > Y.
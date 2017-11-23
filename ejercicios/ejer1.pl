/*1) Definir la relación penúltimo(X, L) que se verifique si X es el penúltimo elemento de la lista L, de
# dos formas: por recursión y haciendo uso del predicado append.*/

penultimo(X,L):-
  append(_,[X,_],L).

penultimo2(X,[X,_]).
penultimo2(X,[_|T]):-
  penultimo2(X,T).
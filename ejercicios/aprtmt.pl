/* Problema de asignación de apartamentos */

member(X,[X|T]).
member(X,[_|T]):-
   member(X,T).

higher(X,Y,[X|T]):-	
   member(Y,T).
higher(X,Y,[_|T]):-	
   higher(X,Y,T).

not_adjacent(X,Y,[X,Z|T]):-
   Z \== Y,
   member(Y,T).

not_adjacent(X,Y,[Y,Z|T]):-
   Z \== X,
   member(X,T).

not_adjacent(X,Y,[_|T]):-
   not_adjacent(X,Y,T).
	
puzzle(L):-
   permutation(L,[juan,antonio,ana,maria,luis]),
   L = [Atico,Piso4,Piso3,Piso2,Bajo],

   juan \== Atico,
   antonio \== Bajo,
   ana \== Atico,
   ana \== Bajo,
   higher(luis,antonio, L),
   not_adjacent(maria,ana, L),
   not_adjacent(ana,antonio, L).
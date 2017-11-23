/* Definir la relación todos_iguales(+L) que se verifique si todos los elementos de la lista L son
iguales entre sí. Por ejemplo,
?‐ todos_iguales([a,a,a]).
Yes */

/*Lista vacía es cierto*/

todos_iguales([]).          
todos_iguales([_]):-!.
todos_iguales([X,X|T]):-
todos_iguales([X|T]).
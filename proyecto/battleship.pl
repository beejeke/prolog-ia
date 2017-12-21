/* Definición de las partes de los barcos */

parteBarco(n).
parteBarco(e).
parteBarco(s).
parteBarco(w).
parteBarco(x).
parteBarco(o).


/* Definición de todas las posibles combinaciones horizontales entre celdas adjuntas */

combinacionHorizontal(w, e).
combinacionHorizontal(w, x).
combinacionHorizontal(x, x).
combinacionHorizontal(x, e).
combinacionHorizontal('~', n).
combinacionHorizontal(n, '~').
combinacionHorizontal(e, '~').
combinacionHorizontal('~', s).
combinacionHorizontal(s, '~').
combinacionHorizontal('~', w).
combinacionHorizontal('~', x).
combinacionHorizontal(x, '~').
combinacionHorizontal('~', o).
combinacionHorizontal(o, '~').



/* Definición de todas las posibles combinaciones verticales entre celdas adjuntas */

combinacionVertical(n, s).
combinacionVertical(n, x).
combinacionVertical(x, x).
combinacionVertical(x, s).
combinacionVertical('~', n).
combinacionVertical('~', e).
combinacionVertical(e, '~').
combinacionVertical(s, '~').
combinacionVertical('~', w).
combinacionVertical(w, '~').
combinacionVertical('~', x).
combinacionVertical(x, '~').
combinacionVertical('~', o).
combinacionVertical(o, '~').


/*
    Crea una columna llena de agua (~) para colocar ser colocada a los lados del grid
*/
appendBorderColumns([[Head | Tail]], [NewRow]) :-
    append([Head | Tail], ['~'], TempRow),
    append(['~'], TempRow, NewRow).

appendBorderColumns([[Head | Tail] | Tail2], [NewRow | Tail3]) :-
    append([Head | Tail], ['~'], TempRow),
    append(['~'], TempRow, NewRow),
    appendBorderColumns(Tail2, Tail3).


/*
    Crea una fila llena de agua (~) para colocar encima y debajo del grid
*/
createBorderRow([[_] | _], ['~']).
createBorderRow([[_ | Tail] | _], ['~' | Row]) :- createBorderRow([Tail], Row).


/*
    Asegurarse que el contenido de las columnas esté permitido con la suma de comprobación dada
*/
checkColumnChecksum([[Head]], [], 1) :- not(Head == '~').
checkColumnChecksum([[Head] | Tail], [], ColumnChecksum) :-
    ColumnChecksum > 0,
    not(Head == '~'),
    NewColumnChecksum is ColumnChecksum-1,
    checkColumnChecksum(Tail, [], NewColumnChecksum).

checkColumnChecksum([[Head | Tail]], [Tail], 1) :- not(Head == '~').
checkColumnChecksum([[Head | Tail] | Tail2], [Tail | NewTail], ColumnChecksum) :-
    ColumnChecksum > 0,
    not(Head == '~'),
    NewColumnChecksum is ColumnChecksum-1,
    checkColumnChecksum(Tail2, NewTail, NewColumnChecksum).

checkColumnChecksum([['~']], [], 0).
checkColumnChecksum([['~'] | Tail], [], ColumnChecksum) :- checkColumnChecksum(Tail, [], ColumnChecksum).
checkColumnChecksum([['~' | Tail]], [Tail], 0).
checkColumnChecksum([['~' | Tail] | Tail2], [Tail | NewTail], ColumnChecksum) :-
    checkColumnChecksum(Tail2, NewTail, ColumnChecksum).


/*
    Asegurarse que todas las columnas tengan el contenido correcto en relación con sus sumas de comprobación
*/
checkColumnChecksums([[Head] | Tail], [ColumnChecksum]) :-
    checkColumnChecksum([[Head] | Tail], [], ColumnChecksum).

checkColumnChecksums([[Head | Tail] | Tail2], [FirstColumnChecksum | OtherColumnChecksums]) :-
    checkColumnChecksum([[Head | Tail] | Tail2], NewGrid, FirstColumnChecksum),
    checkColumnChecksums(NewGrid, OtherColumnChecksums).


/* 
    Asegurarse que el contenido de la fila esté permitido con la suma de comprobación dada
*/
checkRowChecksum([], 0).
checkRowChecksum([Head | Tail], Checksum) :- not(Head == '~'), Checksum2 is Checksum-1, checkRowChecksum(Tail, Checksum2).
checkRowChecksum(['~' | Tail], Checksum) :- checkRowChecksum(Tail, Checksum).


/*
    Asegurarse que todas las filas tengan el contenido correcto en relación con sus sumas de comprobación
*/
checkRowChecksums([[Head | Tail]], [Checksum]) :- checkRowChecksum([Head | Tail], Checksum).
checkRowChecksums([[Head | Tail] | Tail2], [FirstChecksum | OtherChecksums]) :-
    checkRowChecksum([Head | Tail], FirstChecksum),
    checkRowChecksums(Tail2, OtherChecksums).


/*
    Asegurarse que la celda tenga celdas adyacentes legales
*/
checkCell([['~', '~', '~'], [E21, x, E23], ['~', '~', '~']]) :-
    parteBarco(E22), parteBarco(E21), parteBarco(E23),
    combinacionHorizontal(E21, E22),
    combinacionHorizontal(E22, E23).
    
checkCell([['~', '~', '~'], [E21, E22, E23], ['~', '~', '~']]) :-
    not(E22 == x), parteBarco(E22), (parteBarco(E21); parteBarco(E23)),
    combinacionHorizontal(E21, E22),
    combinacionHorizontal(E22, E23).

checkCell([['~', E12, '~'], ['~', x, '~'], ['~', E32, '~']]) :-
    parteBarco(E22), parteBarco(E12), parteBarco(E32),
    combinacionVertical(E12, E22),
    combinacionVertical(E22, E32).

checkCell([['~', E12, '~'], ['~', E22, '~'], ['~', E32, '~']]) :-
    not(E22 == x), parteBarco(E22), (parteBarco(E12); parteBarco(E32)),
    combinacionVertical(E12, E22),
    combinacionVertical(E22, E32).
    
checkCell([['~', '~', '~'], ['~', o, '~'], ['~', '~', '~']]).


/*
    Verificar todas las celdas para asegurarse de que puedan colocarse una al lado de la otra
*/
checkAllCells(_, [['~', E12, '~'], [E21, E22, '~'], ['~', '~', '~']]) :-
    checkCell([['~', E12, '~'], [E21, E22, '~'], ['~', '~', '~']]).

checkAllCells(_, [[_, _, '~'], [_, '~', '~'], ['~', '~', '~']]).

checkAllCells(Grid, [['~', E12, '~' | Tail1], [E21, E22, E23 | Tail2], ['~', '~', '~' | Tail3]]) :-
    checkCell([['~', E12, '~'], [E21, E22, E23], ['~', '~', '~']]),
    checkAllCells(Grid, [[E12, '~' | Tail1], [E22, E23 | Tail2], ['~', '~' | Tail3]]).
   
checkAllCells(Grid, [[_, E12, E13 | Tail1], [_, '~', E23 | Tail2], ['~', '~', '~' | Tail3]]) :-
    checkAllCells(Grid, [[E12, E13 | Tail1], ['~', E23 | Tail2], ['~', '~' | Tail3]]).

checkAllCells([_, SecondGridRow | OtherGridRows], [['~', E12, '~'], [E21, E22, '~'], ['~', E32, '~'] | _]) :-
    checkCell([['~', E12, '~'], [E21, E22, '~'], ['~', E32, '~']]),
    checkAllCells([SecondGridRow | OtherGridRows], [SecondGridRow | OtherGridRows]).

checkAllCells([_, SecondGridRow | OtherGridRows], [[_, _, '~'], [_, '~', '~'], [_, _, '~'] | _]) :-
    checkAllCells([SecondGridRow | OtherGridRows], [SecondGridRow | OtherGridRows]).
 
checkAllCells(Grid, [['~', E12, '~' | Tail1], [E21, E22, E23 | Tail2], ['~', E32, '~' | Tail3] | Tail]) :-
    checkCell([['~', E12, '~'], [E21, E22, E23], ['~', E32, '~']]),
    checkAllCells(Grid, [[E12, '~' | Tail1], [E22, E23 | Tail2], [E32, '~' | Tail3] | Tail]).

checkAllCells(Grid, [[_, E12, E13 | Tail1], [_, '~', E23 | Tail2], [_, E32, E33 | Tail3] | Tail]) :-
    checkAllCells(Grid, [[E12, E13 | Tail1], ['~', E23 | Tail2], [E32, E33 | Tail3] | Tail]).


/*  
    Recuperar un elemento específico en una lista
*/
getElementInRow([Head], 1, Head) :- !.
getElementInRow([Head | _], 1, Head) :- !.
getElementInRow([_ | Tail], ElementNr, Result) :- ElementNr2 is ElementNr-1, getElementInRow(Tail, ElementNr2, Result).


/*
    Cambiar un elemento especifico de una lista
*/
setElementInRow([_], 1, Element, [Element]) :- !.
setElementInRow([_ | Tail], 1, Element, [Element | Tail]) :- !.
setElementInRow([Head | Tail], ElementNr, Element, Result) :-
    ElementNr > 1,
    NewElementNr is ElementNr-1,
    setElementInRow(Tail, NewElementNr, Element, OldResult),
    append([Head], OldResult, Result).


/*
    Recuperar una columna específica del grid
*/
getColumn([[FirstElement | OtherElements]], ColumnNr, [NeededElementInRow]) :-
    !, getElementInRow([FirstElement | OtherElements], ColumnNr, NeededElementInRow).
getColumn([[FirstElement | OtherElements] | OtherRows], ColumnNr, [NeededElementInRow | OtherElementsInColumn]) :-
    getColumn(OtherRows, ColumnNr, OtherElementsInColumn),
    getElementInRow([FirstElement | OtherElements], ColumnNr, NeededElementInRow).


/*
    Verificar si toda la lista contiene ceros
*/
zeroList([0]).
zeroList([0 | Tail]) :- zeroList(Tail).


/*
    Recuperar el tamaño de un barco
*/
getShipSize([s], [], 1).
getShipSize([e], [], 1).
getShipSize([s | Tail], Tail, 1).
getShipSize([e | Tail], Tail, 1).

getShipSize([x | Tail], Remainder, Size) :-
    !, getShipSize(Tail, Remainder, OldSize),
    Size is OldSize+1.

getShipSize([n | Tail], Remainder, Size) :-
    !, getShipSize(Tail, Remainder, OldSize),
    Size is OldSize+1.

getShipSize([w | Tail], Remainder, Size) :-
    !, getShipSize(Tail, Remainder, OldSize),
    Size is OldSize+1.


/*
    Recupera el tamaño de una lista dada
*/
getListLength([], 0) :- !.
getListLength([_], 1) :- !.
getListLength([_ | Tail], Length) :- getListLength(Tail, OldLength), Length is OldLength+1, !.


/*
    Averigua cuántos elementos ya ha eliminado de la primera fila
*/
findColumnNumber([[_], [_]], 1).
findColumnNumber([[_], [_] | _], 1).
findColumnNumber([[_], [_ | Tail]], Result) :- getListLength(Tail, Length), Result is Length+1.
findColumnNumber([[_], [_ | Tail] | _], Result) :- getListLength(Tail, Length), Result is Length+1.
findColumnNumber([[_ | Tail], [_ | Tail2]], Result) :- findColumnNumber([Tail, Tail2], Result).
findColumnNumber([[_ | Tail], [_ | Tail2] | Tail3], Result) :- findColumnNumber([Tail, Tail2 | Tail3], Result), !.


/*
    Comprueba si la cuadrícula contiene la cantidad correcta de barcos
*/
checkShips([['~']], Ships) :- !, zeroList(Ships).
checkShips([['~' | Tail]], Ships) :- !, checkShips([Tail], Ships).
checkShips([['~'] | Tail], Ships) :- !, checkShips(Tail, Ships).
checkShips([['~' | Tail] | Tail2], Ships) :- !, checkShips([Tail | Tail2], Ships).
checkShips([[x | Tail] | Tail2], Ships) :- !, checkShips([Tail | Tail2], Ships).
checkShips([[s | Tail] | Tail2], Ships) :- !, checkShips([Tail | Tail2], Ships).
checkShips([[e | Tail] | Tail2], Ships) :- !, checkShips([Tail | Tail2], Ships).

checkShips([[n | Tail] | Tail2], Ships) :-
    !, findColumnNumber([[n | Tail] | Tail2], ColumnNumber),
    getColumn(Tail2, ColumnNumber, Column),
    getShipSize([n | Column], _, Size),
    getElementInRow(Ships, Size, AmountOfShips),
    AmountOfShips > 0,
    NewAmountOfShips is AmountOfShips-1,
    setElementInRow(Ships, Size, NewAmountOfShips, NewShips),
    checkShips([Tail | Tail2], NewShips).

checkShips([[w | Tail] | Tail2], Ships) :-
    !, getShipSize([w | Tail], RowRemainder, Size),
    getElementInRow(Ships, Size, AmountOfShips),
    AmountOfShips > 0,
    NewAmountOfShips is AmountOfShips-1,
    setElementInRow(Ships, Size, NewAmountOfShips, NewShips),
    checkShips([RowRemainder | Tail2], NewShips).

checkShips([[o | Tail] | Tail2], Ships) :-
    !, getElementInRow(Ships, 1, AmountOfShips),
    AmountOfShips > 0,
    NewAmountOfShips is AmountOfShips-1,
    setElementInRow(Ships, 1, NewAmountOfShips, NewShips),
    checkShips([Tail | Tail2], NewShips).


/*
    Salida del grid
*/
printGrid([[Head]]) :- write(Head), nl.
printGrid([[Head | Tail]]) :- write(Head), write(' '), printGrid([Tail]).
printGrid([[Head] | Tail]) :- write(Head), nl, printGrid(Tail).
printGrid([[Head | Tail] | Tail2]) :- write(Head), write(' '), printGrid([Tail | Tail2]).


/*
    Punto de entrada del programa
*/
battleship(Grid, ColumnChecksums, RowChecksums, Ships, Grid) :-
    appendBorderColumns(Grid, TempGrid1),
    createBorderRow(TempGrid1, BorderRow),
    append(TempGrid1, [BorderRow], TempGrid2),
    append([BorderRow], TempGrid2, NewGrid),
    checkColumnChecksums(Grid, ColumnChecksums),
    checkRowChecksums(Grid, RowChecksums),
    checkAllCells(NewGrid, NewGrid),
    checkShips(NewGrid, Ships),
    printGrid(Grid), !.
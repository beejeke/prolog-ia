/* La sucesión de Fibinacci es 0,1,1,2,3,5,8,13,21,… en la que cada término, salvo los dos primeros, es
la suma de los dos anteriores. Definir la relación fibinacci(+N,‐X), que se verifique si X es el N‐
ésimo término de la sucesión de Fibonacci. Por ejemplo:
?‐ fibonacci(6,X). */

fibonacci(0,0).
fibonacci(1,1).
fibonacci(N,X):-
  N > 1,
  N1 is N-1,
  fibonacci(N1,X1),
  N2 is N-2,
  fibonacci(N2,X2),
  X is X1 + X2.

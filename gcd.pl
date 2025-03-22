% Fail explicitly when bother numbers are 0
gcd(0, 0, _) :- !, fail.

gcd(A, B, Gcd) :-
    abs(A, A1),
    abs(B, B1),
    gcd2(A1, B1, Gcd).

gcd2(0, X, X) :- !.
gcd2(X, 0, X) :- !.
gcd2(A, B, Gcd) :-
    R is B mod A,
    gcd2(B, R, Gcd).
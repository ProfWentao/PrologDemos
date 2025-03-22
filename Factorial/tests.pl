:- begin_tests(factorial).

test(factorial_of_0) :-
    factorial(0, F),
    assertion(F == 1).

test(factorial_of_5) :-
    factorial(5, F),
    assertion(F == 120).

test(factorial_negative, [fail]) :-
    factorial(-1, _).

test(factorial_of_10) :-
    factorial(10, F),
    assertion(F == 362880).

:- end_tests(factorial).
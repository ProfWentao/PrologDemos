append([], L, L).
append([H | T], L, [H | R]) :-
    append(T, L, R).

len([], 0).
len([_ | T], N) :-
    len(T, N1),
    N is N1 + 1.

% Base case: an empty list returns an empty list.
extract_evens([], []).

% If Head is even, include it in the result.
extract_evens([H | T], [H | E]) :-
    H mod 2 =:= 0,   % Check if H is even
    extract_evens(T, E),
    !. % cut prevents retrying alternative solutions.

% If Head is odd, skip it and continue.
extract_evens([_ | T], E) :-
    extract_evens(T, E).

last_element([X], X) :- !.  % Base case: last element of a one-item list is itself.
last_element([_ | T], X) :- last_element(T, X), !.  % Recursive call

reverse_list([], []).  % Base case: reversing an empty list is an empty list.
reverse_list([H | T], R) :- 
    reverse_list(T, RevT), 
    append(RevT, [H], R).

member(X, [X | _]) :- !.
member(X, [_ | T]) :-
    member(X, T).
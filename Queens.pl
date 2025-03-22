% Ensures that no two queens share the same row, column, or diagonal.
safe([]) :- !.
safe([Q|Qs]) :-
    safe(Qs),
    no_attack(Q, Qs, 1).

no_attack(_, [], _).
no_attack(Q, [Q1|Qs], Dist) :-
    Q =\= Q1,                    % Ensure different columns
    abs(Q - Q1) =\= Dist,        % Ensure different diagonals
    Dist1 is Dist + 1,
    no_attack(Q, Qs, Dist1).

% Generates a valid solution by permuting positions [1..8] for 8 rows.
eight_queens(Solution) :-
    length(Solution, 8),                         % Ensure we have exactly 8 queens
    permutation([1,2,3,4,5,6,7,8], Solution),    % Permute valid positions
    safe(Solution).                              % Check safety constraints

% Query: ?- eight_queens(Solution).

% Generalize to N queens
n_queens(N, Solution) :-
    length(Solution, N),
    numlist(1, N, Positions),
    permutation(Positions, Solution),
    safe(Solution).

n_queens_count(N, Count) :-
    (
        setof(Solution, n_queens(N, Solution), Solutions)
        -> length(Solutions, Count)
        ;  Count = 0
    ).
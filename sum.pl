% Head recursion to sum a list
sum_list([], 0).                   % Base case: sum of an empty list is 0
sum_list([Head|Tail], Sum) :-      % Recursive case: sum of a non-empty list
    sum_list(Tail, TailSum),       % Recursive call on the tail
    Sum is Head + TailSum.         % Add the head to the sum of the tail

sum_list2(List, Sum) :-
    sum_list_tail(List, 0, Sum).

sum_list_tail([], Acc, Acc).
sum_list_tail([Head|Tail], Acc, Sum) :-
    Acc1 is Acc + Head,
    sum_list_tail(Tail, Acc1, Sum).

sum_list_tail2([], Acc, Acc).
sum_list_tail2([Head|Tail], Sum, Acc) :-
    Acc1 is Acc + Head,
    sum_list_tail2(Tail, Sum, Acc1).

sum_cubes(N, S) :-
    sum_cubes_recursive(N, 0, S).

sum_cubes_recursive(0, Acc, Acc) :- !.
sum_cubes_recursive(N, Acc, Sum) :-
    N > 0,
    N1 is N - 1,
    Acc1 is Acc + N ^ 3,
    sum_cubes_recursive(N1, Acc1, Sum).
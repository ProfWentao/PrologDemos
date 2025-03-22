% Base case: An empty list or a single element list is already sorted.
merge_sort([], []).
merge_sort([X], [X]).

% Recursive case: Split, sort, and merge
merge_sort(List, Sorted) :-
    split_list(List, Left, Right),  % Divide the list into two halves
    merge_sort(Left, SortedLeft),   % Recursively sort the left half
    merge_sort(Right, SortedRight), % Recursively sort the right half
    merge(SortedLeft, SortedRight, Sorted), % Merge sorted halves
    !.

% Split a list into two halves
split_list(List, Left, Right) :-
    length(List, Len),
    Half is Len // 2,
    length(Left, Half),
    append(Left, Right, List),
    !.

% Merge two sorted lists into one sorted list
merge([], Right, Right).
merge(Left, [], Left).
merge([X | Xs], [Y | Ys], [X | Zs]) :-
    X =< Y, !,
    merge(Xs, [Y | Ys], Zs).
merge([X | Xs], [Y | Ys], [Y | Zs]) :-
    X > Y, !,
    merge([X | Xs], Ys, Zs).

:- module(string_utils, [prettify/2, cap_word/2]).

prettify(Atom, Pretty) :-
    atomic_list_concat(Words, '_', Atom),
    maplist(cap_word, Words, CapitalWords),
    atomic_list_concat(CapitalWords, ' ', Pretty).

cap_word(Word, Capitalized) :-
    atom_chars(Word, [First|Rest]),
    char_type(First, lower),
    char_type(Upper, upper(First)),
    atom_chars(Capitalized, [Upper|Rest]).

:- prolog_load_context(directory, Dir),
   atom_concat(Dir, '/lib', LibDir),
   assertz(user:file_search_path(library, LibDir)).

:- use_module(library(string_utils)).

%% Several members of the Florida Trail Association have decided to each hike a different trail segment
%% today to check for storm damage. Using only the clues that follow, match each hiker to their start-
%% and end-points and determine the total distance hiked by each.
%%
%%   •  Of Rebecca and the hiker who trekked for 10 miles, one started at Reedy Creek and the other started at Cassia.
%%   •  The hiker who started at Tosohatchee walked somewhat more than Iris.
%%   •  Rebecca is either the person who trekked for 11 miles or the hiker who started at Tosohatchee.
%%   •  Danielle walked somewhat less than the person who started at Reedy Creek.
%%   •  The hiker who trekked for 8 miles didn't start at Lake Jesup.
%%   •  The hiker who started at Tosohatchee walked somewhat less than Rebecca.
%%   •  Pauline walked 1 mile more than Iris.
%%   •  The other hiker is named Brandi.
%%   •  Bull Creek is one of the end points.
%%   •  The hikers trekked 8, 9, 10, 11, and 12 miles.
%

construct_hiker(Distance, hiker(_, _, Distance)).

% Each hiker has the form: hiker(Name, Start, Distance).
solve(Hs) :-
    % create all hikers by distance
    maplist(construct_hiker, [8, 9, 10, 11, 12], Hs),

    % make sure that all names are included
    member(hiker(brandi, _, _), Hs),

    % make sure that all end points are included
    member(hiker(_, bull_creek, _), Hs),
    member(hiker(_, lake_jesup, _), Hs),

    % Of Rebecca and the hiker who trekked for 10 miles,
    % one started at Reedy Creek and the other started at Cassia.
    (member(hiker(rebecca, reedy_creek, _), Hs), member(hiker(_, cassia, 10), Hs);
     member(hiker(rebecca, cassia, _), Hs), member(hiker(_, reedy_creek, 10), Hs)),

    % The hiker who started at Tosohatchee walked somewhat more than Iris.
    (member(hiker(_, tosohatchee, DistTosohatchee), Hs), member(hiker(iris, _, DistIris), Hs),
     DistTosohatchee > DistIris),

    % Rebecca is either the person who trekked for 11 miles or the hiker who started at Tosohatchee.
    ((member(hiker(rebecca, _, 11), Hs); member(hiker(rebecca, tosohatchee, _), Hs)),
     \+ member(hiker(rebecca, tosohatchee, 11), Hs)),

    % Danielle walked somewhat less than the person who started at Reedy Creek.
    (member(hiker(danielle, _, DistDanielle), Hs), member(hiker(_, reedy_creek, DistReedyCreek), Hs),
     DistDanielle < DistReedyCreek),

    % The hiker who trekked for 8 miles didn't start at Lake Jesup.
    \+ member(hiker(_, lake_jesup, 8), Hs),
    
    % The hiker who started at Tosohatchee walked somewhat less than Rebecca.
    (member(hiker(_, tosohatchee, DistTosohatchee), Hs), member(hiker(rebecca, _, DistRebecca), Hs),
     DistTosohatchee < DistRebecca),
    
    % Pauline walked 1 mile more than Iris.
    (member(hiker(pauline, _, DistPauline), Hs), member(hiker(iris, _, DistIris), Hs),
     DistPauline =:= DistIris + 1).

print_solution([]) :- !.
print_solution([hiker(Name, Location, Distance)|T]) :-
    prettify(Name, NameCap),
    prettify(Location, LocCap),
    format("~w started at ~w and hiked ~w miles.~n",
           [NameCap, LocCap, Distance]),
    print_solution(T).

show_solution :-
    solve(Hs),
    print_solution(Hs),
    halt.
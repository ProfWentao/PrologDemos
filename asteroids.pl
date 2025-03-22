% Your program goes here
/*
Spaceco Mining plans to be the first company to ever successfully mine an asteroid.
In fact it has already established a timeline for its first series of mining expeditions.
Using only the clues below, match each asteroid to its diameter, and determine what
element Spaceco plans to mine from it, as well as the year they intend to begin mining.

asteroids: 11 Ceres, 26 Amphitrite, 35 Ursula, 413 Doiotima, 82 Sylvia
elements: cobalt, lanthanum, nickel, phosporous, platinum
year: 2025, 2030, 2034, 2035, 2045
diameters: 11, 17, 23, 29, 35

1. The asteroid rich in cobalt has a diameter that is somewhat smaller than the asteroid that Spaceco will begin mining in 2030.
2. 11 Ceres won't have mining operations begin there in 2045.
3. 26 Amphitrite is either the asteroid with a diameter of 17 km or the asteroid rich in lanthanum.
4. Of the asteroid with a diameter of 29 km and 35 Ursula, one is rich in lanthanum and the other will see mining operations begin in 2034.
5. The asteroid with a diameter of 11 km won't have mining operations begin there in 2025.
6. Of 82 Sylvia and the asteroid that Spaceco will begin mining in 2034, one is rich in phosphorous and the other is 23 km across.
7. The asteroid rich in nickel has a diameter 6 km larger than the asteroid rich in platinum.
8. The asteroid that Spaceco will begin mining in 2030 has a diameter 6 km smaller than 35 Ursula.
9. 11 Ceres doesn't have an exact diameter of 11 km.
10. The asteroid with a diameter of 29 km is either 82 Sylvia or the asteroid that Spaceco will begin mining in 2045.
*/

% :- use_rendering(table,
% 		 [header(asteroid('name', 'element', 'diameter', 'year'))]).

construct_asteroid(Diameter, asteroid(_, _, Diameter, _)).

solve(As):-
    % create an ordered list by diameter
    maplist(construct_asteroid, [11, 17, 23, 29, 35], As),
    
    % make sure all years are included
    member(asteroid(_, _, _, 2025), As),
    member(asteroid(_, _, _, 2030), As),
    member(asteroid(_, _, _, 2034), As),
    member(asteroid(_, _, _, 2035), As),
    member(asteroid(_, _, _, 2045), As),

    % make sure that all names are included
    member(asteroid('413 Doiotima', _, _, _), As),
    member(asteroid('11 Ceres', _, _, _), As), % only has negative assertion so needs to be included
    member(asteroid('26 Amphirite', _, _, _), As), % why is this needed?
    % member(asteroid('35 Ursula', _, _, _), As), % not needed
    % member(asteroid('82 Sylvia', _, _, _), As), % not needed

    % 1. The asteroid rich in cobalt has a diameter that is somewhat smaller than the asteroid that Spaceco will begin mining in 2030.
    (member(asteroid(_, cobalt, D1, _), As), member(asteroid(_, _, D2, 2030), As),
     D1 < D2),

	% 2. 11 Ceres won't have mining operations begin there in 2045.
	\+ member(asteroid('11 Ceres', _, _, 2045), As),

	% 3. 26 Amphitrite is either the asteroid with a diameter of 17 km or the asteroid rich in lanthanum.
	(member(asteroid('26 Amphirite', _, 17, _), As); member(asteroid('26 Amphirite', lanthanum, _, _), As)),
    \+ member(asteroid('26 Amphirite', lanthanum, 17, _), As),

	% 4. Of the asteroid with a diameter of 29 km and 35 Ursula, one is rich in lanthanum and the other will see mining operations begin in 2034.
    % why removing this clause ends up with no solution?
	((member(asteroid(_, lanthanum, 29, _), As), member(asteroid('35 Ursula', _, _, 2034), As));
	 (member(asteroid(_, _, 29, 2034), As), member(asteroid('35 Ursula', lanthanum, _, _), As))),
	 \+ member(asteroid('35 Ursula', lanthanum, 29, 2034), As),

	% 5. The asteroid with a diameter of 11 km won't have mining operations begin there in 2025.
	\+ member(asteroid(_, _, 11, 2025), As),

	% 6. Of 82 Sylvia and the asteroid that Spaceco will begin mining in 2034, one is rich in phosphorous and the other is 23 km across.
	((member(asteroid('82 Sylvia', phosphorous, _, _), As), member(asteroid(_, _, 23, 2034), As));
     (member(asteroid('82 Sylvia', _, 23, _), As), member(asteroid(_, phosphorous, _, 2034), As))),
	\+ member(asteroid('82 Sylvia', phosphorous, 23, 2034), As),

	% 7. The asteroid rich in nickel has a diameter 6 km larger than the asteroid rich in platinum.
	(member(asteroid(_, nickel, Dnickel, _), As), member(asteroid(_, platinum, Dplatinum, _), As),
     Dnickel =:= Dplatinum + 6),

	% 8. The asteroid that Spaceco will begin mining in 2030 has a diameter 6 km smaller than 35 Ursula.
	(member(asteroid(_, _, D2030, 2030), As),
     member(asteroid('35 Ursula', _, DUrsula, _), As),
     D2030 =:= DUrsula - 6),

	% 9. 11 Ceres doesn't have an exact diameter of 11 km.
	\+ member(asteroid('11 Ceres', _, 11, _), As),

	% 10. The asteroid with a diameter of 29 km is either 82 Sylvia or the asteroid that Spaceco will begin mining in 2045.
	(member(asteroid('82 Sylvia', _, 29, _), As); member(asteroid(_, _, 29, 2045), As)),
    \+ member(asteroid('82 Sylvia', _, _, 2045), As).

print_solution([]) :- !.
print_solution([asteroid(Name, Element, Diameter, Year) | T]) :-
    format("Asteroid ~w contains ~w with diameter ~w and mining expedition will start in ~w.~n",
        [Name, Element, Diameter, Year]),
    print_solution(T).

show_solution :-
    solve(As),
    print_solution(As),
    halt.
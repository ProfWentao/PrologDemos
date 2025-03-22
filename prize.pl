/*

A prize has been announced, awarding $50 million to the first privately-owned company
to successfully send a probe to Neptune. Using only the clues that follow, match each
company to its rocket and home country, and determine the month in which it will
launch its probe.

1. The Cornick is from Iran.
2. The rocket from Qatar isn't owned by Permias.
3. The rocket that will launch in May isn't owned by Vexatech.
4. Of the rocket from Qatar and the rocket developed by Vexatech, one will launch in March and the other is the Cornick.
5. Neither the rocket that will launch in February nor the rocket developed by Vexatech is the Athios.
6. The Foltron will launch sometime after the rocket from France.
7. The Dreadco isn't from Hungary.
8. The rocket from Hungary is either the rocket developed by Ubersplore or the rocket developed by Rubicorp.
9. Of the rocket from Germany and the rocket developed by Omnipax, one will launch in June and the other is the Athios.
10. The Worul will launch 1 month before the rocket from Iran.
11. The Exatris is either the rocket developed by Ubersplore or the rocket that will launch in January.
12. The Dreadco is made by Rubicorp.
13. The rocket from France will launch sometime after the Dreadco.

*/

rockets(Rs) :-
    % each rocket has a name, company, country, and month it will be launched.
    %   h(Name, Company, Country, Moth)
    length(Rs, 6),
    member(r(Cornick, _, Iran, _), Rs),
    \+ member(r(_, Permias, Qatar, _), Rs),
    \+ member(r(_, Vexatech, _, 5), Rs),
    (member(r(Cornick, _, Qatar, _), Rs), member(r(_, Vetatech, _, 3), Rs);
     member(r(Cornick, Vetatech, _, _), Rs), member(r(_, _, Qatar, 3), Rs)),
    \+ member(r(_, Vexatech, _, 2), Rs),
    \+ member(r(Athios, Vexatech, _, _), Rs),
    \+ member(r(Athios, _, _, 2), Rs),
    ,
    

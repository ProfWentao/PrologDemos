meat(pork).
meat(beef).
meat(chicken).
meat(lamb).
meat(fish).

fruit(banana).
fruit(apple).
fruit(orange).
fruit(pear).
fruit(grape).

% Define what people like
likes(john, pork).
likes(john, apple).
likes(alice, banana).
likes(alice, pear).
likes(bob, chicken).
likes(bob, orange).

vegetarian(Person) :-
    likes(Person, _),
    \+ (likes(Person, Food), meat(Food)).

meateater(Person) :-
    distinct((likes(Person, Food), meat(Food))).
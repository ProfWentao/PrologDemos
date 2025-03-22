reigns(ram, 1900, 1950).
reigns(mike, 1951, 1970).
reigns(dilshan, 1971, 1985).
reigns(ravi, 1986, 2010).
ruler(X,Y) :- reigns(X, A, B),Y>=A,Y=<B.


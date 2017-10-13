sum(X,Y,R) :- R is X + Y.

max2(X,Y,M) :- (X=<Y, M = Y) ; (X>Y, M = X).

max2(X,Y,Z,M) :- max2(X,Y,T), max2(T,Z,M).
clc :- nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,
	   nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,
	   nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,
	   nl,nl,nl,nl,nl,nl,nl,nl,nl,nl.

% 3.1
animal(chien). 
animal(chat). 

prenom(paul). 
prenom(pierre). 
prenom(jean). 

possede(jean,chat). 
possede(pierre,chien). 
possede(pierre,cheval). 

amis(pierre,jean). 
amis(jean,pierre). 
amis(jean,paul). 
amis(pierre,paul).
amis(paul,jacques).

% 3.5 - 3.6
amis_2(X,Z) :- 
	amis(X,Y),
	amis(Y,Z),
	X=Z.

% 4.1
amis(X) :- amis(X,_).

% 4.3
% 1
sum(X,Y,R) :- R is X+Y.

% 2
max2(X,Y,M) :-
	X < Y, M is Y;
	X > Y, M is X;
	X==Y, M is -1, 
	write('Les valeurs sont identiques').
	
max3(X,Y,Z,M) :-
	X == Y, max2(X,Z,M);
	X == Z, max2(X,Y,M);
	Y == Z, max2(X,Y,M);
	max2(X,Y,N), max2(Z,N,M);
	X == Y, X == Z, M is -1, 
	write('Les valeurs sont identiques').

% 3 d(F,X,G) :-
	
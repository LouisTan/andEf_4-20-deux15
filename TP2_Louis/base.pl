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

% 3.5
amis_2(X,Z) :- amis(X,Y) , amis(Y,Z) , X=Z.

% 3.7
homme(hugo).
homme(loic).
homme(gabriel).
homme(maxime).
homme(mathieu).
homme(alexis).

femme(catherine).
femme(justine).
femme(lea).
femme(alice).
femme(rose).
femme(emma).

marie(hugo,catherine).
marie(loic,justine).
marie(gabriel,alice).

% Symetrie = boucle infinie!
marie(X,Y) :- marie(X,Y);marie(Y,X).
	
parent(hugo,gabriel).
parent(hugo,lea).
parent(gabriel,alexis).
parent(gabriel,rose).
parent(gabriel,emma).
parent(loic,alice).
parent(loic,maxime).
parent(loic,mathieu).

enfant(X,Y) :- parent(Y,X).

% Fait planter!
parent(X,Y) :-
	marie(X,Z),
	parent(Z,Y).

grand_parent(X,Y) :-
	parent(Z,X),
	parent(Y,Z).

pere(X,Y) :-
	parent(X,Y),
	homme(X).

mere(X,Y) :-
	parent(X,Y),
	homme(X).

fils(X,Y) :-
	%enfant(X,Y),
	parent(Y,X),
	homme(X).
	

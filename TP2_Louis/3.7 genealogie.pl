clc :- nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,
	   nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,
	   nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,
	   nl,nl,nl,nl,nl,nl,nl,nl,nl,nl.

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
	
parent(hugo,gabriel).
parent(hugo,lea).
parent(gabriel,alexis).
parent(gabriel,rose).
parent(gabriel,emma).
parent(loic,alice).
parent(loic,maxime).
parent(loic,mathieu).

parent(catherine,gabriel).
parent(catherine,lea).
parent(alice,alexis).
parent(alice,rose).
parent(alice,emma).
parent(justine,alice).
parent(justine,maxime).
parent(justine,mathieu).

enfant(X,Y) :- parent(Y,X).

pere(X,Y) :-
	parent(X,Y),
	homme(X).

mere(X,Y) :-
	parent(X,Y),
	homme(X).

fils(X,Y) :-
	enfant(X,Y),
	homme(X).

fille(X,Y) :-
	enfant(X,Y),
	femme(X).

grand_parent(X,Y) :-
	parent(X,Z).
	parent(Z,Y).

grand_mere(X,Y) :-
	grand_parent(X,Y),
	femme(X).

grand_pere(X,Y) :-
	grand_parent(X,Y),
	homme(X).

petit_enfant(X,Y) :-
	parent(Y,Z),
	parent(Z,X).

petit_fils(X,Y) :-
	petit_enfant(X,Y),
	homme(X).

petite_fille(X,Y) :-
	petit_enfant(X,Y),
	femme(X).

siblings(X,Y) :-
	mere(Z,X),
	mere(Z,Y),
	X\=Y.

frere(X,Y) :-
	siblings(X,Y),
	homme(X).

soeur(X,Y) :-
	siblings(X,Y),
	femme(X).

%oncle
%tante
%niece
%neveu


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

%parent(pere,mere,enfant)
parent(hugo,catherine,lea).
parent(hugo,catherine,gabriel).
parent(loic,justine,alice).
parent(loic,justine,maxime).
parent(loic,justine,mathieu).
parent(gabriel,alice,alexis).
parent(gabriel,alice,rose).
parent(gabriel,alice,emma).

% X est l'enfant de Y, X est l'oncle de Y ...
enfant(X,Y) :- parent(Y,Z,X) ; parent(Z,Y,X).
fille(X,Y) :- enfant(X,Y) , femme(X).
fils(X,Y) :- enfant(X,Y) , homme(X).
mere(X,Y) :- enfant(Y,X) , femme(X).
pere(X,Y) :- enfant(Y,X) , homme(X).
oncle(X,Y) :- (pere(Z,Y);mere(Z,Y)),pere(P,Z),fils(X,P),X\=Z.
tante(X,Y) :- (pere(Z,Y);mere(Z,Y)),pere(P,Z),fille(X,P),X\=Z.
grand_parent(X,Y) :- (pere(Z,Y);mere(Z,Y)) , (pere(X,Z);mere(X,Z)).
grand_pere(X,Y) :- grand_parent(X,Y), homme(X).
grand_mere(X,Y) :- grand_parent(X,Y), femme(X).
petit_enfants(X,Y) :- grand_parent(Y,X).
petite_fille(X,Y) :- petit_enfants(X,Y), femme(X).
petit_fils(X,Y) :- petit_enfants(X,Y), homme(X).
neveu(X,Y) :- (oncle(Y,X);tante(Y,X)), homme(X).
niece(X,Y) :- (oncle(Y,X);tante(Y,X)), femme(X).
frere(X,Y) :- pere(P,Y), fils(X,P), X\=Y.
soeur(X,Y) :- pere(P,Y), fille(X,P), X\=Y.
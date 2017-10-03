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

parent(hugo, catherine, lea).
parent(hugo, catherine, gabriel).
parent(loic, justine, alice).
parent(loic, justine, maxime).
parent(loic, justine, mathieu).
parent(gabriel, alice, alexis).
parent(gabriel, alice, rose).
parent(gabriel, alice, emma).

enfant(X,Y):- parent(Y, _, X).
enfant(X,Y):- parent(_, Y, X).

fille(X,Y):- femme(X), enfant(X,Y).

fils(X,Y):- homme(X), enfant(X,Y).

mere(X,Y):- femme(X), enfant(Y,X).

pere(X,Y):- homme(X), enfant(Y,X).

oncle(X,Y):- homme(X), parent(GrandParent1, GrandParent2, X), parent(GrandParent1, GrandParent2, Parent), Parent \== X, enfant(Y,Parent).

tante(X,Y):- femme(X), parent(GrandParent1, GrandParent2, X), parent(GrandParent1, GrandParent2, Parent), Parent \== X, enfant(Y,Parent).

grand_parent(X,Y):- enfant(Y, Parent), enfant(Parent,X).

grand_pere(X,Y):- homme(X), grand_parent(X,Y).

grand_mere(X,Y):- femme(X), grand_parent(X,Y).

petit_enfants(X,Y):- grand_parent(Y,X).

petite_fille(X,Y):- femme(X), petit_enfants(X,Y).

petit_fils(X,Y):- homme(X), petit_enfant(X,Y).

neveu(X,Y):- homme(X), oncle(Y,X).
neveu(X,Y):- homme(X), tante(Y,X).

niece(X,Y):- femme(X), oncle(Y,X).
niece(X,Y):- femme(X), tante(Y,X).

frere(X,Y):- homme(X), parent(P1, P2, X), parent(P1, P2, Y), X \== Y.

soeur(X,Y):- femme(X), parent(P1, P2, X), parent(P1, P2, Y), X \== Y.
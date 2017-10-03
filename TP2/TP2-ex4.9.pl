use_module(library(clpfd)).

personne(anglais).
personne(japonais).
personne(espagnol).

maison(rouge).
maison(bleue).
maison(jaune).

animal(jaguar).
animal(escargot).
animal(serpent).

triplet(anglais,rouge,_,_).
	
triplet(espagnol,_,_,jaguar).

triplet(japonais,_,N,_):-
	triplet(_,_,Ne,escargot),
	N < Ne.
	
triplet(_,_,N,escargot):-
	triplet(_,bleue,Nb,_),
	N > Nb.
	
solution(P1,M1,N1,A1,P2,M2,N2,A2,P3,M3,N3,A3):-
	personne(P1),
	personne(P2),
	personne(P3),
	maison(M1),
	maison(M2),
	maison(M3),
	animal(A1),
	animal(A2),
	animal(A3),
	triplet(P1,M1,N1,A1),
	triplet(P2,M2,N2,A2),
	triplet(P3,M3,N3,A3).
	


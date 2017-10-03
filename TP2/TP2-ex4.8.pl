:-consult('TP2-ex4.3.pl').

%%%%%%%%%%%%%%%%%%
%% Max d'une liste
max([],0).
	
max(L,M):-
	L=[E|L1],
	max(L1,M1),
	max2(E,M1,M).
	
%%%%%%%%%%%%%%%%%%%%
%% Somme d'une liste
somme([],0).

somme(L,M):-
	L=[E|L1],
	somme(L1,M1),
	M is (M1 + E).
	
%%%%%%%%%%%%%%%%%%%%
%% "Zip" d'une liste
zip(L1,L2,R):-
	L1=[E1|L1bis],
	L2=[E2|L2bis],
	zip(L1bis,L2bis,Rbis),
	R = [[E1,E2]|Rbis].
	
zip([],[],[]).

%% Gestion des listes non egales. Si on prefere une erreur, supprimer ces deux lignes.
zip([],L,L).
zip(L,[],L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Creation d'une liste d'entiers de 0 a N
enumerate(N,L):-
	enumerate(N,L,N).
	
%% Fonctions locales avec un parametre supplementaire
%% permettant de se rappeler quel est l'entier de depart
enumerate(0,[Max],Max).
	
enumerate(N,L,Max):-
	N >= 1,
	N1 is (N-1),
	N2 is (Max - N),
	enumerate(N1,L1,Max),
	L = [N2|L1].
	
%%%%%%%%%%%%%%%%%%%
%% Calcul d'arrondi

rend_monnaie(Argent,Prix):-
	Monnaie is (Argent - Prix),
	Pieces2 is floor(Monnaie / 2),
	Pieces1 is floor(Monnaie - Pieces2 * 2),
	Pieces25 is floor((Monnaie - Pieces2 * 2 - Pieces1) * 4),
	Pieces10 is floor((Monnaie - Pieces2 * 2 - Pieces1 - Pieces25 * 0.25) * 10),
	Pieces5 is floor((Monnaie - Pieces2 * 2 - Pieces1 - Pieces25 * 0.25 - Pieces10 * 0.1) * 20),
	write('A rendre:'),
	nl,
	write(Pieces5),
	write(' pieces de 0.05'),
	nl,
	write(Pieces10),
	write(' pieces de 0.10'),
	nl,
	write(Pieces25),
	write(' pieces de 0.25'),
	nl,
	write(Pieces1),
	write(' pieces de 1'),
	nl,
	write(Pieces2),
	write(' pieces de 2'),
	nl.
	
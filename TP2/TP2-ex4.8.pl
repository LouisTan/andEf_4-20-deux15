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
%% n-eme element d'une liste nth(N,L,R)
nth(N,L,R) :-
    L = [H|T],
    ((N=1 , R=H);
    (N1 is N-1 , nth(N1,T,R))).

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

rend_monnaie(Argent,Prix) :-
    Monnaie is (Argent - Prix),
    rend_monnaie2(Monnaie,[P2,P1,P025,P010,P005]),
    write('A rendre:'),
	nl,
	write(P005),
	write(' pieces de 0.05'),
	nl,
	write(P010),
	write(' pieces de 0.10'),
	nl,
	write(P025),
	write(' pieces de 0.25'),
	nl,
	write(P1),
	write(' pieces de 1'),
	nl,
	write(P2),
	write(' pieces de 2'),
	nl.

rend_monnaie2(Monnaie,[0,0,0,0,0]) :- Monnaie < 0.05.

rend_monnaie2(Monnaie,[P2,P1,P025,P010,P005]) :-
    (Monnaie >= 2 , Monnaie2 is floor((Monnaie-2 + 0.001)*100)/100 , rend_monnaie2(Monnaie2,[P22,P1,P025,P010,P005]) , P2 is P22 + 1);
    (Monnaie < 2 , Monnaie >= 1 , Monnaie2 is floor((Monnaie-1 + 0.001)*100)/100, rend_monnaie2(Monnaie2,[P2,P12,P025,P010,P005]) , P1 is P12 + 1 );
    (Monnaie < 1 , Monnaie >= 0.25 , Monnaie2 is floor((Monnaie-0.25 + 0.001)*100)/100 , rend_monnaie2(Monnaie2,[P2,P1,P0252,P010,P005]) , P025 is P0252 + 1 );
    (Monnaie < 0.25 , Monnaie >= 0.10 , Monnaie2 is floor((Monnaie-0.10 + 0.001)*100)/100, rend_monnaie2(Monnaie2,[P2,P1,P025,P0102,P005]), P010 is P0102 + 1 );
    (Monnaie < 0.10 , Monnaie >= 0.05 , Monnaie2 is floor((Monnaie-0.05 + 0.001)*100)/100 , rend_monnaie2(Monnaie2,[P2,P1,P025,P010,P0052]) , P005 is P0052 + 1).
	
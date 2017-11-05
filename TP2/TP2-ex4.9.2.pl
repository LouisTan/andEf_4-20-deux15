:- use_module(library(clpfd)).

%P
% 0 - anglais
% 1 - espagnol
% 2 - ukrainien
% 3 - norvegien
% 4 - japonais

%C
% 0 - rouge
% 1 - bleu
% 2 - blanche
% 3 - jaune
% 4 - vert

%A
% 0 - chien
% 1 - escargot
% 2 - renard
% 3 - cheval
% 4 - zebre

%M
% 0 - sculpteur
% 1 - diplomate
% 2 - medecin
% 3 - violoniste
% 4 - acrobate

%B
% 0 - cafe
% 1 - the
% 2 - lait
% 3 - jus d'orange
% 4 - eau

%Po
% 0 - gauche
% 1 - milieu gauche
% 2 - milieu
% 3 - milieu droite
% 4 - droite

contraint_init([P1, P2, P3, P4, P5]) :-
    P1 #= 0, P2 #= 1, P3 #= 2, P4 #= 3, P5 #= 4.  

contraint_two_argument([Arg1_1,Arg1_2,Arg1_3,Arg1_4,Arg1_5], Val1, [Arg2_1,Arg2_2,Arg2_3,Arg2_4,Arg2_5], Val2) :-
    (Arg1_1 #= Val1 , Arg2_1 #= Val2);
    (Arg1_2 #= Val1 , Arg2_2 #= Val2);
    (Arg1_3 #= Val1 , Arg2_3 #= Val2);
    (Arg1_4 #= Val1 , Arg2_4 #= Val2);
    (Arg1_5 #= Val1 , Arg2_5 #= Val2).

%1 L'Anglais habite la maison rouge.
contraint_1(P,C) :- 
    contraint_two_argument(P,0,C,0).

%2 L'Espagnol a un chien.
contraint_2(P,A) :- 
    contraint_two_argument(P,1,A,0).

%3 Dans la maison verte, on boit du cafe.
contraint_3(C,B) :- 
    contraint_two_argument(C,4,B,0).

%4 L'Ukrainien boit du the.
contraint_4(P,B) :- 
    contraint_two_argument(P,2,B,1).

%5 La maison verte est immediatement a droite de la maison blanche.
contraint_5([C1, C2, C3, C4, C5],[Po1, Po2, Po3, Po4, Po5]) :- 
    (C1 #= 4 , C2 #= 2 , Po1 #= Po2 + 1);
    (C1 #= 4 , C3 #= 2 , Po1 #= Po3 + 1);
    (C1 #= 4 , C4 #= 2 , Po1 #= Po4 + 1);
    (C1 #= 4 , C5 #= 2 , Po1 #= Po5 + 1);

    (C2 #= 4 , C1 #= 2 , Po2 #= Po1 + 1);
    (C2 #= 4 , C3 #= 2 , Po2 #= Po3 + 1);
    (C2 #= 4 , C4 #= 2 , Po2 #= Po4 + 1);
    (C2 #= 4 , C5 #= 2 , Po2 #= Po5 + 1);

    (C3 #= 4 , C1 #= 2 , Po3 #= Po1 + 1);
    (C3 #= 4 , C2 #= 2 , Po3 #= Po2 + 1);
    (C3 #= 4 , C4 #= 2 , Po3 #= Po4 + 1);
    (C3 #= 4 , C5 #= 2 , Po3 #= Po5 + 1);

    (C4 #= 4 , C1 #= 2 , Po4 #= Po1 + 1);
    (C4 #= 4 , C2 #= 2 , Po4 #= Po2 + 1);
    (C4 #= 4 , C3 #= 2 , Po4 #= Po3 + 1);
    (C4 #= 4 , C5 #= 2 , Po4 #= Po5 + 1);

    (C5 #= 4 , C1 #= 2 , Po5 #= Po1 + 1);
    (C5 #= 4 , C2 #= 2 , Po5 #= Po2 + 1);
    (C5 #= 4 , C3 #= 2 , Po5 #= Po3 + 1);
    (C5 #= 4 , C4 #= 2 , Po5 #= Po4 + 1).

%6 Le sculpteur eleve des escargots.
contraint_6(M,A) :- 
    contraint_two_argument(M,0,A,1).

%7 Le diplomate habite la maison jaune.
contraint_7(M,C) :- 
    contraint_two_argument(M,1,C,3).

%8 Dans la maison du milieu, on boit du lait.
contraint_8(Po,B) :- 
    contraint_two_argument(Po,2,B,2).

%9 Le Norvegien habite la premiere maison a gauche.
contraint_9(P,Po) :- 
    contraint_two_argument(P,3,Po,0).

%10 Le medecin habite une maison voisine de celle ou demeure le proprietaire du renard.
contraint_10([M1, M2, M3, M4, M5],[A1, A2, A3, A4, A5],[Po1, Po2, Po3, Po4, Po5]) :- 
    (M1 #= 2 , A2 #= 2 , (Po1 #= Po2 + 1 ; Po1 #= Po2 - 1));
    (M1 #= 2 , A3 #= 2 , (Po1 #= Po3 + 1 ; Po1 #= Po3 - 1));
    (M1 #= 2 , A4 #= 2 , (Po1 #= Po4 + 1 ; Po1 #= Po4 - 1));
    (M1 #= 2 , A5 #= 2 , (Po1 #= Po5 + 1 ; Po1 #= Po5 - 1));

    (M2 #= 2 , A1 #= 2 , (Po2 #= Po1 + 1 ; Po2 #= Po1 - 1));
    (M2 #= 2 , A3 #= 2 , (Po2 #= Po3 + 1 ; Po2 #= Po3 - 1));
    (M2 #= 2 , A4 #= 2 , (Po2 #= Po4 + 1 ; Po2 #= Po4 - 1));
    (M2 #= 2 , A5 #= 2 , (Po2 #= Po5 + 1 ; Po2 #= Po5 - 1));

    (M3 #= 2 , A1 #= 2 , (Po3 #= Po1 + 1 ; Po3 #= Po1 - 1));
    (M3 #= 2 , A2 #= 2 , (Po3 #= Po2 + 1 ; Po3 #= Po2 - 1));
    (M3 #= 2 , A4 #= 2 , (Po3 #= Po4 + 1 ; Po3 #= Po4 - 1));
    (M3 #= 2 , A5 #= 2 , (Po3 #= Po5 + 1 ; Po3 #= Po5 - 1));

    (M4 #= 2 , A1 #= 2 , (Po4 #= Po1 + 1 ; Po4 #= Po1 - 1));
    (M4 #= 2 , A2 #= 2 , (Po4 #= Po2 + 1 ; Po4 #= Po2 - 1));
    (M4 #= 2 , A3 #= 2 , (Po4 #= Po3 + 1 ; Po4 #= Po3 - 1));
    (M4 #= 2 , A5 #= 2 , (Po4 #= Po5 + 1 ; Po4 #= Po5 - 1));

    (M5 #= 2 , A1 #= 2 , (Po5 #= Po1 + 1 ; Po5 #= Po1 - 1));
    (M5 #= 2 , A2 #= 2 , (Po5 #= Po2 + 1 ; Po5 #= Po2 - 1));
    (M5 #= 2 , A3 #= 2 , (Po5 #= Po3 + 1 ; Po5 #= Po3 - 1));
    (M5 #= 2 , A4 #= 2 , (Po5 #= Po4 + 1 ; Po5 #= Po4 - 1)).

%11 La maison du diplomate est a cote de celle ou il y a un cheval.
contraint_11([M1, M2, M3, M4, M5],[A1, A2, A3, A4, A5],[Po1, Po2, Po3, Po4, Po5]) :- 
    (M1 #= 1 , A2 #= 3 , (Po1 #= Po2 + 1 ; Po1 #= Po2 - 1));
    (M1 #= 1 , A3 #= 3 , (Po1 #= Po3 + 1 ; Po1 #= Po3 - 1));
    (M1 #= 1 , A4 #= 3 , (Po1 #= Po4 + 1 ; Po1 #= Po4 - 1));
    (M1 #= 1 , A5 #= 3 , (Po1 #= Po5 + 1 ; Po1 #= Po5 - 1));

    (M2 #= 1 , A1 #= 3 , (Po2 #= Po1 + 1 ; Po2 #= Po1 - 1));
    (M2 #= 1 , A3 #= 3 , (Po2 #= Po3 + 1 ; Po2 #= Po3 - 1));
    (M2 #= 1 , A4 #= 3 , (Po2 #= Po4 + 1 ; Po2 #= Po4 - 1));
    (M2 #= 1 , A5 #= 3 , (Po2 #= Po5 + 1 ; Po2 #= Po5 - 1));

    (M3 #= 1 , A1 #= 3 , (Po3 #= Po1 + 1 ; Po3 #= Po1 - 1));
    (M3 #= 1 , A2 #= 3 , (Po3 #= Po2 + 1 ; Po3 #= Po2 - 1));
    (M3 #= 1 , A4 #= 3 , (Po3 #= Po4 + 1 ; Po3 #= Po4 - 1));
    (M3 #= 1 , A5 #= 3 , (Po3 #= Po5 + 1 ; Po3 #= Po5 - 1));

    (M4 #= 1 , A1 #= 3 , (Po4 #= Po1 + 1 ; Po4 #= Po1 - 1));
    (M4 #= 1 , A2 #= 3 , (Po4 #= Po2 + 1 ; Po4 #= Po2 - 1));
    (M4 #= 1 , A3 #= 3 , (Po4 #= Po3 + 1 ; Po4 #= Po3 - 1));
    (M4 #= 1 , A5 #= 3 , (Po4 #= Po5 + 1 ; Po4 #= Po5 - 1));

    (M5 #= 1 , A1 #= 3 , (Po5 #= Po1 + 1 ; Po5 #= Po1 - 1));
    (M5 #= 1 , A2 #= 3 , (Po5 #= Po2 + 1 ; Po5 #= Po2 - 1));
    (M5 #= 1 , A3 #= 3 , (Po5 #= Po3 + 1 ; Po5 #= Po3 - 1));
    (M5 #= 1 , A4 #= 3 , (Po5 #= Po4 + 1 ; Po5 #= Po4 - 1)).

%12 Le violoniste boit du jus d'orange.
contraint_12(M,B) :- 
    contraint_two_argument(M,3,B,3).

%13 Le Japonais est acrobate.
contraint_13(P,M) :- 
    contraint_two_argument(P,4,M,4).

%14 Le Norvegien habite a cote de la maison bleue.
contraint_14([P1, P2, P3, P4, P5],[C1, C2, C3, C4, C5],[Po1, Po2, Po3, Po4, Po5]) :- 
    (P1 #= 3 , C2 #= 1 , (Po1 #= Po2 + 1 ; Po1 #= Po2 - 1));
    (P1 #= 3 , C3 #= 1 , (Po1 #= Po3 + 1 ; Po1 #= Po3 - 1));
    (P1 #= 3 , C4 #= 1 , (Po1 #= Po4 + 1 ; Po1 #= Po4 - 1));
    (P1 #= 3 , C5 #= 1 , (Po1 #= Po5 + 1 ; Po1 #= Po5 - 1));

    (P2 #= 3 , C1 #= 1 , (Po2 #= Po1 + 1 ; Po2 #= Po1 - 1));
    (P2 #= 3 , C3 #= 1 , (Po2 #= Po3 + 1 ; Po2 #= Po3 - 1));
    (P2 #= 3 , C4 #= 1 , (Po2 #= Po4 + 1 ; Po2 #= Po4 - 1));
    (P2 #= 3 , C5 #= 1 , (Po2 #= Po5 + 1 ; Po2 #= Po5 - 1));

    (P3 #= 3 , C1 #= 1 , (Po3 #= Po1 + 1 ; Po3 #= Po1 - 1));
    (P3 #= 3 , C2 #= 1 , (Po3 #= Po2 + 1 ; Po3 #= Po2 - 1));
    (P3 #= 3 , C4 #= 1 , (Po3 #= Po4 + 1 ; Po3 #= Po4 - 1));
    (P3 #= 3 , C5 #= 1 , (Po3 #= Po5 + 1 ; Po3 #= Po5 - 1));

    (P4 #= 3 , C1 #= 1 , (Po4 #= Po1 + 1 ; Po4 #= Po1 - 1));
    (P4 #= 3 , C2 #= 1 , (Po4 #= Po2 + 1 ; Po4 #= Po2 - 1));
    (P4 #= 3 , C3 #= 1 , (Po4 #= Po3 + 1 ; Po4 #= Po3 - 1));
    (P4 #= 3 , C5 #= 1 , (Po4 #= Po5 + 1 ; Po4 #= Po5 - 1));

    (P5 #= 3 , C1 #= 1 , (Po5 #= Po1 + 1 ; Po5 #= Po1 - 1));
    (P5 #= 3 , C2 #= 1 , (Po5 #= Po2 + 1 ; Po5 #= Po2 - 1));
    (P5 #= 3 , C3 #= 1 , (Po5 #= Po3 + 1 ; Po5 #= Po3 - 1));
    (P5 #= 3 , C4 #= 1 , (Po5 #= Po4 + 1 ; Po5 #= Po4 - 1)).


all_contraint(P,C,A,M,B,Po) :-
    contraint_init(P),
    contraint_1(P,C),
    contraint_2(P,A),
    contraint_3(C,B),
    contraint_4(P,B),
    contraint_5(C,Po),
    contraint_6(M,A),
    contraint_7(M,C),
    contraint_8(Po,B),
    contraint_9(P,Po),
    contraint_10(M,A,Po),
    contraint_11(M,A,Po),
    contraint_12(M,B),
    contraint_13(P,M),
    contraint_14(P,C,Po).

% et trouvez qui boit de l'eau et qui possede le zebre.

solution() :-
    Sol = [P,C,A,M,B,Po],
    P = [P1, P2, P3, P4, P5], P ins 0..4, 
    C = [C1, C2, C3, C4, C5], C ins 0..4, 
    A = [A1, A2, A3, A4, A5], A ins 0..4, 
    M = [M1, M2, M3, M4, M5], M ins 0..4, 
    B = [B1, B2, B3, B4, B5], B ins 0..4, 
    Po = [Po1, Po2, Po3, Po4, Po5], Po ins 0..4, 
    all_different(P),
    all_different(C),
    all_different(A),
    all_different(M),
    all_different(B),
    all_different(Po),
    all_contraint(P,C,A,M,B,Po),
    find_solution1(B,P,P_1),
    find_solution2(A,P,P_2),
    transform_output(P_1,Out1),
    transform_output(P_2,Out2),
    write_solution(Out1,Out2).


find_solution1([B1, B2, B3, B4, B5],[P1, P2, P3, P4, P5] , P) :-
    ((B1 #= 4), P#=P1);
    ((B2 #= 4), P#=P2);
    ((B3 #= 4), P#=P3);
    ((B4 #= 4), P#=P4);
    ((B5 #= 4), P#=P5).

find_solution2([A1, A2, A3, A4, A5],[P1, P2, P3, P4, P5] , P) :-
    ((A1 #= 4), P#=P1);
    ((A2 #= 4), P#=P2);
    ((A3 #= 4), P#=P3);
    ((A4 #= 4), P#=P4);
    ((A5 #= 4), P#=P5).

transform_output(P,Out) :-
    (P#=0 , Out = anglais);
    (P#=1 , Out = espagnol);
    (P#=2 , Out = ukrainien);
    (P#=3 , Out = norvegien);
    (P#=4 , Out = japonais).

write_solution(Out1,Out2) :-
	write('La personne qui boit de l eau est : '),
	write(Out1),
	nl,
	write('La personne qui possede le zebre est : '),
	write(Out2),
	nl.

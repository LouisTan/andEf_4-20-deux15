:- use_module(library(clpfd)).

%P
% 0 - anglais
% 1 - espagnol
% 2 - japonais

%C
% 0 - rouge
% 1 - bleu
% 2 - inconnu

%A
% 0 - jaguar
% 1 - escargot
% 2 - serpent

%Po
% 0 - gauche
% 1 - milieu
% 2 - droite

% L'Anglais vit dans la maison rouge.
% Le jaguar est l'animal de l'espagnol.
% Le Japonais vit a droite de la maison du possesseur de l'escargot.
% Le possesseur de l'escargot vit a gauche de la maison bleue.
% trouvez qui possede le serpent


mm(P1, C1, A1, Po1, P2, C2, A2, P2,P3, C3, A3, Po3) :-
     [P1, C1, A1, Po1, P2, C2, A2, P2,P3, C3, A3, Po3] ins 0..2, 
     all_different([P1,P2,P3]),
     all_different([C1,C2,C3]),
     all_different([A1,A2,A3]),
     all_different([Po1,Po2,Po3]),
     constraints([P1, C1, A1, Po1], [P2, C2, A2, P2],[P3, C3, A3, Po3]).

constraints([P1, C1, A1, Po1], [P2, C2, A2, P2],[P3, C3, A3, Po3]) :-
    (P1#=0 , Po1#=0),
    (P2#=1 , A2#=0),
    (P3#=2 , ((A1#=1,Po3#>Po1);(A2#=1,Po3#>Po2))),
    ((A1#=1,C2#=1,Po1#<Po2);(A1#=1,C3#=1,Po1#<Po3);(A2#=1,C3#=1,Po2#<Po3);(A2#=1,C1#=1,Po2#<Po1);(A3#=1,C1#=1,Po3#<Po1);(A3#=1,C2#=1,Po3#<Po2)).
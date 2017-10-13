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
% 1 - 
% 2 - 
% 3 - 
% 4 - 
% 5 - 

%Po
% 0 - gauche
% 1 - milieu
% 2 - droite

% L'Anglais habite la maison rouge.
% L'Espagnol a un chien.
% Dans la maison verte, on boit du cafe.
% L'Ukrainien boit du the.
% La maison verte est immediatement a droite de la maison blanche.
% Le sculpteur eleve des escargots.
% Le diplomate habite la maison jaune.
% Dans la maison du milieu, on boit du lait.
% Le Norvegien habite la premiere maison a gauche.
% Le medecin habite une maison voisine de celle ou demeure le proprietaire du renard.
% La maison du diplomate est a cote de celle ou il y a un cheval.
% Le violoniste boit du jus d'orange.
% Le Japonais est acrobate.
% Le Norvegien habite a cote de la maison bleue.

%et trouvez qui boit de l'eau et qui possede le zebre.


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
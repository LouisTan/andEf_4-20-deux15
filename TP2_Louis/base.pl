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
amis_2(X,Z) :- amis(X,Y) , amis(Y,Z).
% 3.7
homme(Hugo).
homme(Loic).
homme(Gabriel).
homme(Maxime).
homme(Mathieu).
homme(Alexis).
femme(Catherine).
femme(Justine).
femme(Lea).
femme(Alice).
femme(Rose).
femme(Emma).
parent(Hugo,Lea;Gabriel).
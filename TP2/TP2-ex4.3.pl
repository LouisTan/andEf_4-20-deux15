sum(X,Y,R):- R is (X + Y).

max2(X,Y,M):- (X =< Y, M = Y); (X > Y, M = X).

max2(X,Y,Z,M):- max2(X,Y,T), max2(T,Z,M).

%% Constante seule
d(F,X,G):- C = F,
	atomic(C),
	C \=X,
	G = 0.
	
%% Monome C*X^D
d(F,X,G):- 
	((C * X^D = F,
		atomic(C),
		C \=X); 
	(X ^ D = F, 
		C = 1);
	(C * X = F, 
		D = 1);
	(X = F,
		C = 1,
		D = 1)),
	D > 0,
	D1 is (D-1),
	C1 is (C*D),
	((D1 >= 2, G = C1 * X^D1);
	(D1 == 1, G = C1 * X);
	(D1 == 0, G = C1)).

%% Polynome + constante
d(F,X,G):- Expr + C = F,
	atomic(C),
	C \= X,
	d(Expr,X,G).
	
%% Polynome + monome
d(F,X,G):- Expr + Monome = F,
	estMonome(Monome,X),
	d(Monome, X, G1),	
	d(Expr, X, G2),
	(G1 \== 0, 
		G2 \==0, 
		G = G2 + G1);
	(G1 \==0, 
		G2 == 0,
		G = G1);
	(G1 == 0, 
		G2 \==0,
		G = G2);
	(G1 == 0,
		G2 == 0,
		G = 0).
	
estMonome(F,X):-
	C * X ^ D = F,
	atomic(C),
	C \= X, 
	D >= 0.
	
estMonome(F,X):-
	X ^ D = F,
	D >= 0.

estMonome(F,X):-
	C * X = F,
	atomic(C),
	C \= X.

estMonome(F,X):-
	X = F.
	
estMonome(F,X):-
	C = F,
	atomic(C),
	C \= X.
	
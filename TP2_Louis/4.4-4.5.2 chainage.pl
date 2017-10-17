clc :- nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,
	   nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,
	   nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,
	   nl,nl,nl,nl,nl,nl,nl,nl,nl,nl.

% 4.5
pere(hugo,gabriel).
pere(gabriel,alexis).
pere(alexis,paul).
pere(paul,andre).
ancetre(X,Y):-pere(X,Y).
ancetre(X,Y):-pere(X,Z),ancetre(Z,Y).

% 4.5.1
%{trace}
%| ?- trace,ancetre(hugo,X).
%The debugger will first creep -- showing everything (trace)
%      1    1  Call: ancetre(hugo,_23) ?
%      1    1  Call: ancetre(hugo,_23) ? 
%      2    2  Call: pere(hugo,_23) ? 
%      2    2  Exit: pere(hugo,gabriel) ? 
%      1    1  Exit: ancetre(hugo,gabriel) ?
%      1    1  Exit: ancetre(hugo,gabriel) ? 
%
%X = gabriel ? ;
%      1    1  Redo: ancetre(hugo,gabriel) ? 
%      2    2  Call: pere(hugo,_96) ? 
%      2    2  Exit: pere(hugo,gabriel) ? 
%      3    2  Call: ancetre(gabriel,_23) ? 
%      4    3  Call: pere(gabriel,_23) ? 
%      4    3  Exit: pere(gabriel,alexis) ? 
%      3    2  Exit: ancetre(gabriel,alexis) ? 
%      1    1  Exit: ancetre(hugo,alexis) ? 
%
%X = alexis ? ;
%      1    1  Redo: ancetre(hugo,alexis) ? 
%      3    2  Redo: ancetre(gabriel,alexis) ? 
%      4    3  Call: pere(gabriel,_145) ? 
%      4    3  Exit: pere(gabriel,alexis) ? 
%      5    3  Call: ancetre(alexis,_23) ? 
%      6    4  Call: pere(alexis,_23) ? 
%      6    4  Exit: pere(alexis,paul) ? 
%      5    3  Exit: ancetre(alexis,paul) ? 
%      3    2  Exit: ancetre(gabriel,paul) ? 
%      1    1  Exit: ancetre(hugo,paul) ? 
%
%X = paul ? ;
%      1    1  Redo: ancetre(hugo,paul) ? 
%      3    2  Redo: ancetre(gabriel,paul) ? 
%      5    3  Redo: ancetre(alexis,paul) ? 
%      6    4  Call: pere(alexis,_194) ? 
%      6    4  Exit: pere(alexis,paul) ? 
%      7    4  Call: ancetre(paul,_23) ? 
%      8    5  Call: pere(paul,_23) ? 
%      8    5  Exit: pere(paul,andre) ? 
%      7    4  Exit: ancetre(paul,andre) ? 
%      5    3  Exit: ancetre(alexis,andre) ? 
%      3    2  Exit: ancetre(gabriel,andre) ? 
%      1    1  Exit: ancetre(hugo,andre) ? 
%
%X = andre ? ;
%      1    1  Redo: ancetre(hugo,andre) ? 
%      3    2  Redo: ancetre(gabriel,andre) ? 
%      5    3  Redo: ancetre(alexis,andre) ? 
%      7    4  Redo: ancetre(paul,andre) ? 
%      8    5  Call: pere(paul,_243) ? 
%      8    5  Exit: pere(paul,andre) ? 
%      9    5  Call: ancetre(andre,_23) ? 
%     10    6  Call: pere(andre,_23) ? 
%     10    6  Fail: pere(andre,_23) ? 
%     10    6  Call: pere(andre,_292) ? 
%     10    6  Fail: pere(andre,_280) ? 
%      9    5  Fail: ancetre(andre,_23) ? 
%      7    4  Fail: ancetre(paul,_23) ? 
%      5    3  Fail: ancetre(alexis,_23) ? 
%      3    2  Fail: ancetre(gabriel,_23) ? 
%      1    1  Fail: ancetre(hugo,_23) ? 

% 4.5.2
word(abalone, a, b, a, l, o, n, e).
word(abandon, a, b, a, n, d, o, n).
word(enhance, e, n, h, a, n, c, e).
word(anagram, a, n, a, g, r, a, m).
word(connect, c, o, n, n, e, c, t).
word(elegant, e, l, e, g, a, n, t).

%crossword(V1,V2,V3,H1,H2,H3) :-
	

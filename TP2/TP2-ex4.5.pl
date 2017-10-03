word(abalone, a,b,a,l,o,n,e).
word(abandon, a,b,a,n,d,o,n).
word(enhance, e,n,h,a,n,c,e).
word(anagram, a,n,a,g,r,a,m).
word(connect, c,o,n,n,e,c,t).
word(elegant, e,l,e,g,a,n,t).

crossword(V1,V2,V3,H1,H2,H3):-
	word(V1,_, L11,_, L21,_, L31,_),
	word(V2,_, L12,_, L22,_, L32,_),
	word(V3,_, L13,_, L23,_, L33,_),
	word(H1,_, L11,_, L12,_, L13,_),
	word(H2,_, L21,_, L22,_, L23,_),
	word(H3,_, L31,_, L32,_, L33,_).
word(abalone, a, b, a, l, o, n, e).
word(abandon, a, b, a, n, d, o, n).
word(enhance, e, n, h, a, n, c, e).
word(anagram, a, n, a, g, r, a, m).
word(connect, c, o, n, n, e, c, t).
word(elegant, e, l, e, g, a, n, t).

crossword(V1,V2,V3,H1,H2,H3) :- 
    word(V1, _, C11, _, C12, _ ,C13, _),
    word(V2, _, C21, _, C22, _ ,C23, _),
    word(V3, _, C31, _, C32, _ ,C33, _),
    word(H1, _, C11, _, C21, _ ,C31, _),
    word(H2, _, C12, _, C22, _ ,C32, _),
    word(H3, _, C13, _, C23, _ ,C33, _).
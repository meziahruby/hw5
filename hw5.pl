/*******************************************/
/**    Your solution goes in this file    **/ 
/*******************************************/

/******************************* PART 1 **************************************/

% 1. Find all novels that have been published in either 1953 or 1996.
year_1953_1996_novels(X):- novel(X,1953); novel(X,1996).

% 2. Find all novels that have been published during the period 1800 to 1900.
inRange(I, J, K):- I > J, I < K.
period_1800_1900_novels(A) :- novel(A,Y), inRange(Y,1799,1901).

% 3. Find all fans who are fans of the lord of the rings.
lotr_fans(X) :- fan(X,Y), member(the_lord_of_the_rings,Y).

% 4. Find all authors whose novels chandler is a fa n of.
author_names(D) :- fan(chandler,E), author(D,F), member(A,F), member(A,E).

% 5. Find all fans who are fans of novels authored by brandon sanderson.
fans_names(F) :- fan(F,G), author(brandon_sanderson,H), member(A,H), member(A,G).

% 6. Find all novels that are common between either of phoebe, ross and monica.
mutual_novels(A) :-
    fan(phoebe,P),fan(ross,R), member(A,P), member(A,R);
    fan(phoebe,P),fan(monica,M), member(A,P), member(A,M);
    fan(ross,R),fan(monica,M), member(A,R), member(A,M).


/******************************* PART 2 **************************************/
% myappend( [ ] , L, L).
% myappend( [X | L1], L2, [X|L3]):-
%	myappend(L1, L2, L3).

% can't use member, function, intersection, everything else is fair game
% define isMember


% define isUnion
% define isIntersection
% define isEqual
% define powerSet


/******************************* PART 3 **************************************/

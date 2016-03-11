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

% switch sides
opposite(right,left).
opposite(left,right).

% state definitions
state(left,left,left,left).
state(left,left,left,right).
state(left,left,right,left).
state(left,left,right,right).
state(left,right,left,left).
state(left,right,left,right).
state(left,right,right,left).
state(left,right,right,right).
state(right,left,left,left).
state(right,left,left,right).
state(right,left,right,left).
state(right,left,right,right).
state(right,right,left,left).
state(right,right,left,right).
state(right,right,right,left).
state(right,right,right,right).

% the wolf is left with the goat -- FARMER SCREWED UP
unsafe(state(left,right,right,_)).
unsafe(state(right,left,left,_)).

% the goat is left with the cabbage -- FARMER SCREWED UP
unsafe(state(left,_,right,right)).
unsafe(state(right,_,left,left)).

% safe definition
safe(A):- \+ unsafe(A).

take(farmer,left,right).
take(farmer,right,left).
take(wolf,left,right).
take(wolf,right,left).
take(goat,left,right).
take(goat,right,left).
take(cabbage,left,right).
take(cabbage,right,left).

% defining the valid moves, based on Prolog slides
arc(take(wolf,Side1,Side2),state(Side1,Side1,G,C),state(Side2,Side2,G,C)):-
    opposite(Side1,Side2),safe(state(Side2,Side2,G,C)).

arc(take(goat,Side1,Side2),state(Side1,W,Side1,C),state(Side2,W,Side2,C)):-
    opposite(Side1,Side2),safe(state(Side2,W,Side2,C)).
    
arc(take(cabbage,Side1,Side2),state(Side1,W,G,Side1),state(Side2,W,G,Side2)):-
    opposite(Side1,Side2),safe(state(Side2,W,G,Side2)).

arc(take(none,Side1,Side2),state(Side1,W,G,C),state(Side2,W,G,C)):-
    opposite(Side1,Side2),safe(state(Side2,W,G,C)).
    
% ACTUALLY DOIN THE PUZZLE NOW %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% base case means the states are the same, and we dont care about the path
go(A,A,_,[]):- !.

% need to define go recursively
go(A,B,Path,[M|Moves]):-
    % move the things between the banks
    arc(M,A,A1),
    \+ member(A1,Path),
    go(A1,B,[A|Path],Moves).
    
% RUNNING THE PROGRAM TO TEST IT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
solve :-
    go(state(left, left, left, left), state(right, right, right, right), [], M),
    helperWrite(M),!.
    
helperWrite([H|[]]):-  write(H).
helperWrite([H|T]):- write(H), nl, helperWrite(T).

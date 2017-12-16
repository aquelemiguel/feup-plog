:- use_module(library(lists)).
:- use_module(library(sets)).

% participant(Id, Age, Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

% performance(Id, Times)
performance(1234, [120,120,120,120]).
performance(3423, [32,120,45,120]).
performance(3788, [110,2,6,43]).
performance(4865, [120,120,110,120]).
performance(8937, [97,101,105,110]).

/* Exercise #1 */
madeItThrough(Participant) :-
	performance(Participant, TimeList),
	member(120, TimeList).

/* Exercise #2 */
juriTimes([H|T], JuriMember, Times, Total) :-
	performance(H, TimeList),
	nth1(JuriMember, TimeList, TimeStamp),
	juriTimes(T, JuriMember, AccTimes, AccTotal),

	append([TimeStamp], AccTimes, Times),
	Total is AccTotal + TimeStamp.

juriTimes([], _, [], 0).

/* Exercise #3 */
:- dynamic abstention/1.

patientJuri(JuriMember) :-
	assertz(abstention(0)),

	performance(_, TimeList),
	nth1(JuriMember, TimeList, TimeStamp),
	TimeStamp = 120,

	abstention(Count), NewCount is Count + 1,
	retract(abstention(_)),
	assertz(abstention(NewCount)), fail.

patientJuri(_) :-
	abstention(Count), Count >= 2.

/* Exercise #4 */
bestParticipant(P1, P2, P) :-
	performance(P1, TimeList1),
	performance(P2, TimeList2),

	sumlist(TimeList1, Total1),
	sumlist(TimeList2, Total2),

	((Total1 > Total2, P is P1);
	 (Total1 < Total2, P is P2);
	 (Total1 = Total2, fail)).

/* Exercise #5 */
allPerfs :-
	performance(Participant, TimeList),
	participant(Participant, _, Performance),

	write(Participant), write(':'), write(Performance), write(':'), write(TimeList), nl, fail.

allPerfs.

/* Exercise #6 */
nSuccessfulParticipants(T) :-
	setof(Id, (performance(Id, TimeList), check_if_no_click(TimeList)), SuccessList),
	length(SuccessList, T).

check_if_no_click(TimeList) :-
	member(120, TimeList),
	remove_dups(TimeList, PrunedList),
	length(PrunedList, 1).

/* Exercise #7 */

/* Exercise #8 */
eligibleOutcome(Id, Perf, TT) :-
	performance(Id, Times),
	madeItThrough(Id),
    participant(Id, _, Perf),
    sumlist(Times, TT).

/* Exercise #10 */
impoe(X, L) :-
	length(Mid, X),
	append(L1, [X|_], L),
	append(_, [X|Mid], L1).
	
/* Flight Structure:
   flight(origin, arrival, time_depart, time_arrive, date, airline, flight_number, cost)
*/
/* Check which locations connect to each other */
hasflight(X,Y) :- flight(X,Y,_,_,_,_,_,_).
hasflight(X,Y,A) :- flight(X,Y,_,_,_,A,_,_).
hasflight(X,Y,A,C) :- flight(X,Y,_,_,_,A,_,C).

/*Basic Route*/
route(From, To, Travel) :- route(From, To, Travel, []).
route(From, To, [From | [To]], _) :- hasflight(From, To).
route(From, To, [From | Rest], Visited) :-
    len(Visited, X), X<3,
    not(inlist(To, Visited)), not(inlist(From, Visited)),
    hasflight(From, Next), route(Next, To, Rest, [From | Visited]).

/*Route with Airline*/
aroute(From, To, Airline, Travel) :- aroute(From, To, Airline, Travel, []).
aroute(From, To, Airline, [From | [To]], _) :- hasflight(From, To, Airline).
aroute(From, To, Airline, [From | Rest], Visited) :-
    len(Visited, X), X<3,
    not(inlist(To, Visited)), not(inlist(From, Visited)),
    hasflight(From, Next, Airline), aroute(Next, To, Airline, Rest, [From | Visited]).

/*Route with Airline & Cost*/
croute(From, To, Airline, Travel, Cost) :- croute(From, To, Airline, Travel, [], Cost).
croute(From, To, Airline, [From | [To]], _, Cost) :- hasflight(From, To, Airline, Cost).
croute(From, To, Airline, [From | Rest], Visited, Cost) :-
    len(Visited, X), X<3,
    not(inlist(To, Visited)), not(inlist(From, Visited)),
    hasflight(From, Next, Airline, CX), croute(Next, To, Airline, Rest, [From | Visited], CY),
    Cost is CX+CY.

/*Route with Airline, Cost & Distance*/
droute(From, To, Airline, Travel, Cost, Distance) :- droute(From, To, Airline, Travel, [], Cost, Distance).
droute(From, To, Airline, [From | [To]], _, Cost, 2) :- hasflight(From, To, Airline, Cost).
droute(From, To, Airline, [From | Rest], Visited, Cost, D) :-
    len(Visited, X), X<3,
    not(inlist(To, Visited)), not(inlist(From, Visited)),
    hasflight(From, Next, Airline, CX), droute(Next, To, Airline, Rest, [From | Visited], CY, DX),
    Cost is CX+CY, D is DX+1.

/*Route with Airline & Cost, Passing Through Given Locations*/
/*proute(From, Places, Airline, Travel, Cost) :- proute(From, Places, Airline, Travel, [], Cost).
proute(From, [To|[]], Airline, [From | [To]], Cost) :- hasflight(From, To, Airline, Cost).*/
proute(From, [To|[]], Airline, Route, Cost) :- croute(From, To, Airline, Route, Cost).
proute(From, [Next | Left], Airline, Travel, Cost) :-
    croute(From, Next, Airline, FRoute, CX),
    proute(Next, Left, Airline, [_|RRoute], CY),
    append(FRoute, RRoute, Travel),
    Cost is CX+CY.

/*List Routes by Cost*/
listcroutes(From, To, Airline, Routes) :- setof(C-R, croute(From, To, Airline, R, C), Routes).

/*List Routes by Distance*/
listdroutes(From, To, Airline, Routes) :- setof(D-C-R, droute(From, To, Airline, R, C, D), Routes).

/*Cheapest Route*/
cheapestroute(From, To, Airline, Route, Cost) :- setof(C-Airline-R, croute(From, To, Airline, R, C), [Cost-Airline-Route|_]).

/*Shortest Route*/
shortestroute(From, To, Airline, Route, Cost, Distance) :- setof(D-C-Airline-R, droute(From, To, Airline, R, C, D), [Distance-Cost-Airline-Route|_]).

/*Extra Stuff*/
inlist(X,[X|_]).
inlist(X,[_|T]) :- inlist(X,T).

len([],0).
len([_|T],X) :- len(T,Y), X is Y+1.
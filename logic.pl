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

/*Route, Stay in Particular Airline*
route(From, To, Airline, Travel) :- route(From, To, Airline, Travel, []).
route(From, To, Airline, [From | [To]], _) :- hasflight(From, To, Airline).
route(From, To, Airline, [From | Rest], Visited) :-
    len(Visited, X), X<3,
    not(inlist(To, Visited)), not(inlist(From, Visited)),
    hasflight(From, Next, Airline), route(Next, To, Airline, Rest, [From | Visited]).
*/

/*Route, Cheapest*/
route(From, To, Airline, Travel, Cost) :- route(From, To, Airline, Travel, [], Cost).
route(From, To, Airline, [From | [To]], _, Cost) :- hasflight(From, To, Airline, Cost).
route(From, To, Airline, [From | Rest], Visited, Cost) :-
    len(Visited, X), X<3,
    not(inlist(To, Visited)), not(inlist(From, Visited)),
    hasflight(From, Next, Airline, CX), route(Next, To, Airline, Rest, [From | Visited], CY),
    Cost is CX+CY.

listroutes(From, To, Airline, Routes) :- setof(C-R, route(From, To, Airline, R, C), Routes).

cheapestroute(From, To, Airline, Route, Cost) :- setof(C-Airline-R, route(From, To, Airline, R, C), [Cost-Airline-Route|_]).

/*shortestroute(From, To, Flight).*/

/*Extra Stuff*/
inlist(X,[X|_]).
inlist(X,[_|T]) :- inlist(X,T).

len([],0).
len([_|T],X) :- len(T,Y), X is Y+1.
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

/*List Routes by Cost*/
listroutes(From, To, Airline, Routes) :- setof(C-R, croute(From, To, Airline, R, C), Routes).

/*Show Cheapest Route*/
cheapestroute(From, To, Airline, Route, Cost) :- setof(C-Airline-R, croute(From, To, Airline, R, C), [Cost-Airline-Route|_]).

/*shortestroute(From, To, Flight).*/

/*Extra Stuff*/
inlist(X,[X|_]).
inlist(X,[_|T]) :- inlist(X,T).

len([],0).
len([_|T],X) :- len(T,Y), X is Y+1.
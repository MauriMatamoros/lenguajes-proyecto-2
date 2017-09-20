/* Flight Structure:
   flight(origin, arrival, time_depart, time_arrive, date, airline, flight_number, cost)
*/
/* Check which locations connect to each other */
hasflight(X,Y) :- flight(X,Y,_,_,_,_,_,_).
hasflight(X,Y,A) :- flight(X,Y,_,_,_,A,_,_).

/*Basic Route*/
route(From, To, Travel) :- route(From, To, Travel, []).
route(From, To, [From | [To]], _) :- hasflight(From, To).
route(From, To, [From | Rest], Visited) :-
    len(Visited, X), X<3,
    not(inlist(To, Visited)), not(inlist(From, Visited)),
    hasflight(From, Next), route(Next, To, Rest, [From | Visited]).

/*Route, Stay in Particular Airline*/
route(From, To, Airline, Travel) :- route(From, To, Airline, Travel, []).
route(From, To, Airline, [From | [To]], _) :- hasflight(From, To, Airline).
route(From, To, Airline, [From | Rest], Visited) :-
    len(Visited, X), X<3,
    not(inlist(To, Visited)), not(inlist(From, Visited)),
    hasflight(From, Next, Airline), route(Next, To, Airline, Rest, [From | Visited]).

/*TODO
cheapestTrip(From,To,Flight).
shortestTrip(From,To,Flight).
*/

/*Extra Stuff*/
inlist(X,[X|_]).
inlist(X,[_|T]) :- inlist(X,T).

len([],0).
len([_|T],X) :- len(T,Y), X is Y+1.
/* Flight Structure:
   flight(origin, arrival, time_leave, time_arrival, date, airline, flight_number, cost)
*/
/* Check which locations connect to each other */
hasflight(X,Y) :- flight(X,Y,_,_,_,_,_,_).
hasflight(X,Y,A) :- flight(X,Y,_,_,_,A,_,_).

/*Basic Route*/
route(From, To, [From | [To]]) :- hasflight(From, To).
route(From, To, [From | Rest]) :- inlist(From, Rest), hasflight(From, Next), route(Next, To, Rest).

/*Route, Stay in Particular Airline*/
route(From, To, Airline, [From | [To]]) :- hasflight(From, To, Airline).
route(From, To, Airline, [From | Rest]) :- hasflight(From, Next, Airline), route(Next, To, Airline, Rest).

cheapestTrip(From,To,Flight).
shortestTrip(From,To,Flight).

/*Extra Stuff*/
inlist(X,[X|_]).
inlist(X,[_|T]) :- inlist(X,T).
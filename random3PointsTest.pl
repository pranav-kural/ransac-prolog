
% methods to read point cloud
:- [ransac_file].

% This predicate should be true if Point3 is a triplet of points randomly selected from the list of points Points. The triplet of points is of the form [[x1,y1,z1], [x2,y2,z2], [x3,y3,z3]]
random3Points(Points, Point3) :-
    % if Point3 is in valid format
    (validPoint3Format(Point3) -> 
        random3PointsAux(Points, Point3) ; % recursive call
        false). % if invalid format

% Auxilary predicate for random3Points
random3PointsAux(_, []). % base case
random3PointsAux(Points, [P1 | Ps]) :-
    (P1 = [] -> true;
    (member(P1, Points) -> random3PointsAux(Points, Ps) ; false)).

% check if list Point3 is in a valid format of form [[x1,y1,z1], [x2,y2,z2], [x3,y3,z3]]
validPoint3Format(Point3) :-
    (Point3 \= []), length(Point3, 3), (Point3 = [[_,_,_],[_,_,_],[_,_,_]]).

% test randm3Points with multiple points
testRandomPoints :-
    write('Tesing random'), nl,
    read_xyz_file('data/Point_Cloud_1_No_Road_Reduced.xyz', Points),
    write('Point Cloud loaded. Size : '), length(Points, L), 
    write(L), nl,
    write('Testing for points not in point cloud 1: '), nl,
    pointsList1(Point1),
    write('Points: '), write(Point1), nl,
    write('Result: '), printResult(Points, Point1), nl,
    write('Testing for points present in point cloud 1: '), nl,
    pointsList2(Point2),
    write('Points: '), write(Point2), nl,
    write('Result: '), printResult(Points, Point2), nl,
    write('Testing for invalid format: '), nl,
    invalidPointsList(Point3),
    write('Points: '), write(Point3), nl,
    write('Result: '), printResult(Points, Point3), nl,
    write('Testing for invalid format: '), nl,
    invalidPointsList2(Point4),
    write('Points: '), write(Point4), nl,
    write('Result: '), printResult(Points, Point4), nl,
    write('Testing completed for random3Points').

% print result of random3Points
printResult(Points, Point) :-
    (random3Points(Points, Point) -> write('Valid') ; write('Not a valid')), write(' point from Point Cloud.').

% Sample points
pointsList1([[1,2,33], [4,5,6], [7,8,9]]).
pointsList2([
      [-5.141415625, -4.020067234, 0.242623445], 
      [-5.232860424,	1.134599409, 0.394991503], 
      [1.523155561,	63.49471938, 0.043231924]]).
invalidPointsList([[1,2,33], [4,5,6], [7,8,9], [10,11,12]]).
invalidPointsList2([]).
%% aircraftWaypoints.m
% Julianna Evans
% 07.07.17

%% Code to create aircraft waypoints and propogate 

% NOTE: Added into pushbuttonBalloonAdd_gui.m button
%aircraft = rootEngine.CurrentScenario.Children.New('eAircraft', cell2mat(newRow(1))); %cell2mat(newRow(1)) is obj NAME

% IAgAircraft aircraft: Aircraft object
% Set route to great arc, method and altitude reference
aircraft.SetRouteType('ePropagatorGreatArc');
route = aircraft.Route;
route.Method = 'eDetermineTimeAccFromVel';
route.SetAltitudeRefType('eWayPtAltRefMSL');

%test data
NumWaypoints = 10;
wd_latitude = [33 34 35 35 36 37 38 39 39 40];
wd_longitude = [43 44 45 45 46 47 48 49 49 50];
wd_altitude = [10 20 30 40 50 60 70 80 90 100];
wd_speed = [3 4 3 3 3 4 5 6 5 6];


% Add first point
waypoint = route.Waypoints.Add();
waypoint.Latitude = cell2mat(newRow(2));
waypoint.Longitude = cell2mat(newRow(3));
waypoint.Altitude = 5;  % [km] TEST FOR NOW
waypoint.Speed = .1;    % [km/sec] TEST FOR NOW

% FOR LOOP: Create waypoints
for i=2:length(NumWaypoints)
    
    % Add waypoints by dynamically adding variables in loop
    % NOTE: not a recommended method, but the best way I've found so far 
    eval(sprintf('waypoint%d = route.Waypoints.Add();', i));
    sprintf('waypoint%d.Latitude = wd_latitude(i);',i);       %Obj lat 
    sprintf('waypoint%d.Longitude = wd_longitude(i);',i);     %Obj lon 
    sprintf('waypoint%d.Altitude = wd_altitude(i);',i);       %km
    sprintf('waypoint%d.Speed = wd_speed(i);',i);             %km/sec
    
end 

%Propagate the route
route.Propagate;

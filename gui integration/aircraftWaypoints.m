%% aircraftWaypoints.m
% Julianna Evans
% 07.07.17

%% Code to create aircraft waypoints and propogate 
% NOTE: As of 07.12.17, aircraft is created in pushbuttonBalloonAdd_gui.m
% and the waypoints are created using this file (aircraftWaypoints.m). In
% order for it to integrate with the balloon dynamics data, correct
% (lat,lon,alt) data needs to be parsed in. Test data below where an
% external script could be referenced. 


%test data (NEEDS TO BE BALLOON DYNAMICS DATA -- PUSH TO EXTERNAL FILE)
NumWaypoints = 10;
wd_latitude = [0 10 20 30 40 50 60 70 80 89];
wd_longitude = [0 5 10 5 10 5 10 5 10 5];
wd_altitude = [10 20 30 40 50 60 70 80 90 100];
wd_speed = [0.3 0.4 0.3 0.3 0.3 0.4 0.5 0.6 0.5 0.6];


%% Set Aircraft Route Method (and associated properties)
aircraft.SetRouteType('ePropagatorGreatArc');
route = aircraft.Route;
route.Method = 'eDetermineTimeAccFromVel';
route.SetAltitudeRefType('eWayPtAltRefMSL');

%% Add first waypoint 
% NOTE: first waypoint can't be included in the loop since user specifies
% launch lat and lon coordinates in GUI
waypoint = route.Waypoints.Add();
waypoint.Latitude = cell2mat(newRow(2));
waypoint.Longitude = cell2mat(newRow(3));
waypoint.Altitude = 5;  % [km] TEST FOR NOW
waypoint.Speed = .1;    % [km/sec] TEST FOR NOW

%% FOR LOOP: Create 2nd-end waypoints
for i=2:NumWaypoints
    
    % Add waypoints by dynamically adding variables in loop
    % NOTE: not a recommended method, but the best way I've found so far 
    eval(sprintf('waypoint%d = route.Waypoints.Add();', i));
    eval(sprintf('waypoint%d.Latitude = %d;',i,wd_latitude(i)))       %Obj lat CHANGEEEEE
    eval(sprintf('waypoint%d.Longitude = %d;',i,wd_longitude(i)))     %Obj lon CHANGEEEE
    eval(sprintf('waypoint%d.Altitude = %d;',i,wd_altitude(i)))       %km
    eval(sprintf('waypoint%d.Speed = %d;',i,wd_speed(i)))             %km/sec 
    
end 

%% Propagate the route
route.Propagate;

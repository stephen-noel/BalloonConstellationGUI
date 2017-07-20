%% aircraftWaypoints.m
% Julianna Evans
% 07.07.17

%% Code to create aircraft waypoints and propogate 
% NOTE: As of 07.12.17, aircraft is created in pushbuttonBalloonAdd_gui.m
% and the waypoints are created using this file (aircraftWaypoints.m). In
% order for it to integrate with the balloon dynamics data, correct
% (lat,lon,alt) data needs to be parsed in. Test data below where an
% external script could be referenced. 

% NOTE: As of 07.20.17, the inputs were changed to include the time and
% remove the speed variable. Still need to input actual data, so test data
% is used in the interim. 


%test data (NEEDS TO BE BALLOON DYNAMICS DATA)
NumWaypoints = 10;
wd_time = {'13 Jul 2017 00:00:00.000' '13 Jul 2017 00:00:10.000' '13 Jul 2017 00:20:00.000' '13 Jul 2017 00:30:00.000' '13 Jul 2017 00:40:00.000' '13 Jul 2017 00:50:00.000' '13 Jul 2017 01:00:00.000' '13 Jul 2017 10:10:00.000' '13 Jul 2017 01:20:00.000' '13 Jul 2017 01:30:00.000'};
wd_latitude = [30 40 50 60 70 80 70 60 50 40];
wd_longitude = [40 45 50 55 60 65 70 70 70 70];
wd_altitude = [10 20 30 40 50 60 70 80 90 100]; %from vertical trajectory stuff


%% Set Aircraft Route Method (and associated properties)
aircraft.SetRouteType('ePropagatorGreatArc');
route = aircraft.Route;
route.Method = 'eDetermineTimeAccFromVel';
route.SetAltitudeRefType('eWayPtAltRefMSL');

%% Add first waypoint 
% NOTE: first waypoint can't be included in the loop since user specifies
% launch lat and lon coordinates in GUI
waypoint = route.Waypoints.Add();
waypoint.Time = newRow(1);                  %probably need to use dropdown, select balloon from pg1
waypoint.Latitude = cell2mat(newRow(2));    %probably need to use dropdown, select balloon from pg1
waypoint.Longitude = cell2mat(newRow(3));   %probably need to use dropdown, select balloon from pg1
waypoint.Altitude = 5;                      % [km] SHOULD PROBABLY BE ZERO SINCE IT IS LAUNCHING


%% FOR LOOP: Create 2nd-end waypoints
for i=2:NumWaypoints
    
    % Add waypoints by dynamically adding variables in loop
    % NOTE: not a recommended method, but the best way I've found so far 
    eval(sprintf('waypoint%d = route.Waypoints.Add();', i));
    eval(sprintf('waypoint%d.Time = %s',i,cell2mat(wd_time(i))));
    eval(sprintf('waypoint%d.Latitude = %d;',i,wd_latitude(i)))       %Get from external pushed wind data
    eval(sprintf('waypoint%d.Longitude = %d;',i,wd_longitude(i)))     %Get from external pushed wind data
    eval(sprintf('waypoint%d.Altitude = %d;',i,wd_altitude(i)))       %km
    
end 

%% Propagate the route
route.Propagate;

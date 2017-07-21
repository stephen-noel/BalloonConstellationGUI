%% aircraftWaypoints.m
% Julianna Evans
% 07.07.17

%% Code to create aircraft waypoints and propogate 
% NOTE: As of 07.12.17, aircraft is created in pushbuttonBalloonAdd_gui.m
% and the waypoints are created using this file (aircraftWaypoints.m). In
% order for it to integrate with the balloon dynamics data, correct
% (lat,lon,alt) data needs to be parsed in. Test data below where an
% external script could be referenced. 

%function [] = aircraftWaypoints(selected_lat,selected_lon);

%% Global Variables

global rootEngine;
global selected_name;
global selected_lat;
global selected_lon;


%% test data (NEEDS TO BE BALLOON DYNAMICS DATA)
NumWaypoints = 10;
wd_time = {'13 Jul 2017 00:00:00.000' '13 Jul 2017 00:00:10.000' '13 Jul 2017 00:20:00.000' '13 Jul 2017 00:30:00.000' '13 Jul 2017 00:40:00.000' '13 Jul 2017 00:50:00.000' '13 Jul 2017 01:00:00.000' '13 Jul 2017 10:10:00.000' '13 Jul 2017 01:20:00.000' '13 Jul 2017 01:30:00.000'};
wd_latitude = [30 40 50 60 70 80 70 60 50 40];
wd_longitude = [40 45 50 55 60 65 70 70 70 70];
wd_altitude = [10 20 30 40 50 60 70 80 90 100]; %from vertical trajectory stuff
wd_speed = [4 5 6 5 6 5 4 5 6 7];

%% Set Aircraft Route Method (and associated properties)

aircraft = rootEngine.CurrentScenario.Children.New('eAircraft', selected_name); 
aircraft.SetRouteType('ePropagatorGreatArc');
route = aircraft.Route;
route.Method = 'eDetermineTimeAccFromVel';
route.SetAltitudeRefType('eWayPtAltRefMSL');

%% Add first waypoint 
% NOTE: first waypoint can't be included in the loop since user specifies
% launch lat and lon coordinates in GUI
waypoint = route.Waypoints.Add();
%waypoint.Time = newRow(1);                  %probably need to use dropdown, select balloon from pg1
waypoint.Latitude = selected_lat;            %probably need to use dropdown, select balloon from pg1
waypoint.Longitude = selected_lon;           %probably need to use dropdown, select balloon from pg1
waypoint.Altitude = 5;                       % [km] SHOULD PROBABLY BE ZERO SINCE IT IS AT LAUNCH
waypoint.Speed = 4;

%% FOR LOOP: Create 2nd-end waypoints
for i=2:NumWaypoints
    
    % Add waypoints by dynamically adding variables in loop
    % NOTE: not a recommended method, but the best way I've found so far 
    eval(sprintf('waypoint%d = route.Waypoints.Add();', i));
    %eval(sprintf('waypoint%d.Time = %s',i,cell2mat(wd_time(i))));
    eval(sprintf('waypoint%d.Latitude = %d;',i,wd_latitude(i)));       %Get from external pushed wind data
    eval(sprintf('waypoint%d.Longitude = %d;',i,wd_longitude(i)));     %Get from external pushed wind data
    eval(sprintf('waypoint%d.Altitude = %d;',i,wd_altitude(i)));       %km
    eval(sprintf('waypoint%d.Speed = %d;',i,wd_speed(i)));
    
end 

%% Propagate the route
route.Propagate;

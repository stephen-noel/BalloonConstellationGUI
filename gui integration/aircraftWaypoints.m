%% aircraftWaypoints.m
% Julianna Evans
% 07.07.17

%% Code to create aircraft waypoints and propogate 
% NOTE: Must include a second waypoint in order to be propogated.  

% NOTE: Added into pushbuttonBalloonAdd_gui.m button
%aircraft = rootEngine.CurrentScenario.Children.New('eAircraft', cell2mat(newRow(1))); %cell2mat(newRow(1)) is obj NAME

% Set Aircraft Propogation Method (GreatArc)
aircraft.SetRouteType('ePropagatorGreatArc');
route = aircraft.Route;
route.Method = 'eDetermineTimeAccFromVel';
route.SetAltitudeRefType('eWayPtAltRefMSL');

%from wind data (to be added later)
NumWaypoints = 10;      %needs to come from the wind data (ex. length of lat points)
wd_latitude = 1:10;     %needs to come from the wind data
wd_longitude = 1:10;    %needs to come from the wind data


% FOR LOOP: Create waypoints
for i=1:length(NumWaypoints)
    
    % Add waypoints by dynamically adding variables in loop
    % NOTE: not a recommended method, but the best way I've found so far 
    eval(sprintf('waypoint%d = route.Waypoints.Add();', i));
    eval(sprintf('waypoint%d.Latitude = wd_latitude(i);',i));  %Obj lat CHANGEEEEE
    eval(sprintf('waypoint%d.Longitude = wd_longitude(i);',i)); %Obj lon CHANGEEEE
    eval(sprintf('waypoint%d.Altitude = 5;',i));                    % km
    eval(sprintf('waypoint%d.Speed = 0.1;',i));                     % km/sec
    
end

% Propagate the route
route.Propagate;





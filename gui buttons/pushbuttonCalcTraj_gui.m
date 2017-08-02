%% pushbuttonCalcTraj_gui.m
% Julianna Evans
% 07.20.17

%% Global Variables
global rootEngine;
global selected_cells_traj;

global time_interval;

%global variable instantiation
time_interval = 1*60*60; %every hour


%% Select Balloon to Calculate Trajectory For, Get Associated Table Properties

% Retrieve the index of the selected cell in the table
selected_cells_row_traj = selected_cells_traj(1);

% Map retrieved cell index to a name (and corresponding lat,lon)
tableData = get(handles.balloonTableTraj, 'Data');
selected_name = cell2mat(tableData(selected_cells_row_traj,1));
launchLat = cell2mat(tableData(selected_cells_row_traj,2));
launchLon = cell2mat(tableData(selected_cells_row_traj,3));
launchTime = cell2mat(tableData(selected_cells_row_traj,4));

%% Instantiate Times and Elapsed Times
% converts the scenario start time to the date to be entered in NOAA retrieval
starttime_GUI = rootEngine.CurrentScenario.StartTime;
[NOAAstring] = STKstr2NOAAstr(starttime_GUI);

% Get elapsed time between scenario start and the balloon's inputted start time
[init_elapsedSecs] = Times2ElapsedSecs(starttime_GUI, launchTime);

% Get elapsed time between scenario start and 00z of the same day
[init_from00z] = str2sameday00z(starttime_GUI);

%time in seconds from 00z to the balloon's launch time
totalEpSec = init_elapsedSecs + init_from00z;

%% instantiate old values for loop (initializes as launch values)
oldTime = 0;            %elapsed time is zero seconds
oldAlt = 0;             %altitude is zero, balloon at ground-level
oldLat = launchLat;     %latitude at launch
oldLon = launchLon;     %longitude at launch

%Convert to new datetime string to put into table
[newDateSTR] = epSec2Time(init_elapsedSecs, starttime_GUI);

%store old values into first index of data arrays
data_time{1} = newDateSTR;
data_alt(1) = oldAlt;
data_lat(1) = oldLat;
data_lon(1) = oldLon;

%% Get u- and v- velocities for the launch timestep
% Call 'dataIndexing' to convert old time-pos values to NOAA indicies
[time_idx, alt_idx, lat_idx, lon_idx] = dataIndexing(oldTime, oldAlt, oldLat, oldLon);
% Call 'WindData' to set the starting u- and v- velocity for launch point
[uvelOLD, vvelOLD] = WindData(NOAAstring, time_idx, alt_idx, lat_idx, lon_idx);  


%time variable instantiation
epSec = time_interval;

%% FOR LOOP: 
for timestep = 2:20
%% get new lat/lon/alt values    

epvector(timestep) = epSec; %debugging

%Call 'convertWind' to get the new latitude and longitude points
[newLat, newLon] = convertWind(uvelOLD, vvelOLD, oldLat, oldLon);

%Call 'vertTraj' to get the new altitude point
[newAlt] = vertTraj(epSec); 

%Call 'epSec2Time' to get the new time string
[newDateSTR] = epSec2Time(time_interval, newDateSTR);

%Export values (newTime, newAlt, newLat, newLon) into arrays
data_lat(timestep) = newLat(end);
data_lon(timestep) = newLon(end);
data_alt(timestep) = newAlt(end);
data_time{timestep} = cellstr(newDateSTR);

data_uvel(timestep) = uvelOLD;
data_vvel(timestep) = vvelOLD;

%% calculate wind velocities based on current data for next step 
%(create updated "old" variables by setting to current variables)

%Call 'dataIndexing' to index all values
[time_idx, alt_idx, lat_idx, lon_idx] = dataIndexing(epSec, newAlt, newLat, newLon);

% Call 'windData' with new values to get the new u- and v- velocities
[newUvel, newVvel] = WindData(NOAAstring, time_idx, alt_idx, lat_idx, lon_idx);

uvelOLD = newUvel;
vvelOLD = newVvel;

%Increase EpSec iteration by one interval
epSec = epSec + time_interval;


end


%% Get values of textboxes and set into balloon object

% Get edit-text-box values from GUI using object handles
balloon_float_alt = str2num(get(handles.editFloatAlt,'String'));
balloon_float_dur = str2num(get(handles.editFloatDur,'String'));
balloon_mol_weight = str2num(get(handles.editOtherBalloon,'String'));

% Assign GUI handle values into the balloon object
balloon.FloatAlt = balloon_float_alt;
balloon.FloatDur = balloon_float_dur;

% Get value of balloon gas popup

%{
switch get(handles.popupmenuGasList,'Value')  
    case '1'
        %nothing, "--select--" default chosen
    case '2'
        %gas is helium
        balloon.MolWeight = 4.003; %[g/mol]
    case '3'
        %gas is hydrogen
        balloon.MolWeight = 2.016; %[g/mol]
    case '4'
        %gas is other, get value from textbox
        balloon.MolWeight = balloon_mol_weight;
    otherwise
        warndlg('Not a valid gas selection.');
end
%}    

%% ---------------Propagate Aircraft Waypoints for Trajectory-----------------------
% Code to create aircraft waypoints and propogate 

%% Semi test data (Correct Lat/Lon stuff, alt is zero, time is correct)
wd_latitude = data_lat;
wd_longitude = data_lon;
wd_altitude = data_alt;
wd_time = data_time;

NumWaypoints = length(wd_latitude);

%% Set Aircraft Route Method (and associated properties)
aircraft = rootEngine.CurrentScenario.Children.New('eAircraft', selected_name); 
aircraft.SetRouteType('ePropagatorGreatArc');
route = aircraft.Route;
route.Method = 'eDetermineVelFromTime';
route.SetAltitudeRefType('eWayPtAltRefMSL');

%% Add first waypoint 
% NOTE: first waypoint can't be included in the loop since user specifies
% launch lat and lon coordinates in GUI
waypoint = route.Waypoints.Add();
waypoint.Time = launchTime;             %should be a string in STK format
waypoint.Latitude = launchLat;          %probably need to use dropdown, select balloon from pg1
waypoint.Longitude = launchLon;         %probably need to use dropdown, select balloon from pg1
waypoint.Altitude = 0;                  % [km] SHOULD PROBABLY BE ZERO SINCE IT IS AT LAUNCH

%% FOR LOOP: Create 2nd-end waypoints
for i=2:NumWaypoints
    
    % Add waypoints by dynamically adding variables in loop
    % NOTE: not a recommended method, but the best way I've found so far 
    eval(sprintf('waypoint%d = route.Waypoints.Add();', i));
    eval(sprintf('waypoint%d.Time = ''%s'' ',i,str2mat(wd_time{i})));
    eval(sprintf('waypoint%d.Latitude = %d;',i,wd_latitude(i)));       %Get from external pushed wind data
    eval(sprintf('waypoint%d.Longitude = %d;',i,wd_longitude(i)));     %Get from external pushed wind data
    eval(sprintf('waypoint%d.Altitude = %d;',i,wd_altitude(i)));       %km
    
end 

%% Propagate the route
route.Propagate;

%% Code here for the Excel stuff ....

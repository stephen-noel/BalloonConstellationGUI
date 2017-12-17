%% pushbuttonCalcTraj_gui.m
% Julianna Evans
% 12.16.17

%% Initialization
global rootEngine;
global selected_cells_traj;
global STKtimestep;
global STKstarttime;
global STKstoptime; 

[NOAAstring] = STKstr2NOAAstr(STKstarttime);

setup_nctoolbox;

%% Launch Balloon Data
% Retrieve the index of the selected cell in the table
selected_cells_row_traj = selected_cells_traj(1);

% Map retrieved cell index to a name (and corresponding lat,lon)
tableData = get(handles.balloonTableTraj, 'Data');
selected_name = cell2mat(tableData(selected_cells_row_traj,1));
launchLat = cell2mat(tableData(selected_cells_row_traj,2));
launchLon = cell2mat(tableData(selected_cells_row_traj,3));
launchTime = cell2mat(tableData(selected_cells_row_traj,4));

%% Time Stuff

% Get elapsed time between scenario start and the balloon's inputted launch time
[init_elapsedSecs] = Times2ElapsedSecs(STKstarttime, launchTime);

% Get elapsed time between scenario start and 00z of the same day
[init_from00z] = str2sameday00z(STKstarttime);

%time in seconds from 00z to the balloon's launch time (INDEXING PURPOSES)
initEpSec = init_elapsedSecs + init_from00z;

%get number of timesteps from STKstopttime
[timestepNum] = times2timestepNum(launchTime, STKstoptime, STKtimestep); 

%Initialize 'epSec' (used in loop)
epSec = STKtimestep;
newDateSTR = launchTime;
data_time{1} = launchTime;
data_alt(1) = 0;
data_lat(1) = launchLat;
data_lon(1) = launchLon;

%% Initial values for Lat/Lon
oldTime = 0;            %elapsed time is zero seconds
oldAlt = 0;             %altitude is zero, balloon at ground-level
oldLat = launchLat;     %latitude at launch
oldLon = launchLon;     %longitude at launch

%% Get u/v velocity at launch
% Call 'dataIndexing' to convert old time-pos values to NOAA indicies
[time_idx, alt_idx, lat_idx, lon_idx] = dataIndexing(initEpSec, oldAlt, oldLat, oldLon);

% Call 'WindData' to set the starting u- and v- velocity for launch point
[uvelOLD, vvelOLD] = WindData(NOAAstring, time_idx, alt_idx, lat_idx, lon_idx); 

for timestep = 2:timestepNum
%% Get new lat/lon/alt values    
%Call 'convertWind' to get the new latitude and longitude points
[newLat, newLon] = convertWind(uvelOLD, vvelOLD, oldLat, oldLon);
%Call 'vertTraj' to get the new altitude point
[newAlt] = vertTraj(epSec); 
%Call 'epSec2Time' to get the new time string
[newDateSTR] = epSec2Time(STKtimestep, newDateSTR);


%% Get new u/v velocities and set as old
% Call 'dataIndexing' to convert old time-pos values to NOAA indicies
[time_idx, alt_idx, lat_idx, lon_idx] = dataIndexing(initEpSec, oldAlt, oldLat, oldLon);

% Call 'WindData' to set the starting u- and v- velocity for launch point
[uvelOLD, vvelOLD] = WindData(NOAAstring, time_idx, alt_idx, lat_idx, lon_idx); 

%% Store values and increase epSec
data_lat(timestep) = newLat;
data_lon(timestep) = newLon;
data_alt(timestep) = newAlt;
data_time{timestep} = cellstr(newDateSTR);

data_uvel(timestep) = uvelOLD;
data_vvel(timestep) = vvelOLD;

epSec = epSec + STKtimestep;
oldLat = newLat;
oldLon = newLon;

%store debugging stuff
uvelOLDstore(timestep) = uvelOLD;
vvelOLDstore(timestep) = vvelOLD;

testval = 1;

end


%% Get values of textboxes and set into balloon object
% Get edit-text-box values from GUI using object handles
balloon_float_alt = str2num(get(handles.editFloatAlt,'String'));
balloon_float_dur = str2num(get(handles.editFloatDur,'String'));
balloon_mol_weight = str2num(get(handles.editOtherBalloon,'String'));

% Assign GUI handle values into the balloon object
balloon.FloatAlt = balloon_float_alt;
balloon.FloatDur = balloon_float_dur;

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

%% ------ Code for exporting data to excel --------

%position data
alt_array = transpose(data_alt);
lat_array = transpose(data_lat);
lon_array = transpose(data_lon);
time_array = transpose(data_time);

%reformat time data to excel-supported format
time_array = string(time_array);

%Table
T = table(time_array, alt_array, lat_array, lon_array);

%Write filename from user input and file extension
filenameFromUser = get(handles.editFilename,'String');
filename = strcat(filenameFromUser,'.xlsx');
col_header={'Elapsed Time [s]','Altitude [m]','Latitude [deg]','Longitude [deg]','','','','','','',''};

%Use writetable to write table
writetable(T,filename,'Sheet',1);
winopen(filename);

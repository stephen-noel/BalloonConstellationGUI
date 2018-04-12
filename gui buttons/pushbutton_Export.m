%% pushbutton_Export.m
% Author: Julianna Evans
% Date: 02.17.2018
% Last Revision: 04.01.18

% This script is attached to the "Calculate and Export" button.
% Calculates the balloon trajectory and exports time/position data to an excel file.

%% Initialization
global rootEngine;
global STKtimestep;
global STKstarttime;
global STKstoptime; 

global fullname;

[NOAAstring] = STKstr2NOAAstr(STKstarttime);

%get filename from user (uses Callbacks from 'pushbuttonBrowseXLSX' and 'pushbuttonImport')
longfilename = fullname;
[num,txt,raw] = xlsread(longfilename);

%% Assign balloons to balloonObj class def

%get dimensions of excel sheet
[nrows,ncols] = size(raw);
index = nrows;         %this is the number of objects + 1 (the header)

%Assign balloon objects using the 'balloonObj.m' script and get data from "raw" cell structure
for j = 1:index
balloon(j) = balloonObj;
balloon(j).Name = cellstr(raw(j,1));        %get balloon names and convert to string type
balloon(j).LaunchTime = cellstr(raw(j,2));  %get balloon launch times and convert to string type
balloon(j).LaunchLat = cell2mat(raw(j,3));  %get balloon launch latitudes and convert to number
balloon(j).LaunchLon = cell2mat(raw(j,4));  %get balloon launch longitudes and convert to number
balloon(j).LaunchAlt = cell2mat(raw(j,5));  %get balloon launch altitudes and convert to number
balloon(j).FOV = cell2mat(raw(j,6));        %get balloon FOV values and convert to number
end

%% Time Stuff
for i = 2:index

%% Initial Time Analysis    
% Get elapsed time between scenario start and the balloon's inputted launch time
[init_elapsedSecs(i)] = Times2ElapsedSecs(STKstarttime, balloon(i).LaunchTime);     

% Get elapsed time between scenario start and 00z of the same day
[init_from00z] = str2sameday00z(STKstarttime);

%time in seconds from 00z to the balloon's launch time (INDEXING PURPOSES)
initEpSec(i) = init_elapsedSecs(i) + init_from00z;

%get number of timesteps from STKstopttime
[timestepNum(i)] = times2timestepNum(balloon(i).LaunchTime, STKstoptime, STKtimestep); 



%% Initialize data matrix and store first step
epSec = STKtimestep;                             %Initialize 'epSec' (used in loop)
newDateSTRpre = char(balloon(i).LaunchTime);        %used in epSec2Time function
newDateSTR = newDateSTRpre(1:end-1);
data{1,1,i} = balloon(i).LaunchTime;
data{1,2,i} = balloon(i).LaunchLat;
data{1,3,i} = balloon(i).LaunchLon;
data{1,4,i} = balloon(i).LaunchAlt;

%Initial values for Lat/Lon
oldTime = 0;                        %elapsed time is zero seconds
oldAlt = 0;                         %altitude is zero, balloon at ground-level
oldLat = balloon(i).LaunchLat;      %latitude at launch
oldLon = balloon(i).LaunchLon;      %longitude at launch

%% Get u/v velocity at launch

%%% Call 'dataIndexing' to convert old time-pos values to NOAA indicies
%%[idx_time, idx_alt, idx_lat, idx_lon] = dataIndexing(initEpSec(i), oldAlt, oldLat, oldLon);
%%% Call 'WindData' to set the starting u- and v- velocity for launch point
%%[uvelOLD, vvelOLD] = WindData(NOAAstring, idx_time, idx_alt, idx_lat, idx_lon); 

% Call SCRIPT to get u- and v- velocities from datasubset


%% Loop for Timestep iteration (to create rows 2:end)
for timestep = 2:timestepNum(i)   

%% Get new lat/lon/alt values    
%Call 'convertWind' to get the new latitude and longitude points
[newLat, newLon] = convertWind(uvelOLD, vvelOLD, oldLat, oldLon);
%Call 'vertTraj' to get the new altitude point
[newAlt] = vertTraj(epSec); 
%Call 'epSec2Time' to get the new time string
[newDateSTR] = epSec2Time(STKtimestep, newDateSTR);

%% Get new u/v velocities and set as old
% Call 'dataIndexing' to convert old time-pos values to NOAA indicies
[idx_time, idx_alt, idx_lat, idx_lon] = dataIndexing(initEpSec(i), oldAlt, oldLat, oldLon);

% Call 'WindData' to set the next (old) u- and v- velocity
[uvelOLD, vvelOLD] = WindData(NOAAstring, idx_time, idx_alt, idx_lat, idx_lon); 

%% Store values into data matrix and increase epSec
data{timestep,1,i} = cellstr(newDateSTR);
data{timestep,2,i} = newLat(end);
data{timestep,3,i} = newLon(end);
data{timestep,4,i} = newAlt(end);

data{timestep,5,i} = uvelOLD;
data{timestep,6,i} = vvelOLD;

epSec = epSec + STKtimestep;        %increase epSec count
oldLat = newLat;                    %update Lat 
oldLon = newLon;                    %update Lon

%store debugging stuff
uvelOLDstore(timestep) = uvelOLD;
vvelOLDstore(timestep) = vvelOLD;

end

testval = 1;
end

%% ---------------Propagate Aircraft Waypoints for Trajectory-----------------------
% Code to create aircraft waypoints and propogate using STK method

%% Data from 3D data object

for i = 2:index

%initialize data (vector of values for the specific balloon object at index i)
wd_latitude = cell2mat(data(:,2,i));

%find length of non-NAN variables
nonNANlength = length(wd_latitude(~isnan(wd_latitude))); %%--- don't remember what this is
NumWaypoints = nonNANlength;
%NumWaypoints = size(data,1); %get first dimension of the data matrix

%% Set Aircraft Route Method (and associated properties)
aircraft = rootEngine.CurrentScenario.Children.New('eAircraft', string(raw(i,1))); 
aircraft.SetRouteType('ePropagatorGreatArc');
route = aircraft.Route;
route.Method = 'eDetermineVelFromTime';
route.SetAltitudeRefType('eWayPtAltRefMSL');


%% Add first waypoint 
% NOTE: first waypoint isn't included in the loop since user specifies
% launch lat and lon coordinates in GUI
waypoint = route.Waypoints.Add();
timetempvar = char(string(data(1,1,i)));
waypoint.Time = timetempvar(1:end-1);              %should be a string in STK format
waypoint.Latitude = str2mat(string(data(1,2,i)));          % [deg]
waypoint.Longitude = str2mat(string(data(1,3,i)));         % [deg]
waypoint.Altitude = 0;          % [km] SHOULD PROBABLY BE ZERO SINCE IT IS AT LAUNCH

%% FOR LOOP: Create 2nd-end waypoints
for wpt=2:NumWaypoints

    % Add waypoints by dynamically adding variables in loop
    % NOTE: not a MATLAB-recommended method, but the best way I've found so far 
    eval(sprintf('waypoint%d = route.Waypoints.Add();', wpt));
    eval(sprintf('waypoint%d.Time = ''%s'' ',wpt,char(string(data(wpt,1,i)))));
    eval(sprintf('waypoint%d.Latitude = %d;',wpt,cell2mat(data(wpt,2,i))));       %Get from external pushed wind data
    eval(sprintf('waypoint%d.Longitude = %d;',wpt,cell2mat(data(wpt,3,i))));     %Get from external pushed wind data
    eval(sprintf('waypoint%d.Altitude = %d;',wpt,cell2mat(data(wpt,4,i))));       %km

end 

%% Propagate the route
route.Propagate;

end
testval = 1;

%% ------ Code for exporting data to excel --------

for i = 2:index

%get NumWaypoints for the sheet i
wd_latitude = cell2mat(data(:,2,i));
nonNANlength = length(wd_latitude(~isnan(wd_latitude))); %%--- don't remember what this is
NumWaypoints = nonNANlength;    
    
    
%set up the column arrays
time = string(data(1:NumWaypoints,1,i));
latitude = data(1:NumWaypoints,2,i);
longitude = data(1:NumWaypoints,3,i);
altitude = data(1:NumWaypoints,4,i);
u_velocity = data(1:NumWaypoints,5,i);
v_velocity = data(1:NumWaypoints,6,i);
    
%Table    
T = table(time, latitude, longitude, altitude, u_velocity, v_velocity);

%Write filename from user input and file extension
filenameFromUser = get(handles.editTRAJfilename,'String');
filename = strcat(filenameFromUser,'.xlsx');
%filename = 'testoutput.xls';
col_header={'Time [s]','Latitude [m]','Longitude [deg]','Altitude [deg]','u-velocity [m/s]','v-velocity [m/s]','','','','','','',''};

%Use writetable to write table
writetable(T,filename,'Sheet',i);

end

winopen(filename);
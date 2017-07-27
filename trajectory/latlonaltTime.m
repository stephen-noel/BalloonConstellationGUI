%% latlonaltTime.m
% Julianna Evans
% 07.24.17

% Calls all of the wind stuff and puts all of the outputs (lat,lon and alt
% vectors as functions of time) into a matrix.

% Runs as sub-code to pushbuttonCalcTraj_gui.m (latlonaltTime.m is not a
% function)

%% Global variables
%global rootEngine;
global selected_lat;
global selected_lon;
global starttime_GUI;

global launchLat;
global launchLon;

%% Set up Nctoolbox here (instead of in WindData in the loop)
%Add nctoolbox to the path
setup_nctoolbox;


%% Get initial values (global variables from pushbuttonCalcTraj.m script)

launchLat = selected_lat;
launchLon = selected_lon;

%% Function calls
% Call 'guiWindInputs'
% NOTE: converts the scenario start time to the date to be entered in NOAA retrieval
[NOAAstring] = convertGUItime(starttime_GUI);
epSec = 0;

%instantiate old values for loop (initializes as launch values)
oldTime = epSec;        %no time has elapsed at launch
oldAlt = 0;             %altitude is zero, balloon at ground-level
oldLat = launchLat;     %latitude at launch
oldLon = launchLon;     %longitude at launch

%store old values into first index of data arrays
data_time(1) = epSec;
data_alt(1) = oldAlt;
data_lat(1) = oldLat;
data_lon(1) = oldLon;

% Call 'dataIndexing' to convert old time-pos values to NOAA indicies
[time_idx, alt_idx, lat_idx, lon_idx] = dataIndexing(oldTime, oldAlt, oldLat, oldLon);

% Call 'WindData' to set the starting u- and v- velocity for launch point
[uvelOLD, vvelOLD] = WindData(NOAAstring, time_idx, alt_idx, lat_idx, lon_idx);  

% FOR LOOP: create 
for timestep = 2:10

%Increase EpSec iteration by one second
epSec = epSec + 1;
    
%Call 'convertWind' to get the new latitude and longitude points
[newLat, newLon] = convertWind(timestep, uvelOLD, vvelOLD, oldLat, oldLon);

%Call 'vertTraj' to get the new altitude point
[newAlt] = vertTraj(timestep); 

%Export values (newTime, newAlt, newLat, newLon) into arrays
data_lat(timestep) = newLat(end);
data_lon(timestep) = newLon(end);
data_alt(timestep) = newAlt(end);
data_time(timestep) = epSec;

%% calculate wind velocities based on current data for next step 
%(create updated "old" variables by setting to current variables)

%Call 'dataIndexing' to index all values
[time_idx, alt_idx, lat_idx, lon_idx] = dataIndexing(epSec, newAlt, newLat, newLon);

% Call 'windData' with new values to get the new u- and v- velocities
[newUvel, newVvel] = WindData(NOAAstring, time_idx, alt_idx, lat_idx, lon_idx);
newUvel = uvelOLD;
newVvel = vvelOLD;

% -- Debugging -- display certain values
disp(timestep);
disp(data_lat);
disp(data_lon);
disp(data_alt);
disp(data_time);

disp(newLat);
disp(newLon);
disp(newAlt);


end

    

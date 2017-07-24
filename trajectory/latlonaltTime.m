%% latlonArray.m
% Julianna Evans
% 07.24.17

% Calls all of the wind stuff and puts all of the outputs (lat,lon and alt
% vectors as functions of time) into a matrix.

%% Global variables
global rootEngine;
global selected_lat;
global selected_lon;
global starttime_GUI;

global launchLat;
global launchLon;


%% Get initial values (global variables from pushbuttonCalcTraj.m script)

launchLat = selected_lat;
launchLon = selected_lon;

%% Function calls
% Call 'guiWindInputs'
[NOAAstring] = convertGUItime(starttime_GUI);

% Call 'WindData'
[uvel, vvel] = WindData(NOAAstring, launchLat, launchLon);

%Call 'convertWind'
[newLat, newLon] = convertWind(uvel, vvel, launchLat, launchLon);

%% Data matrix formatting

% ...

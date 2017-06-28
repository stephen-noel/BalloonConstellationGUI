%balloonGUI_init
% Julianna Evans
% 06.22.17

%% Initialization for Balloon GUI
% This script initializes any Balloon GUI object settings that must be
% changed before utilizing the GUI. Runs through GUI opening function
% (balloonGUI_OpeningFcn).

% Add folder paths
addpath('gui buttons');
addpath('flight area');
addpath('trajectory');
addpath('initialize');

% Set Balloon Table to have empty rows and three columns (name, lat, lon)
emptyTable = cell(0,3);
oldData = set(handles.balloonTable,'Data',emptyTable);
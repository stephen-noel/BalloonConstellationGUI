%balloonGUI_init
% Julianna Evans
% 06.22.17

%% Initialization for Balloon GUI
% NOTE: This script initializes any Balloon GUI object settings that must be
% changed before utilizing the GUI. Runs through GUI opening function
% (balloonGUI_OpeningFcn).

% Add folder paths
addpath('Atmosphere');
addpath('conversions');
addpath('CSVformat');
addpath('gui buttons');
addpath('initialize');
addpath('Numerical Int');
addpath('trajectory');


% Set Balloon Table on Constellation page to have empty rows and three columns (name, lat, lon)
emptyTable = cell(0,3);
oldData = set(handles.balloonTable,'Data',emptyTable);

% Set Balloon Table on Trajectory page to have empty rows and three columns (name, lat, lon)
emptyTable = cell(0,3);
oldDataTraj = set(handles.balloonTableTraj,'Data',emptyTable);

%Set default radio button for the "Custom"/"Default" group on Tab 2
set(handles.uibuttongroup1,'selectedobject',handles.radiobuttonDefault)

%% Set up Nctoolbox, Add to path
setup_nctoolbox;



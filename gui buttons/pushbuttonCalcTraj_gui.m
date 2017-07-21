%% pushbuttonCalcTraj_gui.m
% Julianna Evans
% 07.20.17

%% Global Variables

global rootEngine;
global selected_cells_traj;

global selected_name;
global selected_lat;
global selected_lon;


%% Select Balloon to Calculate Trajectory For

% Retrieve the index of the selected cell in the table
selected_cells_row_traj = selected_cells_traj(1);

% Map retrieved cell index to a name (and corresponding lat,lon)
tableData = get(handles.balloonTableTraj, 'Data');
selected_name = cell2mat(tableData(selected_cells_row_traj,1));
selected_lat = cell2mat(tableData(selected_cells_row_traj,2));
selected_lon = cell2mat(tableData(selected_cells_row_traj,3));


%% Get GUI string inputs
starttime_GUI = rootEngine.CurrentScenario.StartTime;
launchlat_GUI = selected_lat;
launchlon_GUI = selected_lon;

[NOAAstring, launchLat, launchLon] = guiWindInputs(starttime_GUI, launchlat_GUI, launchlon_GUI);


%% Calculate Trajectory

% Load the "aircraftWaypoints.m" file, which adds aircraft objects to the scenario
aircraftWaypoints;

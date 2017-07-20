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
selected_cells_col_traj = selected_cells_traj(2);

% Map retrieved cell index to a name
tableData = get(handles.balloonTableTraj, 'Data');
selected_name = tableData(selected_cells_row_traj,1);
selected_lat = cell2mat(tableData(selected_cells_row_traj,2));
selected_lon = cell2mat(tableData(selected_cells_row_traj,3));

%% Get GUI string inputs (need to move this to another section)
starttime_GUI = rootEngine.CurrentScenario.StartTime;
disp(starttime_GUI);

launchlat_GUI = selected_lat;
launchlon_GUI = selected_lon;

[NOAAstring, launchLat, launchLon] = guiWindInputs(starttime_GUI, launchlat_GUI, launchlon_GUI);



%% Calculate Trajectory
aircraftWaypoints;



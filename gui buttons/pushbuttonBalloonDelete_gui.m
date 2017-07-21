%% pushbuttonBalloonDelete_gui
% Julianna Evans
% 06.23.17

%% Global Variables

global rootEngine;
global selected_cells;


%% Retrieve the index of the selected cell, Constellation Table
selected_cells_row = selected_cells(1);
selected_cells_col = selected_cells(2);


%% Map retrieved cell index to a name
% Constellation Table
tableData = get(handles.balloonTable, 'Data');
selected_name = tableData(selected_cells_row,1);

% Trajectory Table
tableData_traj = get(handles.balloonTableTraj,'Data');
selected_name = tableData(selected_cells_row,1);


%% Delete the STK Aircraft Object
% Delete the STK object that matches the selected name
balloonToDelete = cell2mat(selected_name);
rootEngine.CurrentScenario.Children.Unload('eAircraft',balloonToDelete);

rootEngine.CurrentScenario.Children.Unload('eFacility',balloonToDelete);    %remove facility placeholder object

%% Delete table rows based on selected row index
% NOTE: can delete the row by clicking on any column in the row

% Constellation Table
tableData([selected_cells_row],:) = [];
set(handles.balloonTable, 'Data', tableData);

% Trajectory Table
tableData_traj([selected_cells_row],:) = [];
set(handles.balloonTableTraj,'Data',tableData_traj);


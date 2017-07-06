%% pushbuttonBalloonDelete_gui
% Julianna Evans
% 06.23.17

%% Global Variables
global selected_cells;
global rootEngine;

%% Code assigned to the 'pushbuttonBalloonDelete' pushbutton in the GUI

% Retrieve the index of the selected cell in the table
selected_cells_row = selected_cells(1);
selected_cells_col = selected_cells(2);

% Map retrieved cell index to a name
tableData = get(handles.balloonTable, 'Data');
selected_name = tableData(selected_cells_row,1);

% Delete the STK object that matches the selected name
balloonToDelete = cell2mat(selected_name);
rootEngine.CurrentScenario.Children.Unload('eFacility',balloonToDelete);

% Delete table row based on selected row index
% NOTE: can delete the row by clicking on any column in the row
tableData([selected_cells_row],:) = [];
set(handles.balloonTable, 'Data', tableData);

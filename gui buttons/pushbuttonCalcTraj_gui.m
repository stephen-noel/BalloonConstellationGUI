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


%% Get GUI string inputs (****will be inputs for guiWindInputs function****)
starttime_GUI = rootEngine.CurrentScenario.StartTime;
launchlat_GUI = selected_lat;
launchlon_GUI = selected_lon;

%[NOAAstring, launchLat, launchLon] = guiWindInputs(starttime_GUI, launchlat_GUI, launchlon_GUI);

%call wind data stuff here (???)

%% Get values of textboxes and set into balloon object

% Get edit-text-box values from GUI using object handles
balloon_float_alt = str2num(get(handles.editFloatAlt,'String'));
balloon_float_dur = str2num(get(handles.editFloatDur,'String'));
balloon_mol_weight = str2num(get(handles.editOtherBalloon,'String'));

% Assign GUI handle values into the balloon object
balloon.FloatAlt = balloon_float_alt;
balloon.FloatDur = balloon_float_dur;

% Get value of balloon gas popup

%{
switch get(handles.popupmenuGasList,'Value')  
    case '1'
        %nothing, "--select--" default chosen
    case '2'
        %gas is helium
        balloon.MolWeight = 4.003; %[g/mol]
    case '3'
        %gas is hydrogen
        balloon.MolWeight = 2.016; %[g/mol]
    case '4'
        %gas is other, get value from textbox
        balloon.MolWeight = balloon_mol_weight;
    otherwise
        warndlg('Not a valid gas selection.');
end
%}    

%% Calculate Trajectory

% Load the "aircraftWaypoints.m" file, which adds aircraft objects to the scenario
aircraftWaypoints;

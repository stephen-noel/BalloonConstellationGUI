%% Convert GUI inputs into MATLAB-readable form
% Julianna Evans
% 07.18.17

%% Global Variables
global rootEngine;

%% Function
function [NOAAstring, launchLat, launchLon] = guiWindInputs(starttime_GUI, launchlat_GUI, launchlon_GUI)
%INPUTS: GUI user-input (as strings)
%OUTPUTS: MATLAB variables

%% Get GUI string inputs
starttime_GUI = rootEngine.CurrentScenario.StartTime;
launchlat_GUI = str2num(get(handles.editBalloonLat,'String'));  %type: double
launchlon_GUI = str2num(get(handles.editBalloonLon,'String'));  %type: double

%% Convert Scenario starttime strings ('DD MMM YYYY HH:MM:SS.SSS') to NOAA form ('YYYYMMDD')
%get the day, month, and year using char values
day = sampleSTK(1:2);       %type: char
month = sampleSTK(4:6);     %type: char
year = sampleSTK(8:11);     %type: char

%Convert month from 3-char alphabetical string to a 2-digit numerical string
switch month
    case 'Jan'
        monthNUM = '01';
    case 'Feb'
        monthNUM = '02'; 
    case 'Mar'
        monthNUM = '03';
    case 'Apr'
        monthNUM = '04';
    case 'May'
        monthNUM = '05';
    case 'Jun'
        monthNUM = '06';        
    case 'Jul'
        monthNUM = '07';        
    case 'Aug'
        monthNUM = '08';        
    case 'Sep'
        monthNUM = '09';        
    case 'Oct'
        monthNUM = '10';        
    case 'Nov'
        monthNUM = '11';        
    case 'Dec'
        monthNUM = '12';        
    otherwise
        warndlg('Not valid month signification');
end
        
%NOAA formatted string
NOAAstring = strcat(year,monthNUM,day);

%% Convert lat/lon and set as outputs
launchLat = launchlat_GUI;
launchLon = launchlon_GUI;

end
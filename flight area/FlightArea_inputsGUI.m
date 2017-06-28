%% FlightArea_inputsGUI.m
% Julianna Evans
% 06.26.17

global rootEngine;

%% Handles assigned to the "Number of Balloons and Flight Area" section

% Get edit-text-box values using object handles
numBalloons = str2num(get(handles.editNumBalloons,'String'));
minLat = str2num(get(handles.editMinLat,'String'));
minLon = str2num(get(handles.editMinLon,'String'));
maxLat = str2num(get(handles.editMaxLat,'String'));
maxLon = str2num(get(handles.editMaxLon,'String'));


%% Coverage functions here...


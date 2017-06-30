%% FlightArea_inputsGUI.m
% Julianna Evans
% 06.26.17

global rootEngine;

%% Handles assigned to the "Number of Balloons and Flight Area" section


% Get edit-text-box values using object handles
nballoons = str2num(get(handles.editNumBalloons,'String'));

minLat = str2num(get(handles.editMinLat,'String'));
minLon = str2num(get(handles.editMinLon,'String'));
maxLat = str2num(get(handles.editMaxLat,'String'));
maxLon = str2num(get(handles.editMaxLon,'String'));

flen = str2num(get(handles.editLensFocalLength,'String'));
flenmult = str2num(get(handles.editFocalLengthMult,'String')); 
imgrat = str2num(get(handles.editImageRatio,'String'));

floatalt1 = str2num(get(handles.editFloatAlt1,'String'));
floatalt2 = str2num(get(handles.editFloatAlt2,'String'));

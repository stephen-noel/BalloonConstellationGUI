%% pushbuttonNUM_gui.m
% Julianna Evans
% 06.30.17

%% Code to run Number calculation

% Get inputs from GUI strings
FlightArea_inputsGUI;

% RUN: BalloonNumCalc.m
[BalloonNumforCalc] = BalloonNumCalc(flen,floatalt2,minLat,minLon,maxLat,maxLon);

% Set GUI handles to output answers
set(handles.editNumBalloonOutput,'String',num2str(BalloonNumforCalc));

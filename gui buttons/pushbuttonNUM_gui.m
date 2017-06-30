%% pushbuttonNUM_gui.m
% Julianna Evans
% 06.30.17

%% Code to run Number calculation

FlightArea_inputsGUI;

% BalloonNumCalc.m
[BalloonNumforCalc] = BalloonNumCalc(flen,floatalt2,minLat,minLon,maxLat,maxLon)

% Set GUI handles
set(handles.editNumBalloonOutput,'String',num2str(BalloonNumforCalc));

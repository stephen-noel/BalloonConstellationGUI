%% pushbuttonAREA_gui.m
% Julianna Evans
% 06.30.17

%% Code to run Area calculation

% Get inputs from GUI strings
FlightArea_inputsGUI;

% RUN: AreaCalc.m calculation
[totalXArea,totalYArea] = AreaCalc(flen,floatalt1,nballoons)

% Set GUI handles to output answers
set(handles.editLatCovg,'String',num2str(totalXArea));
set(handles.editLonCovg,'String',num2str(totalYArea));

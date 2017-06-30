%% pushbuttonAREA_gui.m
% Julianna Evans
% 06.30.17

%% Code to run Area calculation

FlightArea_inputsGUI;

% AreaCalc.m calculation
[totalXArea,totalYArea] = AreaCalc(flen,floatalt1,nballoons)

% Set GUI output handles
set(handles.editLatCovg,'String',num2str(totalXArea));
set(handles.editLonCovg,'String',num2str(totalYArea));

%% pushbutton_AddTarget.m
% Author: Julianna Evans
% Date: 08.04.17
% Last revision: 04.06.18

% This script is tied to the "Add Target" button on the main GUI. This
% fetches the min/max lat/lon data from the GUI and generates an AreaTarget
% object in the embedded STK scenario. 

%% Global variables

global rootEngine;
global minLat; global minLon; global maxLat; global maxLon; 

  
%Get handles from GUI edit-textboxes to store as inputs
minLat = str2num(get(handles.editGATminlat,'String'));
minLon = str2num(get(handles.editGATminlon,'String'));
maxLat = str2num(get(handles.editGATmaxlat,'String'));
maxLon = str2num(get(handles.editGATmaxlon,'String'));

%Code to add Area Target Object based on inputted Lat/Lon
%set up coordinates based on min/max and lat/lon coords
point1 = [maxLat minLon];
point2 = [maxLat maxLon];
point3 = [minLat maxLon];
point4 = [minLat minLon];

% Create the AreaTarget on the current scenario central body (Earth)
areaTarget = rootEngine.CurrentScenario.Children.New('eAreaTarget', 'MyAreaTargetRectangle');

% Draw AreaTarget Pattern using lat/lon coordinates
rootEngine.BeginUpdate(); %By using the fine grained interfaces, BeginUpdate/EndUpdate prevent intermediate redraws
areaTarget.AreaType = 'ePattern';
patterns = areaTarget.AreaTypeData;
patterns.Add(point1(1), point1(2));
patterns.Add(point2(1), point2(2));
patterns.Add(point3(1), point3(2));
patterns.Add(point4(1), point4(2));
rootEngine.EndUpdate();
areaTarget.AutoCentroid = true;
       
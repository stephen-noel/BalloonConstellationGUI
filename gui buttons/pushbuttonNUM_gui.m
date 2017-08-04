%% pushbuttonNUM_gui.m
% Julianna Evans
% 06.30.17

%% Code to run Number calculation

% Get inputs from GUI strings
global rootEngine;

%% Get handles from GUI edit-textboxes to store as inputs

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


%% RUN: BalloonNumCalc.m

%if "flen" variable is empty, then show warning dialog box to inform user
if isempty(flen) == 0
    warndlg('The variable "flen" is empty. Please enter a value in the textbox above.');
    flen = 50;
end

%if "flen" variable has a value, continue with the script
if isempty(flen) == 1
% run the function
[BalloonNumforCalc] = BalloonNumCalc(flen,floatalt2,minLat,minLon,maxLat,maxLon);

% Set GUI handles to output answers
set(handles.editNumBalloonOutput,'String',num2str(BalloonNumforCalc));

%% Code to add Area Target Object based on inputted Lat/Lon

%set up coordinates based on min/max and lat/lon coords
point1 = [maxLat minLon];
point2 = [maxLat maxLon];
point3 = [minLat maxLon];
point4 = [minLat minLon];

% Create the AreaTarget on the current scenario central body (Earth)
areaTarget = rootEngine.CurrentScenario.Children.New('eAreaTarget', 'MyAreaTarget');


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

end

%% getlocaldata.m
% Author: Julianna Evans
% Date: 04.01.18
% Last Revision: 04.01.18

% This script is used to get locally-stored wind data (*.mat) and set the
% handle for the data status textbox

global fullname2b;

%% Get and load the data object
[FileName,PathName] = uigetfile('*.mat','Select the mat obj code file');
fullname2 = [PathName FileName];
fullname2b = FileName;

load(fullname2b);

%% Set data status bar
set(handles.editDataStatus,'String','Data loaded');

%% Set Area Target Fields (based on data download input)

set(handles.editGATminlat,'String',ATdata{1,1});
set(handles.editGATminlon,'String',ATdata{2,1});
set(handles.editGATmaxlat,'String',ATdata{3,1});
set(handles.editGATmaxlon,'String',ATdata{4,1});

%% Set Computed Target Values
compMinLat = ATdata{1,1};
compMinLon = ATdata{2,1};
compMaxLat = ATdata{3,1};
compMaxLon = ATdata{4,1};

computedlat = (compMinLat+compMaxLat)/2;
computedlon = (compMinLon+compMaxLon)/2;

set(handles.editGATcomplat,'String',computedlat);
set(handles.editGATcomplon,'String',computedlon);

%% Set output to check if script is complete
disp('yeeeee')

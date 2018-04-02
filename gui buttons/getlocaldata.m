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
disp('yeeeee')

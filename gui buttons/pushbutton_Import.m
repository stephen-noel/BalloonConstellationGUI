%% pushbutton_Import.m
% Julianna Evans
% 02.17.2018

% This script will import balloon data using a user-specified filename

%% Initialization
global rootEngine;
global STKtimestep;
global STKstarttime;
global STKstoptime; 

[NOAAstring] = STKstr2NOAAstr(STKstarttime);
setup_nctoolbox;

%% Import Excel Data and Assign to 'balloonObj' Method
global fullname;

%get filename from user (uses Callbacks from 'pushbuttonBrowseXLSX' and 'pushbuttonImport')
longfilename = fullname;
[num,txt,raw] = xlsread(longfilename);


%test print
disp('done with import');
%% pushbutton_Import.m
% Author: Julianna Evans
% Date: 02.17.2018
% Last Revision: 04.01.18

% This script is tied to the "Import" pushbutton on the main GUI.
% Imports balloon data from a user-specified filename

%% Initialization
global rootEngine;
global STKtimestep;
global STKstarttime;
global STKstoptime; 

[NOAAstring] = STKstr2NOAAstr(STKstarttime);
%setup_nctoolbox; %not needed anymore

%% Import Excel Data and Assign to 'balloonObj' Method
global fullname;

%get filename from user (uses Callbacks from 'pushbuttonBrowseXLSX' and 'pushbuttonImport')
longfilename = fullname;
[num,txt,raw] = xlsread(longfilename);


%test print
disp('done with import');
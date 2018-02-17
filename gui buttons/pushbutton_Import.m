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

%get dimensions
[nrows,ncols] = size(raw);
index = nrows;         %this is the number of objects + 1 (the header)


%Assign balloon objects using the 'balloonObj.m' script and get data from "raw" cell structure
for j = 1:index
balloon(j) = balloonObj;
balloon(j).Name = cellstr(raw(j,1));        %get balloon names and convert to string type
balloon(j).LaunchTime = cellstr(raw(j,2));  %get balloon launch times and convert to string type
balloon(j).LaunchLat = cell2mat(raw(j,3));  %get balloon launch latitudes and convert to number
balloon(j).LaunchLon = cell2mat(raw(j,4));  %get balloon launch longitudes and convert to number
balloon(j).LaunchAlt = cell2mat(raw(j,5));  %get balloon launch altitudes and convert to number
balloon(j).FOV = cell2mat(raw(j,6));        %get balloon FOV values and convert to number
end

%% Time Stuff

for i = 1:index
% Get elapsed time between scenario start and the balloon's inputted launch time
[init_elapsedSecs(i)] = Times2ElapsedSecs(STKstarttime, launchTime(i));  
    
end

% Get elapsed time between scenario start and the balloon's inputted launch time
[init_elapsedSecs] = Times2ElapsedSecs(STKstarttime, launchTime);

% Get elapsed time between scenario start and 00z of the same day
[init_from00z] = str2sameday00z(STKstarttime);

%time in seconds from 00z to the balloon's launch time (INDEXING PURPOSES)
initEpSec = init_elapsedSecs + init_from00z;

%get number of timesteps from STKstopttime
[timestepNum] = times2timestepNum(launchTime, STKstoptime, STKtimestep); 

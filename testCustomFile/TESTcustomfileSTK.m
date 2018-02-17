%% STK Playground for adding a Custom File
% Julianna Evans
% 02.15.2018

% NOTE: Gets reference to running STK scenario (blank scenario must be
% manually opened before running this code). Creates aircraft object and
% propagates based on data arrays

%% Instantiate

% Get reference to running STK 64-bit instance
uiApplication = actxGetRunningServer('STK11.application');
%Get our IAgStkObjectRoot interface
root = uiApplication.Personality2;

%% Initialization
STKstarttime = '17 Feb 2018 16:00:00.000'; 
STKstoptime = '18 Feb 2018 16:00:00.000'; 
STKtimestep = 3600;

[NOAAstring] = STKstr2NOAAstr(STKstarttime);
setup_nctoolbox;

%% Import Excel Data and Assign to 'balloonObj' Method
filename = 'BalloonData_templateTEST';  %file has to be in the working folder
[num,txt,raw] = xlsread(filename);

%get dimensions
[nrows,ncols] = size(raw);
index = nrows;         %this is the number of objects + 1 (the header)


%Assign balloon objects using the 'balloonObj.m' script and get data from "raw" cell structure
for j = 1:index
balloon(j) = balloonObj;
balloon(j).Name = cellstr(raw(j,1));        %get balloon names and convert to string type
balloon(j).LaunchTime = cellstr(raw(j,2));  %get balloon launch times and convert to string type
balloon(j).LaunchAlt = cell2mat(raw(j,3));  %get balloon launch latitudes and convert to number
balloon(j).LaunchLat = cell2mat(raw(j,4));  %get balloon launch longitudes and convert to number
balloon(j).LaunchLon = cell2mat(raw(j,5));  %get balloon launch altitudes and convert to number
balloon(j).FOV = cell2mat(raw(j,6));        %get balloon FOV values and convert to number
end

%% Time Stuff

for i = 2:index

%% Initial Time Analysis    
% Get elapsed time between scenario start and the balloon's inputted launch time
[init_elapsedSecs(i)] = Times2ElapsedSecs(STKstarttime, balloon(i).LaunchTime);     

% Get elapsed time between scenario start and 00z of the same day
[init_from00z] = str2sameday00z(STKstarttime);

%time in seconds from 00z to the balloon's launch time (INDEXING PURPOSES)
initEpSec(i) = init_elapsedSecs(i) + init_from00z;

%get number of timesteps from STKstopttime
[timestepNum(i)] = times2timestepNum(balloon(i).LaunchTime, STKstoptime, STKtimestep); 



%% Initialize data matrix and store first step
epSec = STKtimestep;                             %Initialize 'epSec' (used in loop)
newDateSTRpre = char(balloon(i).LaunchTime);        %used in epSec2Time function
newDateSTR = newDateSTRpre(1:end-1);
data{1,1,i} = balloon(i).LaunchTime;
data{1,2,i} = balloon(i).LaunchAlt;
data{1,3,i} = balloon(i).LaunchLat;
data{1,4,i} = balloon(i).LaunchLon;

%Initial values for Lat/Lon
oldTime = 0;                        %elapsed time is zero seconds
oldAlt = 0;                         %altitude is zero, balloon at ground-level
oldLat = balloon(i).LaunchLat;      %latitude at launch
oldLon = balloon(i).LaunchLon;      %longitude at launch

%% Get u/v velocity at launch
% Call 'dataIndexing' to convert old time-pos values to NOAA indicies
[idx_time, idx_alt, idx_lat, idx_lon] = dataIndexing(initEpSec(i), oldAlt, oldLat, oldLon);

% Call 'WindData' to set the starting u- and v- velocity for launch point
[uvelOLD, vvelOLD] = WindData(NOAAstring, idx_time, idx_alt, idx_lat, idx_lon); 

%% Loop for Timestep iteration (to create rows 2:end)
for timestep = 2:timestepNum(i)   

%% Get new lat/lon/alt values    
%Call 'convertWind' to get the new latitude and longitude points
[newLat, newLon] = convertWind(uvelOLD, vvelOLD, oldLat, oldLon);
%Call 'vertTraj' to get the new altitude point
[newAlt] = vertTraj(epSec); 
%Call 'epSec2Time' to get the new time string
[newDateSTR] = epSec2Time(STKtimestep, newDateSTR);

%% Get new u/v velocities and set as old
% Call 'dataIndexing' to convert old time-pos values to NOAA indicies
[idx_time, idx_alt, idx_lat, idx_lon] = dataIndexing(initEpSec(i), oldAlt, oldLat, oldLon);

% Call 'WindData' to set the starting u- and v- velocity for launch point
[uvelOLD, vvelOLD] = WindData(NOAAstring, idx_time, idx_alt, idx_lat, idx_lon); 

%% Store values into data matrix and increase epSec
data{timestep,1,i} = cellstr(newDateSTR);
data{timestep,2,i} = newAlt(end);
data{timestep,3,i} = newLat(end);
data{timestep,4,i} = newLon(end);

data{timestep,5,i} = uvelOLD;
data{timestep,6,i} = vvelOLD;

epSec = epSec + STKtimestep;        %increase epSec count
oldLat = newLat;                    %update Lat 
oldLon = newLon;                    %update Lon

%store debugging stuff
uvelOLDstore(timestep) = uvelOLD;
vvelOLDstore(timestep) = vvelOLD;

testval = 1;






end
end

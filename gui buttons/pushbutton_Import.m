%% pushbutton_Import.m
% Julianna Evans
% 02.17.2018

% This script will import balloon data using a user-specified filename

%% Import Excel Data and Assign to 'balloonObj' Method
filename = 'BalloonData_template';  %file has to be in the working folder
[num,txt,raw] = xlsread(filename);

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

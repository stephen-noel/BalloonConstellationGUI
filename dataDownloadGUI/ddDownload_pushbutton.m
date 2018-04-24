%% ddDownload_pushbutton.m
% Author: Julianna Evans
% Date: 04.01.18
% Last Revision: 04.12.18

% This script executes upon the "Download" button being pushed in the sub-GUI

%% Global Values
global minLat1;
global maxLat1;
global minLon1;
global maxLon1;

%% Get the NOAA string value
ddNOAAstring = get(handles.ddNOAAstring,'String');

%% Access GrADS Data Server via URL
url = ['http://nomads.ncep.noaa.gov:9090/dods/gfs_0p25_1hr/gfs',ddNOAAstring,'/gfs_0p25_1hr_00z'];

%% Get the latitude and longitude bounds 
minLat1 = str2num(get(handles.ddMinLat,'String'));
minLon1 = str2num(get(handles.ddMinLon,'String'));
maxLat1 = str2num(get(handles.ddMaxLat,'String'));
maxLon1 = str2num(get(handles.ddMaxLon,'String'));

%get the indices of the lats and lons
epSec = 3600;newAlt = 30; %set as random defaults--we don't need these, we just want the lat/lon indices
[~, ~, minlat_idx, minlon_idx] = dataIndexing(epSec, newAlt, minLat1, minLon1);
[~, ~, maxlat_idx, maxlon_idx] = dataIndexing(epSec, newAlt, maxLat1, maxLon1);

%length of lat and lon vectors
latidx_length = maxlat_idx - minlat_idx;
lonidx_length = maxlon_idx - minlon_idx;

%% Get the wind data using 'ncread' method
% Loops through all of the time vectors and stores the data in cells since
% the server won't allow download of the actual 4D arrays.

%waitbar
wbar = waitbar(0,'Downloading...');

%download at each time index
for i = 1:121
uvelTIME{i} = ncread(url,'ugrdprs', [minlon_idx minlat_idx 1 i], [lonidx_length latidx_length 31 1]);
vvelTIME{i} = ncread(url,'vgrdprs', [minlon_idx minlat_idx 1 i], [lonidx_length latidx_length 31 1]);
size(uvelTIME)
waitbar(i/121);
waitbar(i/121,wbar,sprintf('Download percentage complete = %2.2f %',i/1.21))
end
delete(wbar);

%% Get AreaTarget information (put into the GUI display)
%Set the first column of ATdata to the min and max lat/lon data
ATdata{1,1} = minLat1;
ATdata{2,1} = minLon1;
ATdata{3,1} = maxLat1;
ATdata{4,1} = maxLon1;

%% Store the wind data and area target data into a (*.mat) object which will 
%% be loaded into the main GUI functions later
% NOTE: will use this in the trajectory calculation file for the main GUI
save('winddownload.mat','uvelTIME','vvelTIME','ATdata');

%% Set the strings on the GUI

%URL string
urlSTR = string(url);
set(handles.ddURL,'String',urlSTR);

%Set Last update
timeSTR = string(datetime(ddNOAAstring,'InputFormat','yyyyMMdd'));
hourSTR = ' at 00 hrs UTC';
finalSTR = strcat(timeSTR,hourSTR);

set(handles.ddNOAAupdate,'String',finalSTR);


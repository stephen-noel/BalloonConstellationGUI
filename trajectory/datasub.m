%% datasub.m
% Author: Julianna Evans
% Date: 04.07.18
% Last Revision: 04.12.18

% Converts old time-pos values to uvel and vvel values

function [uvelOLD, vvelOLD] = datasub(epSec, oldAlt, oldLat, oldLon,uvelTIME,vvelTIME)

global minLat; global minLon; global maxLat; global maxLon; 

%% Time indexing from the dataIndexing script
[time_idx, alt_idx, lat_idx, lon_idx] = dataIndexing(epSec, oldAlt, oldLat, oldLon);

%convert epSec to the proper time index
uvel_atEpSec = uvelTIME{time_idx};
vvel_atEpSec = vvelTIME{time_idx};


%% Get the values from the data subset
%get the values using lat/lon/alt indexing at the specified time-dependent
%cell array
uvelOLD = uvel_atEpSec(lon_idx,lat_idx,alt_idx);
vvelOLD = vvel_atEpSec(lon_idx,lat_idx,alt_idx);

end
%% dataIndexing.m
% Author: Julianna Evans and Siwani Regmi
% Data: 07.26.17
% Last Revision: 04.12.18

% Finds the indices of the dataset using the input time, alt, lat, and lon
% values

function [time_idx, alt_idx, lat_idx, lon_idx] = dataIndexing(epSec, newAlt, newLat, newLon)

%% Take epSec and put into terms of NOAA indexing
% The 'ugrdprs' and 'vgrdprs' datasets have a time index of 1:121 (0-120
% values) with a resolution of 0.041666668 days / 3600.00115 seconds.

%time index resolution
res_sec = 3600.00115; %[s]

%create vector of epSec per index (add 3600.00115 sec for each increased timestep)
for timeIndex = 2:121
epSecVec(timeIndex) = (timeIndex-1)*res_sec;
end

%get closest value and corresponding index
% NOTE: do this by subtracting the given value by all of the vector
% elements, get the index of the minimum value found, and then find the
% closest vector value using that index. 
amt_diff = abs(epSec - epSecVec);
[idx idx] = min(amt_diff);
%closestEpSecVal = epSecVec(idx);
time_idx = idx;


%% Take newAlt value and put into terms of NOAA indexing
% The 'ugrdprs' and 'vgrdprs' datasets have an altitude index of 1:31 (0-30
% values) with a resolution of 33.3 mbars. The data goes from a min
% pressure of 1000 mbar to max pressure of 1 mbar.

res_mbar = 33.3; % [mbar]

%change altitude at timestep into a pressure by calling 'pressurealt' script
[newPressure] = pressurealt(newAlt);

%create vector of pressure per index (add xxx mbar for each increased timestep)
for paltIndex = 2:31
pressureVec(paltIndex) = 1000-(paltIndex-1)*res_mbar;
end

%get closest value and corresponding index
% NOTE: do this by subtracting the given value by all of the vector
% elements, get the index of the minimum value found, and then find the
% closest vector value using that index. 

amt_diff = abs(newPressure - pressureVec);
[idx idx] = min(amt_diff);
pressure_idx = idx;

%NOAA dataset index
alt_idx = pressure_idx;


%% Get the datasubset indices for lat and lon
[lat_idx,lon_idx]= latlonSUBindex(newLat,newLon);

% Get indices of Area Target bounds
%[idx_AT_minlat,idx_AT_minlon]= latlonSUBindex(minLat,minLon);
%[idx_AT_maxlat,idx_AT_maxlon]= latlonSUBindex(maxLat,maxLon);

% Get indices of newLat and newLon
%[idx_newLat,idx_newLon] = latlonSUBindex(newLat,newLon);

%set lat/lon index relative to AT
%sub_idxnewLat = idx_newLat-idx_AT_minlat+1;
%sub_idxnewLon = idx_newLon-idx_AT_minlon+1;

%sub_idxnewLon = randi([1 12]);
%sub_idxnewLat = randi([1 8]);

%lat_idx = sub_idxnewLat;
%lon_idx = sub_idxnewLon;

end

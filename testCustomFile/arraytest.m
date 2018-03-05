
for n = 2:size(data,3)
%time and position data
time_array = char(string(data(:,1,n)));
lat_array = char(string(data(:,2,n)));
lon_array = char(string(data(:,3,n)));
alt_array = char(string(data(:,4,n)));
end
%% Test Matrix Data

%length of arrays
idx_end = 3*60*60; %3hrs in seconds

%separate time and position arrays
time_array = transpose(1:idx_end);
alt_array = 3*rand(length(time_array),1);
lat_array = 4*rand(length(time_array),1);
lon_array = 5*rand(length(time_array),1);

%test matrix
test_matrix = horzcat(time_array, alt_array, lat_array, lon_array);

%CSV writing method
csvwrite('csvlist.dat',test_matrix) 



%Get data into CSV format
csvwrite('csvlist.csv',test_matrix) %where test_matrix would be the matrix
type csvlist.csv

%open CSV as an excel file
open csvlist.csv

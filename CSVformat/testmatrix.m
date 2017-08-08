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

% STK string format: 'DD MMM YYYY HH:MM:SS'
% STK time will be GUI input

elasped_time = datetime('now') + seconds(1:10800); %%%%
time_column = elasped_time.';
time_column = transpose(elasped_time);
str = string(time_column);
%t = datetime(str,'InputFormat','dd-MMM-yyyy HH:mm:ss');



%CSV writing method
csvwrite('csvlist.dat',test_matrix) 

%get data into CSV format
csvwrite('csvlist.csv',test_matrix) %where test_matrix is matrix output by GUI
type csvlist.csv

%user input to save as an Excel filename of their choice

xlsFileName = 'CSV'; %the file will save as CSV.xls
xlswrite(xlsFileName,test_matrix,'Sheet1','B2');
xlswrite(xlsFileName,str,'Sheet1','A2');
col_header={'Elapsed Time [s]','Altitude [m]','Latitude [deg]','Longitude [deg]','','','','','','',''};
xlswrite('CSV.xls',col_header,'Sheet1'); %write column 1 header


%Automatically opens the excel file
winopen('CSV.xls');

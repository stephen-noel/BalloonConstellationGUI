%% Test Matrix Data


%% Matrix instantiation
%length of arrays
idx_end = 3*60; %3hrs in seconds
epSec = 10;
oldDateSTR = '02 Aug 2017 16:00:00.000';

%loop to create datetime strings 
for i = 1:idx_end;
[newDateSTR] = epSec2Time(epSec, oldDateSTR);
time_array{i} = newDateSTR;
oldDateSTR = newDateSTR;
end

%position arrays
alt_array = num2cell(3*rand(length(time_array),1));
lat_array = num2cell(4*rand(length(time_array),1));
lon_array = num2cell(5*rand(length(time_array),1));
time_array = transpose(time_array);

%test matrix
test_matrix = horzcat(time_array, alt_array, lat_array, lon_array);

%% CSV writing

%CSV writing method
csvwrite('csvlist.dat',test_matrix) 

%get data into CSV format
csvwrite('csvlist.csv',test_matrix) %where test_matrix is matrix output by GUI
type csvlist.csv

%user input to save as an Excel filename of their choice
xlsFileName = 'CSV'; %the file will save as CSV.xls
xlswrite(xlsFileName, test_matrix,'Sheet1','A2');
col_header={'Elapsed Time [s]','Altitude [m]','Latitude [deg]','Longitude [deg]','','','','','','',''};
xlswrite('CSV.xls',col_header,'Sheet1'); %write column 1 header



%Automatically opens the excel file
winopen('CSV.xls');

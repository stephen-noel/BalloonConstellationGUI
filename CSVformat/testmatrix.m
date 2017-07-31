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
%xlswrite('csvlist.dat',test_matrix,'Sheet1','A2'); %write data
%xlswrite('csvlist.dat',TimeVector,'Sheet1','B1'); %write column 1 header
%xlswrite('csvlist.dat',Column2,'Sheet1','A1'); %column 2 header
%xlswrite('csvlist.dat',Column3,'Sheet1','B1'); %column 3 header
%xlswrite('csvlist.dat',Column4,'Sheet1','C1'); %column 4 header

%get data into CSV format
csvwrite('csvlist.csv',test_matrix) %where m would be the matrix
type csvlist.csv

%user input to save as an Excel filename of their choice
y = [test_matrix]; %#ok<NBRAK>
xlsFileName = 'CSV';
xlswrite(xlsFileName, y);
col_header={'Time Vector','Column 1','Column 2','Column 3'};
xlswrite('CSV.xls',col_header,'Sheet1','A1'); %write column 1 header

%Automatically opens the excel file
winopen('CSV.xls');

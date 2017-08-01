%% STK2Datetime.m
% Julianna Evans
% 08.01.2017

%% Converts STK strings to MATLAB datetime variable

function [datetimeVAR] = STK2Datetime(stkSTR)

% STK string format: 'DD MMM YYYY HH:MM:SS.SSS'

%% Check if the STK datetime string has a 1-digit day or a 2-digit day
if length(stkSTR) == 23  %datetime string has 1 digit day
len = 23;
day = str2num(stkSTR(1));         %type: double
monthCHAR = stkSTR(3:5);          %type: char
year = str2num(stkSTR(7:10));     %type: double
hour = str2num(stkSTR(12:13));    %type: double
minute = str2num(stkSTR(15:16));  %type: double
second = str2num(stkSTR(18:23));  %type: double

elseif length(stkSTR) == 24 %datetime string has 1 digit day
len = 24;
day = str2num(stkSTR(1:2));       %type: double
monthCHAR = stkSTR(4:6);          %type: char
year = str2num(stkSTR(8:11));     %type: double
hour = str2num(stkSTR(13:14));    %type: double
minute = str2num(stkSTR(16:17));  %type: double
second = str2num(stkSTR(19:24));  %type: double

else
    warndlg('STK datetime string is not in a valid format.');
end

%% Convert month from 3-char alphabetical string to a 2-digit numerical string
switch monthCHAR
    case 'Jan'
        month = 1;
    case 'Feb'
        month = 2; 
    case 'Mar'
        month = 3;
    case 'Apr'
        month = 4;
    case 'May'
        month = 5;
    case 'Jun'
        month = 6;        
    case 'Jul'
        month = 7;        
    case 'Aug'
        month = 8;        
    case 'Sep'
        month = 9;        
    case 'Oct'
        month = 10;        
    case 'Nov'
        month = 11;        
    case 'Dec'
        month = 12;        
    otherwise
        warndlg('Check the scenario datetime for valid month signifier.');
end

datetimeVAR = datetime(year, month, day, hour, minute, second);

end
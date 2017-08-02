%% str2sameday00z.m
% Julianna Evans
% 08.01.17

function [elapsedSecs,sameday00z] = str2sameday00z(SCNstarttime)

%Get the same (day, month, year) as the scenario starttime 
%% Check if the STK datetime string has a 1-digit day or a 2-digit day
if length(SCNstarttime) == 23  %datetime string has 1 digit day
len = 23;
day = str2num(SCNstarttime(1));         %type: double
monthCHAR = SCNstarttime(3:5);          %type: char
year = str2num(SCNstarttime(7:10));     %type: double
hour = str2num(SCNstarttime(12:13));    %type: double
minute = str2num(SCNstarttime(15:16));  %type: double
second = str2num(SCNstarttime(18:23));  %type: double

elseif length(SCNstarttime) == 24 %datetime string has 1 digit day
len = 24;
day = str2num(SCNstarttime(1:2));       %type: double
monthCHAR = SCNstarttime(4:6);          %type: char
year = str2num(SCNstarttime(8:11));     %type: double
hour = str2num(SCNstarttime(13:14));    %type: double
minute = str2num(SCNstarttime(16:17));  %type: double
second = str2num(SCNstarttime(19:24));  %type: double

else
    warndlg('STK datetime string is not in a valid format.');
end

%Convert month from 3-char alphabetical string to a 2-digit numerical string
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


%set vectors
t1 = datetime(year, month, day, 0,0,0);
t2 = datetime(year, month, day, hour, minute, second);

t1_str = datestr(t1,'dd mmm yyyy HH:MM:SS.FFF');
t2_str = datestr(t2,'dd mmm yyyy HH:MM:SS.FFF');
sameday00z = t1_str;

%set timevectors using MATLAB's "datevec" function
t1 = datevec(t1_str,'dd mmm yyyy HH:MM:SS.FFF');
t2 = datevec(t2_str,'dd mmm yyyy HH:MM:SS.FFF');

%calculate elapsed time [s]
%NOTE: etime doesn't work with MATLAB's "datetime" function so we have to
%use "datevec", which has a slightly different format. 
elapsedSecs = etime(t2,t1);

end
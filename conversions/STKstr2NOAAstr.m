%% Convert GUI inputs into MATLAB-readable form
% Julianna Evans
% 07.18.17

function [NOAAstring] = STKstr2NOAAstr(starttime_GUI)
%INPUTS: GUI user-input (as strings)
%OUTPUTS: MATLAB variables

%% Convert Scenario starttime strings ('DD MMM YYYY HH:MM:SS.SSS') to NOAA form ('YYYYMMDD')

%Check if the STK datetime string has a 1-digit day or a 2-digit day
if length(starttime_GUI) == 23  %datetime string has 1 digit day
len = 23;
day = starttime_GUI(1);         %type: char
month = starttime_GUI(3:5);     %type: char
year = starttime_GUI(7:10);     %type: char

elseif length(starttime_GUI) == 24 %datetime string has 1 digit day
len = 24;
day = starttime_GUI(1:2);       %type: char
month = starttime_GUI(4:6);     %type: char
year = starttime_GUI(8:11);     %type: char

else
    warndlg('STK datetime string is not in a valid format.');
end

%Convert month from 3-char alphabetical string to a 2-digit numerical string
switch month
    case 'Jan'
        monthNUM = '01';
    case 'Feb'
        monthNUM = '02'; 
    case 'Mar'
        monthNUM = '03';
    case 'Apr'
        monthNUM = '04';
    case 'May'
        monthNUM = '05';
    case 'Jun'
        monthNUM = '06';        
    case 'Jul'
        monthNUM = '07';        
    case 'Aug'
        monthNUM = '08';        
    case 'Sep'
        monthNUM = '09';        
    case 'Oct'
        monthNUM = '10';        
    case 'Nov'
        monthNUM = '11';        
    case 'Dec'
        monthNUM = '12';        
    otherwise
        warndlg('Check the scenario datetime for valid month signifier.');
end
       

%Make sure that if the day only has 1 digit then the day also includes a zero in front of the value.
if len == 23
    day = num2str(day);
    day = strcat('0',day);
end


%NOAA formatted date string
NOAAstring = strcat(year,monthNUM,day);

end
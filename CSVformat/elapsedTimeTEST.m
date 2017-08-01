%% elapsedTimeTEST.m
% Datetime conversion TEST script

%% NOTE:
% STK reads datetime strings in the format 'DD MMM YYYY HH:MM:SS.SSS'

%% Calulate new time using a time interval
% In a for-loop, take in an initial time, add the elapsed time (in seconds)
% to the initial time, and update to a new time. Generate an array of
% STK-readable datetime strings. 

%NOTE: we want the end of the interval to be the loop start time plus 3
%days (or so). You'll probably have to convert the loop start, then add the
%time, then output the loop_end. 

loop_start = '01 Aug 2017 00:00:00.000';
epSec = 400;  %time interval (constant throughout loop)

% conversions from strings to matlab variables here

% calculate the loop_end
endInterval = ???

%for loop here
    % EXAMPLE:
    %for i = 1:epSec:endInterval
    %newtime(i) = oldtime(i) + epSec
    %convert/export matlab variable to STK-string, input into cell
    %end







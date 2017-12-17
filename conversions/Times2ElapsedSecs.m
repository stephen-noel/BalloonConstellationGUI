%% Times2ElapsedSecs.m
% Julianna Evans
% 07.31.17

% Converts time from the inputted STK datetime string to elapsed seconds
% from the scenario starttime

function [elapsedSecs] = Times2ElapsedSecs(SCNstarttime, BALLOONstarttime)

%set timevectors using MATLAB's "datevec" function
t1 = datevec(SCNstarttime,'dd mmm yyyy HH:MM:SS.FFF');
t2 = datevec(BALLOONstarttime,'dd mmm yyyy HH:MM:SS.FFF');

%calculate elapsed time [s]
%NOTE: etime doesn't work with MATLAB's "datetime" function so we have to
%use "datevec", which has a slightly different format. 
elapsedSecs = etime(t2,t1);

end
%% epSec2Time.m
% Julianna Evans
% 07.31.17

% Converts elapsed time from the launch time into a new datestring to be
% inputted into the data table

function [newDateSTR] = epSec2Time(epSec, oldDateSTR)

[t1] = STK2Datetime(oldDateSTR);

%Second timevector 
t2 = t1 + seconds(epSec);

% DATESTR: set new timevector using MATLAB's "datestr" function
%   dd --- day in 2 digits 
%   mmm -- month using first 3 letters
%   yyyy - year in full
%   HH --- hour in 2 digits 
%   MM --- minute in 2 digits
%   SS --- second in 2 digits
%   FFF -- millisecond in 3 digits
newDateSTR = datestr(t2,'dd mmm yyyy HH:MM:SS.FFF');

disp(t1);
disp(t2);

end
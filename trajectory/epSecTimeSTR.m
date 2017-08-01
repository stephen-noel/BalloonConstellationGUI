%% epSecTimeSTR.m
% Julianna Evans
% 07.31.17

% Converts elapsed time from the launch time into a new datestring to be
% inputted into the data table

function [newDateSTR,t2,t1] = epSecTimeSTR(epSec, oldDateSTR)

% DATETIME: set timevectors using MATLAB's "datetime" function
%   dd --- day of the month using 2 digits
%   MMM -- month, abbreviated name
%   yyyy - year
%   HH --- hour, 24h clock notation with 2 digits
%   mm --- minute, using 2 digits
%   ss --- second, using 2 digits
%   SSS -- fractional sections, 3 digits
t1 = datetime(oldDateSTR,'InputFormat','dd MMM yyyy HH:mm:ss.SSS');

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


end
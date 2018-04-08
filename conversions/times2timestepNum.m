%% times2timestepNum.m
% Author: Julianna Evans
% Date: 08.03.17
% Last Revision: 08.03.17

% Converts the number of timesteps to calculate, based on the balloon
% launch time, scenario end time, and the timestep.

function [timestepNum] = times2timestepNum(balloonLaunchTime, STKendTime, timestep) 

%Get total elapsed seconds between the two time strings
[totalEpsec] = Times2ElapsedSecs(balloonLaunchTime, STKendTime);

%Get the number of timesteps to run through
timestepNum = round(totalEpsec/timestep);

end
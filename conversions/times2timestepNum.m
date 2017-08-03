%% times2timestepNum.m
% Julianna Evans
% 08.03.17

function [timestepNum] = times2timestepNum(balloonLaunchTime, STKendTime, timestep) 

%Get total elapsed seconds between the two time strings
[totalEpsec] = Times2ElapsedSecs(balloonLaunchTime, STKendTime);

%Get the number of timesteps to run through
timestepNum = round(totalEpsec/timestep);

end
%% BalloonNumCalc
% Julianna Evans
% 06.29.17

% Calculate the number of cameras (balloons) required to cover designated
% area

function [NumBalloonsforXYArea] = BalloonNumCalc(xrange,yrange,minLat,minLon,maxLat,maxLon)
% NOTE: inputs and outputs are placeholders

totalXrange = maxLat - minLat;
totalYrange = maxLon - minLon;

numX = totalXrange/xrange;
numY = totalYrange/yrange;

if numX < numY
    NumBalloonsforXYArea = numX;
elseif numY > numX
    NumBalloonsforXYArea = numY;
end

end
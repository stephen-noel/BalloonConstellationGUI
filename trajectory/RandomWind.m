function [windspeed,winddirection] = RandomWind(z) 
%start at 3658m because that's where NOAA data stops, go up by 1000 and stop at ~65,000ft

for z = 3658:1000:19658
 windspeed = 100 + (200-100).*rand(1,1); %random speed 100 to 200
end

for z = 3658:1000:19658
 winddirection = 0 + (360-0).*rand(1,1); %random direction 0 to 360
end

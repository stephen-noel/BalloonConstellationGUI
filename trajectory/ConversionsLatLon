%turning HTML code into Matlab to convert m to deg for lat/long


function  [latlen,longlen] = ConversionsLatLong(deglat, deglong) %Compute lengths of degrees
     
     % USER INPUT: deglat ;   
     radlat = deglat*((2.0*pi)/360.0); %Converts degrees to radians
     
     % USER INPUT: deglong = 90; %I don't understand why this isn't a part of the calculations??????????
     radlong = deglong*((2.0*pi)/360.0); %Converts degrees to radians

		%Convert latitude to radians
        

		%Set up "Constants"
		m1 = 111132.92;		% latitude calculation term 1
		m2 = -559.82;		% latitude calculation term 2
		m3 = 1.175;			% latitude calculation term 3
		m4 = -0.0023;		% latitude calculation term 4
		p1 = 111412.84;		% longitude calculation term 1
		p2 = -93.5;			% longitude calculation term 2
		p3 = 0.118;			% longitude calculation term 3

		%Calculate the length of a degree of latitude and longitude in meters
		latlen = m1 + (m2 * cos(2 * radlat)) + (m3 * cos(4 * radlat)) + (m4 * cos(6 * radlat)); 
		longlen = (p1 * cos(radlat)) + (p2 * cos(3 * radlat)) +(p3 * cos(5 * radlat));
        display(latlen);
        display(longlen);
end

 

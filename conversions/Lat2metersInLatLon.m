%% calculates how many meters in 1 deg of lat/lon at the given latitude

function  [latlen,longlen] = Lat2metersInLatLon(deglat) %Compute lengths of degrees
     
     % USER INPUT: deglat ;   
     radlat = deglat*((1.0*pi)/180.0); %Converts degrees to radians
   
        
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
        
end

 

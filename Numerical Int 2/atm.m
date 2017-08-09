function [p,dTempK,RhoA] = atm(t,x,tempK)
    z = x(1);
    oldTempK = tempK;
    if (z <= 11000) %Meters (Troposhpere)
        temp = 15.04 - 0.00649*z; 
        tempK = temp + 273.15;
        p = 101.29*((temp+273.1)/(288.08))^5.256; %kPa
        
    elseif (z > 11000 && z < 25000) %Meters (Lower Stratosphere)
        temp = -56.46;
        tempK = temp + 273.15;
        p = 22.65*exp(1.73-0.000157*z); %kPa
        
    else %Upper Stratosphere
        temp = -131.21 + 0.00299*z; 
        tempK = temp + 273.15;
        p = 2.488 * ((temp+273.1)/216.6)^-11.388; %kPa
    end
    
    dTempK = abs(tempK - oldTempK);
    RhoA = (p/(.2869*tempK));  
end


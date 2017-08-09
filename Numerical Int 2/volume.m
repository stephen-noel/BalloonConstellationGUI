function dVol = volume(t,x,p,Wg,dTempK,RhoA,vol,dz,MW)
    dt = 1;
    dVol = (8.314/(p*MW))*((Wg*dTempK/dt)*dt + (RhoA/p)*(vol)*dz);

end

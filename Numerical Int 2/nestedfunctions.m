function xp = nestedfunctions(t,x,vol,tempK)
    
    [p,dTempK,RhoA] = atm(t,x,tempK);

    realCD = .4;
    cb = 0.55; % This is the apparent additional mass coefficient for balloons based on a study from UMich in 1995
    g = 9.81;
    r = 8.314; %This is the gas constant. Units are J/(K*mol). 
    MW = 4.0026;
    BMass = 12;
    PMass = 50;
    GVol = 4;
    p0 = 101.325;
    tempK0 = 288.15;
    n = 1000*p0*GVol/(r*tempK0); %moles
    Wg = MW*n/1000; % [kg]
    mass = PMass+BMass+Wg;
    radius = ((3/(4*pi))*vol)^(1/3);
    Ca = pi*radius^2;
    
    
    old_z = x(1);
   
    
    % x(1) is z, x(2) is velocity [z']
    xp = zeros(2,1);
    xp(1) = x(2);
    xp(2) = (g*(RhoA*vol-mass)-.5*RhoA*realCD*x(2)*abs(x(2))*Ca)/(mass+cb*RhoA*vol);
    
    z = x(1);
    dz = z - old_z;
    dVol = volume(t,x,p,Wg,dTempK,RhoA,vol,dz,MW);
    vol = vol + dVol;


end

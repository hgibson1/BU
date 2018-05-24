%   Jeremy Stark
%   August 2014
%   This code does things and stuff.
%   Mostly uses the Boren Huffman algorithm for calculating Mie extinction
%   coefficients, and plots specular reflection decay accordingly.

%   Code to calculate specular reflection from Dust Deposition Analyzer
%   (DDA) Data.  Lets call this the Dust Verification Data Analyzer code
%   (DVDA).  So the DVDA code needs two parameters in its current form,
%   mean particle diameter from the DDA data, and dust mass readings.  If
%   data from the Non-contact specular reflectometer is taken, also enter
%   it for this reading.  The DVDA code will calculate the SR decay curve
%   using Beer's Law, and the scattering and absorption coefficients using
%   the particle size data from the DDA scan.  It will then plot the decay
%   curve and using the mass reading and SR reading, plot the read SR point
%   to validate.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%                                 %%%%%%%%%%%%%%%%%%%%%%%%
%   Beer's Law - Relates the transmission of light through a medium is
%   proportional to the attenuation of the material and the path length
%   through the medium.  
%   Beer's Law general form - dI = -sigma * N * I * dx
%   Where I is intensity of light, sigma is particle cross section area, N
%   is the concentration of the medium, and dx is the layer.
%
%   In this form we are using a particle passing
%   through an assumed thin layer (dx) of sand of given concentration N,
%   and with scattering cross section ap.  Concentration is calculated by
%   the mass concentration of sand in the layer (mcm/mp)*dx, where mcm is
%   concentration of sand in g/m^3, mp is the mass of a given particle, and
%   dx as the layer of sand.  After solving for transmission this gives:
%%%%%%%%%%%%%%%%%%  I = exp(-mcm*ap*qext/mp)
%   Specular reflection is derived by adding a coefficient of 2 for each
%   reflection through the dust layer, and expanding the extinction
%   coefficient for the scattering.
%%%%%%%%%%%%%%%%%%  Rspec = exp(-2*mcm*ap*(qsca+qabs)/mp)

%   Once this has been validated and the kinks worked out with the DDA and
%   DVDA codes, this will be integrated into the overall code for the DDA
%   and tests will be ran to show the relationship of specular reflection
%   and dust mass concentration on different dust samples.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  Like this if you are a strong  %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  independent scientist who      %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  don't need no C programming    %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%  This is the part where you enter the mean particle diameter from
%%%%%%%%%  the DDA data
d=20e-6;                                    %   diameter of particle (m)
%%%%%%%%%  Seriously, right above this, but the number in meters

%%%%%%%%%  This is the part where you enter in the specular reflection
%%%%%%%%%  reading from the Non-Contact Specular Reflectometer
SR=71.6;                                    %   Specular Reflection (%)
%%%%%%%%%  SR, in percent, its not that hard.

%%%%%%%%%  This is the part where you enter in the mass reading of the
%%%%%%%%%  initially clean panel, and then another for the dust loaded
%%%%%%%%%  panel.  
mclean=115.175;                             %   Mass of clean plate (g)
mdirty=115.205;                             %   Mass of dirty plate (g)
%%%%%%%%%  Next is the panel area, leave this at 0.127m if a 5" plate is
%%%%%%%%%  still being used, otherwise, change it as appropriate.  This
%%%%%%%%%  value is used to calculate the mass concentration (mass/area).
platex=0.127;                               %   Size of plate (m)
dustarea=platex^2;                          %   Calculates area (m^2)


mcm=[0:.1:100];                             %   mass concentration from 0-100g/m^3
rho = 2.5e6;                                %   density of sand
wavelength=655e-9;                          %   wavelength of light
vp=(4/3)*pi*(d/2)^3;                        %   volume of particle
mp = rho*vp;                                %   mass of a single particle
ap = pi*(d/2)^2;                            %   cross-sectional area of particle
npar=1.5;                                   %   index of particle (sand)
nmed=1;                                     %   index of medium (air
m = npar/nmed;                              %   ratio of refractive indices
x = pi*d/(wavelength/nmed);                 %   ratio circumference/wavelength in medium

mies=mie(m,x);                              %   calling function to solve for mie parameters

%%%%%%%%%%%%%%  Assigning values from the BH mie code %%%%%%%%%%%%%%%%%%%%%

mreal = mies(1);                            %   Real component of index
mimag = mies(2);                            %   Imaginary index
xx = mies(3);                               %   size parameter 
qext = mies(4);                             %   extinction coeff.
qsca = mies(5);                             %   scattering coeff
qabs = mies(6);                             %   absorption coeff
qback = mies(7);                            %   backscattering
asym = mies(8);                             %   asymmetry param
qratio = mies(9);                           %   ratio back/sca

Itx=95.6*exp(-mcm*ap*(qext)/mp);            %   calculating transmission loss
figure
plot(mcm,Itx)                               %   plotting transmission loss
Rspec=95.6*exp(-2*mcm*ap*(qext)/mp);        %   calculating specular reflection
figure
plot(mcm,Rspec)                             %   plotting specular reflection
hold
dustmass1=(mdirty-mclean)/dustarea;         %   Calculating mass concentration
scatter(dustmass1,SR)                       %   plotting the SR reading
hold
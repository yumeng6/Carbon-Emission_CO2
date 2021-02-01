  function [c1,r1]=CO2_rate(t)
%
% Function CO2_rate returns the constants c1, r1 in the CO2 
% source term
%
%   CO2_rate = c1*exp(r1*(t-1850))
%

%Parameters that worked good for data: c1=2.5e-03; r1b=0.0153

% for the case ncase.
%
  global ncase
%
% c1 sets the CO2 ppm at 2013
  c1=0.004094135951996;
 %c1=2.5e-03; r1b=0.0153;

% Base CO2 rate
  r1b=0.009702626943588;r1=r1b;r1c=0;%
%r1=r1b;r1c=0;
%
% Change the base rate for t > 2010
  if(t>2010)
    if(ncase==1)r1c= 0.0050; end  
    if(ncase==2)r1c= 0.0025; end 
    if(ncase==3)r1c= 0.0000; end   
    if(ncase==4)r1c=-0.0100; end 
  end 
%
%   Linear interpolation in t between 2010 and 2100
    r1=r1b+r1c*(t-2010)/(2100-2010);
%
% End of CO2_rate

  end
 

function [t, y] = ND_Solution
format short
%Solution to the non-dimensional problem.
%The function is defined in model_1.m

%
% Select case (see CO2_rate.m)
  ncase=2;  

% Initial conditions
  n=7;
  y0=zeros(1,n);
%
% Independent variable for ODE integration
  t0=1850;tf=2100;nout=26;
  tout=[t0:10:tf]'; 
  ncall=0;


% ODE itegration
  reltol=1.0e-06;abstol=1.0e-06;
  options=odeset('RelTol',reltol,'AbsTol',abstol);
  %Experiment with different solvers. 
  %This is dimensionless values.
  [t,y]=ode15s(@model_1,tout,y0,options); 


%To get the ppm of lower atmosphere:
 %CO2 ppm (in lower atmosphere)
%The factor 280: 1ppm atmospheric carbon is equivalent to 
%2.13 GtC.  
%Initial atmosphere: 597 GtC (Sarmiento 2002). 597/2.13=280. 
%ppm(it)=280*(1+y(it,1));


%Lower atmosphere measured in ppm so that it 
% can be compared to dat
cla=280*(1+y(:,1));


figure
plot(t,cla)
title('Model CO2 values lower atmosphere in ppm')


hold on
load('Annual.mat')
plot(AnnualData1(:,1), AnnualData1(:,2),'*')

end
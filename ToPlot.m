%% Clear temporary variables
% clear all
% close all
% clc



load average1.mat
Data=M(:,2);

%Initial start for parameters q(1)=c1, and q(2)=r1. 
 %q0=[1;1]
 
%  q0=[0.004;.01];
%  [p,l]=fminsearch(@(q)res(q,Data),q0) %p will be the optimal paraneters, l is the value for the function we are minimizing 0.5||....||^2.
%options.OptimalityTolerance=1e-10;
%[p,l]=lsqnonlin(@(q)res(q,Data),q0)

q=p
%q= [0.004094135951996;0.009702626943588] %From nonlin.m



% function F=res(q, Data)

%Variables:
%   y(1)=la;
%   y(2)=ua;
%   y(3)=sb;
%   y(4)=lb;
%   y(5)=ul;
%   y(6)=dl;
%   y(7)=mb;

%(q(1)=c_1; q(2)=r_1
 %q=[4.92e-3;0.01]
odefun=@(t,y) [
   1/5*(y(2)-y(1))+...
         1/0.75*(y(3)-y(1))+...
          1/150*(y(4)-y(1))+...
           1/30*(y(5)-y(1))+...
          q(1)*exp(q(2)*(t-1850));
  1/3*(y(1)-y(2));
 1/0.75*(y(1)-y(3));
 1/150*(y(1)-y(4));
 1/80*(y(1)-y(5))+...
          1/200*(y(6)-y(5))+...
            1/5*(y(7)-y(5));
1/1500*(y(5)-y(6)); 
  1/10*(y(5)-y(7))];
  
% Initial conditions
  n=7;
  y0=zeros(n,1);
%
% Independent variable for ODE integration
%   t0=1850;tf=2100;nout=26;
%   tout=[t0:10:tf]'; 

%Change time interval for comparison with data. 
%1959-2018 annually
   t0=1850;tf=2018; %Simulation every year, start at 1850 since we have initial conditions. 
   tout=[t0:1:tf]'; 



% ODE itegration
  reltol=1.0e-06;abstol=1.0e-06;
  options=odeset('RelTol',reltol,'AbsTol',abstol);
  %Experiment with different solvers. 
  %This is dimensionless values.
%   [t,Y]=ode15s(odefun,tout,y0,options); 
  [t,Y]=ode45(odefun,tout,y0,options); 
   %[t,Y]=ode45(odefun,[t0,tf],y0,options)%Research q
  % Select only the years that are relevant for which there is data,
  % starting at 1959.
 [indx]=find(tout==1959);
  
 
  Dn=length(Y(:,1)) ;
  
Yla=280*(1+Y(indx:Dn,1));
  %For fminsearch
%F=sum((Data-Yla)).^2;%or (norm(Data-Yla))^
%For lsqnonlin
%F=(Data'-Yla);
% end
 figure
 hold on
 plot(t(indx:Dn,1),Yla,'b', M(:,1),M(:,2),'*')
legend('Model','Data')
xlabel('Year')
ylabel('CO2 ppm')
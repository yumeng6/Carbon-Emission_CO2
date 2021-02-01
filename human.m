clear all
close all

load average1.mat
ydata=M(:,2);
xdata = M(:,1);
ell=length(M(:,1));


%----------------------------
%Consider looking at different chunks of data
%1750 to 1912
%1912-1950
%1950-2017
%----------------------------
%for 1950-2017 
[indx]=find(xdata==1950)
ydata=M(indx:ell,2);
xdata = M(indx:ell,1);
 
 

%----------------------------
%Option 1: Build system of ln of equation,b= write-up
%----------------------------
lnydata=log(ydata);
ell=length(ydata);
A=ones(ell,2);
A(:,2)=xdata;
parm=A\lnydata;
c1=exp(parm(1))
r1=parm(2)

fun = @(x)x(1)*exp(x(2)*xdata);
Y=fun([c1 r1]);
plot(xdata,ydata,'*',xdata,Y,'linewidth',1)
title('Direct solve of over determined system')
xlabel('t')
ylabel('Emissions')
%---------------------------
%Comment:  A piecewise function may may more sense. 
%---------------------------
%Option 2
%---------------------------
% fun = @(x)x(1)*exp(x(2)*xdata);
 x0 = [1e-8, 0.20];
 options = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective');
 x = lsqnonlin(@(x) res(x,xdata,ydata),x0);
 [x,fval,exitflag,output] = fminsearch(@(x) res(x,xdata,ydata),x0)
  
figure
Y=fun(x);
plot(xdata,ydata,'o',xdata,Y,'linewidth',1)
title('fminsearch')
xlabel('t')
ylabel('Emissions')

 
 %---------------------------
%Option 3
%---------------------------
% % fun = @(x)x(1)*exp(x(2)*xdata);
%  x0 = [1, 1];
%  %options = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective');
%  %x = lsqnonlin(@(x) res(x,xdata,ydata),x0);
%  [x,fval,exitflag,output] = lsqnonlin(@(x) Res(x,xdata,ydata),x0)
%   
% figure
% Y=fun(x);
% plot(xdata,ydata,'o',xdata,Y,'linewidth',1)
% title('lsqnonlin')
% xlabel('t')
% ylabel('Emissions')
% 
%  
function F=res(x,xdata,ydata)
%for fminsearch
 %What is the residual that you want to minimize?
 fun = @(x)x(1)*exp(x(2)*xdata);
 Y=fun(x);
 %F=0.5*(norm(ydata-Y))^2;
%F=sum((ydata-Y).^2);
F=(norm(ydata-Y));
 end
 


 function F=Res(x,xdata,ydata)
 %for lsqnonlin
 %What is the residual that you want ot minimize?
 fun = @(x)x(1)*exp(x(2)*xdata);
 Y=fun(x);
 %F=0.5*(norm(ydata-Y))^2;
F=(ydata-Y);
 end

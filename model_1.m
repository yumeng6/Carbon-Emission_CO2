 
function yt=model_1(t,y)
%
% Function model_1 computes the temporal derivatives 
% of the seven dependent variables
%
% Parameters shared with other routines
  global ncall
%
% Model dependent variables
  yla=y(1);
  yua=y(2);
  ysb=y(3);
  ylb=y(4);
  yul=y(5);
  ydl=y(6);
  ymb=y(7);
%
% ODEs
% %Lizette edit not to use CO2_rate
% c1=4.92e-03;
% %c1=0;
% %
% % Base CO2 rate
%   r1=0.01;
%  % r1=0;

  [c1,r1]=CO2_rate(t);
  dyla=     1/5*(yua-yla)+...
         1/0.75*(ysb-yla)+...
          1/150*(ylb-yla)+...
           1/30*(yul-yla)+...
          c1*exp(r1*(t-1850));
  dyua=     1/3*(yla-yua);
  dysb=  1/0.75*(yla-ysb);
  dylb=   1/150*(yla-ylb);
  dyul=    1/80*(yla-yul)+...
          1/200*(ydl-yul)+...
            1/5*(ymb-yul);
  dydl=  1/1500*(yul-ydl); 
  dymb=    1/10*(yul-ymb);
%
% Derivative vector
  yt(1)=dyla;
  yt(2)=dyua;
  yt(3)=dysb;
  yt(4)=dylb;
  yt(5)=dyul;
  yt(6)=dydl;
  yt(7)=dymb;
  yt=yt';
%
% Increment calls to model_1
  ncall=ncall+1;
%
% End of model_1
  end
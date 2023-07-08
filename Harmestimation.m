function [y] = Harmestimation(xx)

t=0:1/64:1;
f1=50;

f5=250;
f7=350;
f11=550;
f13=650;
%actua= 0.95*sind(2*pi*f1*t-deg2rad(2.02))+0.09*sind(2*pi*f5*t + deg2rad(82.1))+0.04*sind(2*pi*f7*t + deg2rad(7.9))+0.03*sind(2*pi*f11*t - deg2rad(147.1))+0.033*sind(2*pi*f13*t-deg2rad(162.6));
%actua=0.95*sind(2*pi*50*t-deg2rad(2.02)) ;

actua= 0.95*sind(2*pi*f1*t-deg2rad(2.02))+0.09*sind(2*pi*f5*t + deg2rad(82.1))+0.04*sind(2*pi*f7*t + deg2rad(7.9))+0.03*sind(2*pi*f11*t - deg2rad(147.1))+0.033*sind(2*pi*f13*t-deg2rad(162.6));
actual=awgn(actua,20);
%actual=actua;
 
estimated=sind(2*pi*f1*t+deg2rad(xx(1)))+sind(2*pi*f5*t + deg2rad(xx(2)))+sind(2*pi*f7*t + deg2rad(xx(3)))+sind(2*pi*f11*t + deg2rad(xx(4)))+sind(2*pi*f13*t+deg2rad(xx(5)));
%estimated=sind(2*pi*f1*t+deg2rad(xx));
H=estimated';
Y=actual';
N=1;
%for idx=0:N
   % H=[H,X.^idx];
%end
astar=inv(H'*H)*H'*Y;

actual1=actual';
estimated1=astar*estimated;
%H=[];
%X=estimated';
%Y=actual';
%N=2;
%for idx=0:N
 %   H=[H,X.^idx];
%end
%astar=inv(H'*H)*H'*Y;

actual1=actual;
%estimated1=H*astar;

%z=(sum((actua'-estimated1).*(actua'-estimated1))/length(actua'));
zss=(sum((actual1-estimated).*(actual1-estimated))/sum((actual1.*actual1)));
if zss>0
    y=1/(1+zss);
   
else  y=1+(abs(zss));
end
end

% The modified sphere function: z=sum_{i=1}^D (x_i-1)^2
%z=sum((x-1).^2); % The global minimum fmin=0 at (1,1,...,1)

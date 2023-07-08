clc;
clear all;
close all
tic
fobj = @Harmestimation;
%nvar=30;
lb=-360;
ub=360;
Materials_no=30;
Max_iter=100;
dim=5;


% C3=2;C4=.5;  %cec and engineering problems
C3=1;C4=2;  %standard Optimization functions
[Xbest, Scorebest,Convergence_curve]=AOA(Materials_no,Max_iter,fobj, dim,lb,ub,C3,C4);
%figure,semilogy(Convergence_curve,'r')
%xlim([0 1000]);
Xbest
 Scorebest
 
 t=0:1/64:1;
f1=50;
f5=250;
f7=350;
f11=550;
f13=650;
%actua=0.95*sind(2*pi*50*t-deg2rad(2.02)) ;
actua= 0.95*sind(2*pi*f1*t-deg2rad(2.02))+0.09*sind(2*pi*f5*t + deg2rad(82.1))+0.04*sind(2*pi*f7*t + deg2rad(7.9))+0.03*sind(2*pi*f11*t - deg2rad(147.1))+0.033*sind(2*pi*f13*t-deg2rad(162.6));

actual=awgn(actua,20);
%estimated=0.95*sind(2*pi*50*t+deg2rad(Xbest));
estimated=0.95*sind(2*pi*f1*t+deg2rad(Xbest(1)))+0.09*sind(2*pi*f5*t + deg2rad(Xbest(2)))+0.04*sind(2*pi*f7*t + deg2rad(Xbest(3)))+0.03*sind(2*pi*f11*t + deg2rad(Xbest(4)))+0.033*sind(2*pi*f13*t+deg2rad(Xbest(5)));
%
%H=[];asta
H=estimated';
Y=actual';
N=1;
%for idx=0:N
   % H=[H,X.^idx];
%end
astar=inv(H'*H)*H'*Y;

actual1=actual';
estimated1=astar*estimated;
%estimated1=H*astar;

%z=(sum((actua'-estimated1).*(actua'-estimated1))/length(actua'));
f=(sum((actual1-estimated1').*(actual1-estimated1'))/sum((actual1.*actual1)))
toc
rng(10);
clc;
clear;

C=[3.53660387
19.85982136
25.40676371


];
t=[1
9
15


];
C_mat=[5.68048233
36.87093901
51.32411235

];


figure

plot(t,C);
title('Call option price with Control Variate method based on different T')
xlabel('T')
hold on;
plot(t,C_mat);
het1=legend('call option price based on GBM','call option price based on put-call parity method utilizing the results of our GBM method')
set(het1,'Location','NorthWest') 
ylabel('Call Option Price')

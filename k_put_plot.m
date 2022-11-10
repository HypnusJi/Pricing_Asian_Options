rng(10);
clc;
clear;

C=[11.46899612
17.86652308
25.23771379



];
t=[100
110
120


];
C_mat=[7.24987444
13.64870451
21.01833174



];


figure

plot(t,C);
title('put option price with Control Variate method based on different K')
xlabel('K')
hold on;
plot(t,C_mat);
het1=legend('put option price based on GBM','put option price based on put-call parity method utilizing the results of our GBM method')
set(het1,'Location','NorthWest') 
ylabel('Put Option Price')

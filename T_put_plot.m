rng(10);
clc;
clear;
 
C=[10.80342478
10.63375417
8.56076762



];
t=[1
9
15


];
C_mat=[8.65954632
-6.37736348
-17.35658101



];


figure

plot(t,C);
title('put option price with Control Variate method based on different T')
xlabel('T')
hold on;
plot(t,C_mat);
het1=legend('put option price based on GBM','put option price based on put-call parity method utilizing the results of our GBM method')
set(het1,'Location','SouthWest') 
ylabel('Put Option Price')

rng(10);
clc;
clear;

C=[6.76613264
4.11658853
2.43784157



];
t=[100
110
120


];
C_mat=[10.98525432
8.33440709
6.65722362



];


figure

plot(t,C);
title('call option price with Control Variate method based on different K')
xlabel('K')
hold on;
plot(t,C_mat);
het1=legend('call option price based on GBM','call option price based on put-call parity method utilizing the results of our GBM method')
set(het1,'Location','SouthWest') 
ylabel('call Option Price')

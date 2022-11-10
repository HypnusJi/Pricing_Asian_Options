rng(10);
clc;
clear;
asian_mc_call(2.0,32)

%asian_mc_call(2.0,2)
%asian_mc_call(2.0,4)
%asian_mc_call(2.0,8)
%asian_mc_call(2.0,16)
%asian_mc_call(2.0,32)
%asian_mc_call(2.0,64)

function asian_mc_call(T,m)

K=100;
r=0.05; 
s0=90; sig=0.3;  
h=T/m; 



fprintf(' n         call-option     Put-Call parity(put)     Variance         stdError             time      \n')
r0=r-sig^2/2;
for i=1:m   
    t1(i)=i*h;
end

for p=1:6
    n(p)=10*2^(p+10);
end
for p=1:6
    tic;  
    temp1=0;
    temp2=0;  
    for k=1:n(p)
        
        s1(1)=s0;                      
        for i=1:m
              rni=randn;
              s1(i+1)=s1(i)*exp(r0*h+sig*sqrt(h)*rni);
              s(i)=s1(i+1);  
           
        end
        temp1=temp1+max(sum(s)/m-K,0);              
        temp2=temp2+max(sum(s)/m-K,0)*max(sum(s)/m-K,0);
    end
    v=(exp(-r*T))*temp1/n(p);
    var=(exp(-r*T))*((n(p)*temp2-temp1^2)/((n(p)-1)*n(p)));
    stddev=sqrt(var);
    stderr=stddev/sqrt(n(p));       
    time=toc;
    %put-call parity to calculate put option based on call option
P=v-s0+(K/(exp(r*T)));

     fprintf('%6d  %15.8f   %15.8f    %15.8f    %15.8f     %15.8f     \n',n(p),v,P,var,stderr,time);
end
end


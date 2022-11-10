rng(10);
clc;
clear;


asian_mc_call_cv(2.0,32)
function asian_mc_call_cv(T,m)
K=100;
r=0.05;  
s0=90; sig=0.3;  
h=T/m; 

fprintf(' n         call(GBM)           put(GBM)         call(BSM)            Variance           stdError             time      \n')

% calculate expectation_Y under the BSM model 
r0=r-sig^2/2; 
sig0=sig*sqrt((2*m+1)/(3*m)); 
T0=(m+1)/(2*m)*T; 
expectation_Y=exp(r0*T0-r*T)*asian_call_bsm(s0*exp(sig0*sig0*T0/2),K,sig0,r0,T0); 
s(1)=s0;s2(1)=s0; 
for p=1:6 
  n(p)=10*2^(p+10);
end 

for p=1:6 
    tic; 
    temp1=0; 
    temp2=0; 
    temp3=0; 
    temp4=0; 
    temp5=0;
    for j=1:n(p)   
        %GeometricalBrownianMotion
        for i=2:m+1 
             rni=randn;             
            s2(i)=s2(i-1)*exp((r-sig^2/2)*h+sig*sqrt(h)*rni); %asset price under BSM model   
            s1(i-1)=s2(i); 
            s3(i-1)=log(s2(i)); 
        end        
     ave_a1=sum(s1)/m; 
        ave_g1=exp(sum(s3))^(1/m); 
        geo_payoff=max(ave_g1-K,0); 
        arith_payoff=max(ave_a1-K,0); 
        temp1=temp1+arith_payoff; 
        temp2=temp2+arith_payoff^2; 
        temp3=temp3+geo_payoff; 
        temp4=temp4+geo_payoff^2; 
        temp5=temp5+geo_payoff*arith_payoff;
    end

    S=sum(s1)/m;
    d1=(log(S/K)+(r+sig^2/2)*T)/(sig*sqrt(T));
d2=(log(S/K)+(r-sig^2/2)*T)/(sig*sqrt(T));
v2=S*normcdf(d1)-K*exp(-r*T)*normcdf(d2);

lamda_st=(n(p)*temp5-temp1*temp3)/(n(p)*temp4-temp3*temp3); 
    v=(exp(-r*T))*((temp1-lamda_st*temp3)/(n(p)))+lamda_st*expectation_Y; 
    temp6=n(p)*temp2-temp1*temp1+lamda_st*lamda_st*(n(p)*temp4-temp3*temp3); 
    temp7=2*lamda_st*(n(p)*temp5-temp1*temp3); 
    varx=(exp(-r*T))*(temp6-temp7)/((n(p)-1)*n(p)); 
     stderr=sqrt(varx)/sqrt(n(p));
    time=toc; 
    %put-call parity to calculate put option based on call option
   P=v-s0+(K/(exp(r*T)));


    fprintf('%6d  %15.8f   %15.8f   %15.8f    %15.8f    %15.8f     %15.8f     \n',n(p),v,P,v2,varx,stderr,time);
      
end         
end
  
function z=asian_call_bsm(S0,K,sig,r,t)

d1=(log(S0/K)+(r+sig^2/2)*t)/(sig*sqrt(t));
d2=(log(S0/K)+(r-sig^2/2)*t)/(sig*sqrt(t));
z=S0*normcdf(d1)-K*exp(-r*t)*normcdf(d2);
end   

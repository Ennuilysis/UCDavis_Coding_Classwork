clc
clear
close all
%Name: Gerrik Labra
% Student ID: 914076227

% Lab 9: Geometric Random Walks
% MAT/BIS 107, Spring 2021
% University of California, Davis

%% Instructions: Enter your answers below each corresponding question header.
% Your code should produce the necessary outputs and/or plots, depending
% on what each question requests. Wordy answers or explanations can be
% enterred as comments using the '%' symbol or printed directly
% to the Command Window.
"Question 1"
% Q1a:
R=[1.2,0.8];
probs=[0.5,0.5];
EV_logR=sum(probs.*log(R))


% Q1b:

EV_logR2=sum(probs.*log(R).^2);
Var_logR=EV_logR2-EV_logR^2

% Q1c:
T=100
Ns=1000
N0=100
Nt=NaN(Ns,T);
for i=1:Ns
    Nt(i,:)=sim_geometric_population(N0,R,probs,T);
end
figure;
plot(log(Nt'))
xlabel('Time')
ylabel('LogN(t)')
title("Q1")
% Q1d:
hold on
t=1:T;
ElogN=log(N0)+t*EV_logR;
plot(t,ElogN, 'color', 'k','LineWidth',2)
hold off

% Q1e:
prop_under_0=sum(log(Nt(:,T))<0)

"Question 2"
% Q2a:
R=[5,0.25];
EV_logR=sum(probs.*log(R))

% Q2b:
EV_logR2=sum(probs.*(log(R).^2));
Var_logR=EV_logR2-EV_logR^2

% Q2c:
T=100
Ns=1000
N0=100
Nt=NaN(Ns,T);
for i=1:Ns
    Nt(i,:)=sim_geometric_population(N0,R,probs,T);
end
figure;
plot(log(Nt'))
xlabel('Time')
ylabel('LogN(t)')
hold on

% Q2d:
t=1:T;
ElogN=log(N0)+t*EV_logR;
plot(t,ElogN, 'color', 'k','LineWidth',2)
title("Q2")
hold off
% Q2e:
prop_under_0=sum(log(Nt(:,T))<0)

"Question 3"
% Q3:
%Question 2 creates higher proportions of populations, max instance at time
%of writing 70, while the first question has lower proportion of
%populations, max at time of writing being 12.

% Q4a:
"Question 4"
logN100=log(Nt(:,T));
figure
histogram(logN100,15,'Normalization','probability')
xlabel('population size log')
ylabel('Density')
title('Q4')
%For some reason its waaaay higher, I dont know why. I followed the video
%walkthrough.

% Q4b:
EV_logN100=log(N0)+T*EV_logR
Var_logN_100=T*Var_logR

% Q4c:
hold on
llaa=[-60:0.1:60];
plot(llaa,normpdf(llaa,EV_logN100,sqrt(Var_logN_100)),'LineWidth',1)
hold off

"Question 5"
% Q5:
data=csvread('checkerspots.csv',1,1);
x_pre71=data(data(:,1)<1971,2);
x_post71=data(data(:,1)>=1971,2);
mean_pre=mean(x_pre71)
mean_post=mean(x_post71)

% Q6:
"Question 6"
%Distribution R
R_pre=exp(0.932171-3262.42*x_pre71.^(-2));
R_post=exp(0.932171-3262.42*x_post71.^(-2));

u_logR_pre=mean(log(R_pre))
u_logR_post=mean(log(R_post))

%Pre 1971 has the larger logR

% Q7a:

"Question 7"
N0=100;
Ns=1000;
probs=ones(1,length(R_pre))/length(R_pre);

Nt_pre=NaN(Ns,T);
for i=1:Ns
   Nt_pre(i,:)=sim_geometric_population(N0,R_pre,probs,T); 
end
figure
plot(log(Nt_pre'))
xlabel('Time')
ylabel('Log N(t)')
title('Q7')
hold on
plot(log(N0)+t*u_logR_pre,'color','k','LineWidth',2)
hold off
% Q7b:
prop_under_0_pre=sum(log(Nt_pre(:,T))<0)/Ns



"Question 8"
% Q8a:
N0=100;
Ns=1000;
probs=ones(1,length(R_post))/length(R_post);

Nt_post=NaN(Ns,T);
for i=1:Ns
   Nt_post(i,:)=sim_geometric_population(N0,R_post,probs,T); 
end
figure
plot(log(Nt_post'))
xlabel('Time')
ylabel('Log N(t)')
title('Q8')
hold on
plot(log(N0)+t*u_logR_post,'color','k','LineWidth',2)
hold off

% Q8b:
prop_under_0_post=sum(log(Nt_post(:,T))<0)/Ns

% Q9:
%Differences are generated by the mean and variance. While Question 7 has a
%lower variance, the mean has a low slope. There is very little risk of
%losing the Bay checkerspot to extinction. Q8 has a higher variance and a
%negative slope. There is a significant, and higher chance therefore that
%the Bay checkerspot will be lost. However, due to the variance, the chance
%is less than half. High variance means there is better probability of not
%following the mean. The simulations match my statements.

% Rainfall
% mean_pre =67.3039
% mean_post =73.8481
% 
% Pre 1971 has the larger logR for population growth.
% u_logR_pre = 0.0402
% u_logR_post = -0.0487
% prop_under_0_pre = 0.0210
% prop_under_0_post = 0.4940

%Assuming that the change in pre and post mean rainfall is a large
%fluctuation in local climate, the condition correlates with the rising
%probability of Bay checkersposts extinction. The data and model supports
%the hypothesis.
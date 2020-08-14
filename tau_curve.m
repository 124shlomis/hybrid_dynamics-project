% plot tau


t=linspace(0,0.5,1000);
t1 = 0.2;
t2 = 0.3;
tau1=-0.2;
tau2=10.2;
tau3=-10;
tau = tau1+tau2*ones(size(t)).*heaviside(t-t1)+tau3*ones(size(t)).*heaviside(t-t2);

plot(t,tau);

% t2 = 0.2;
% t3 = 0.25;
% 
% if t < t1
%     tau=tau1;
% 
% end
% if t >= t1 && t < t2
%     max = 10;
%     min = -tau1;
%     t0 = t1;
%     k = 100;
%     a=17;
%     tau =-( min+(max-min)*((1./(1+exp(-k*(t-t0)))).^a));
% end
% 
% if t >= t2 && t < t3  
% 
%     max = 2;
%     min =-10;
%     t0 = t2;
%     k = 100;
%     a=17;
%     tau =( min+(max-min)*((1./(1+exp(-k*(t-t0)))).^a));
% end
% 
% if t>= t3
%     tau=0;
% end
%    
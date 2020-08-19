clear, close all
load('qdd_sol_states.mat')
load('ends_points.mat'); % rQ rR global matlabFunction
global collision_state sigma mu sol_stick_Func 
mu=0.3;
%I.C
theta1_0 = deg2rad(72); theta2_0 = deg2rad(70);
X0 =[0 0 0 0 theta1_0 0 theta2_0 0];

tspan = [0 1.2];

% ODE's options:
op_stick=odeset('reltol',1e-13,'abstol',1e-13,'Events',@events_stick);
op_slip=odeset('reltol',1e-13,'abstol',1e-13,'Events',@events_slip);
op_free=odeset('reltol',1e-13,'abstol',1e-13,'Events',@events_free);

% start jump

Tall=[];
Teall=[];
Xall=[];
Lnall=[];
Ltall=[];
Vtall=[];
Teall=[];
Xeall=[];

Finished=0;
collision_state='before';
state='stick';

while (~Finished)
    switch state
        case 'stick'

            [T,X, Te, Xe, Ie] = ode45(@sys_stick,tspan,X0,op_stick);
                
            Tall = [Tall;T];
            Teall=[Teall;Te(end)];
            Xall = [Xall;X];
            Xeall=[Xeall;Xe];
            
            %calc lambdas:
            TAU=calc_tau_vec(T);
            [lambda_t_vec,lambda_n_vec]=calc_lambdas(X,TAU,'stick');
            Ltall=[Ltall;lambda_t_vec];
            Lnall=[Lnall;lambda_n_vec];
            
            if strcmp(collision_state,'after')
                Xend = [Xend;X(:,1)];
            end
            
            if (T(end) == tspan(2)) % finished simulation without event
                Finished=1;
                break; 
            end
            
            X0 = Xe(end,:);
            tspan(1)=Te(end);
            
            switch Ie(end)
                case 1 % start slliping left
                    sigma=-1;
                    state = 'slip';
                case 2 % start slliping right
                    sigma=+1;
                    state = 'slip';
                case 3 % lambda_n=0
                    state = 'free';
                case {4,5}% rQy=0 || rRy=0 
                    Finished=1;
                    break;
            end

        case 'slip'
            
            [T,X,Te,Xe,Ie] = ode45(@sys_slip,tspan,X0,op_slip);
            
            Tall = [Tall;T];
            Teall=[Teall;Te(end)];
            Xall = [Xall;X];
            Xeall=[Xeall;Xe];
             %calc lambdas:
            TAU=calc_tau_vec(T);
            [lambda_t_vec,lambda_n_vec]=calc_lambdas(X,TAU,'slip');
            Ltall=[Ltall;lambda_t_vec];
            Lnall=[Lnall;lambda_n_vec];
            
            if strcmp(collision_state,'after')
                Xend = [Xend;X(:,1)];
            end
            
            if (T(end) == tspan(2)) % finished simulation without event
                Finished=1;
                break; 
            end
            X0 = Xe(end,:);
            tspan(1) = Te(end);
            
            switch Ie(end)
                case 1 % lambda_n=0
                    state='free';
                case 2 % vt=0
                    % check maybe start to slip to opposite direction
                    tau=calc_tau(Te(end));
                    sol_stick = sol_stick_Func(tau,X0(5),X0(7),X0(6),X0(8));
                    lambda_t = sol_stick(5);
                    lambda_n = sol_stick(6);
                    if (abs(lambda_t)<mu*lambda_n)
                        state='stick';
                    else
                        state='slip';
                        sigma=-1*sigma;
                    end
                    
                otherwise % rQy=0 || rRy=0 
                    Finished=1;
                    break;
            end
            
            
        case 'free'
            Xstart = X0(1);
            [T,X,Te,Xe,Ie]=ode45(@sys_free,tspan,X0,op_free);
            Tall = [Tall;T];
            Teall=[Teall;Te(end)];
            Xall = [Xall;X];
            Xeall=[Xeall;Xe];
            TAU=calc_tau_vec(T);
            [lambda_t_vec,lambda_n_vec]=calc_lambdas(X,TAU,'free');
            Ltall=[Ltall;lambda_t_vec];
            Lnall=[Lnall;lambda_n_vec];
            
            if (T(end) == tspan(2))
                Finished=1;
                break; 
            end
            
            X0 = impact_law(Xe(end,:));
            Xend=[X0(1)];

            collision_state='after'; % for exception
            tspan(1)=Te(end);
            
            if (abs(X0(2)) <= 1e-5) % decide next state by contact point velocity
                state='stick';
                
            else
                state='slip';
                sigma=sign(X0(2));
                
            end
         
    end
    
end
simulation2(Tall,Xall);
% find d
d = min(abs(Xend - Xstart))
% 
% % plots:
% % q
% % x
indx_to_rm = [609,1689];
for i=1:length(indx_to_rm)
Tall(indx_to_rm(i))=[];
Lnall(indx_to_rm(i))=[];
Xall(indx_to_rm(i),:)=[];
Ltall(indx_to_rm(i))=[];
end

 figure
 hold on
 myplot(Tall,Xall(:,1),'','','-','blue');
 myplot(Tall,Xall(:,3),'$Time [s]$','$Displacment [m]$','-','red');
 for i=1:length(Teall)
     xline(Teall(i),'--');
 end
 hold off
 Legend=legend('$x$','$y$');
 set(Legend,'interpreter','latex','FontSize',20)
 % thetas
 figure
 hold on
 myplot(Tall,Xall(:,5),'','','-','blue');
 myplot(Tall,Xall(:,7),'$Time [s]$','$\theta$ [rad]','-','red');
 for i=1:length(Teall)
     xline(Teall(i),'--');
 end
 hold off
 Legend=legend('$\theta_1$','$\theta_2$');
 set(Legend,'interpreter','latex','FontSize',20)
% 
% % Lambdas:
 figure
 hold on
 myplot(Tall,Lnall,'$Time [s]$','$\lambda_n [N]$','-','blue');
 for i=1:length(Teall)
     xline(Teall(i),'--');
 end
 yline(0,'--','LineWidth',2.2);
 hold off
% 
 figure
 hold on
 myplot(Tall,Ltall./Lnall,'$Time [s]$','$\frac{\lambda_t}{\lambda_n}$','-','blue');
 yline(+mu,'--','LineWidth',2.2);
 yline(-mu,'--','LineWidth',2.2);
 for i=1:length(Teall)
     xline(Teall(i),'--');
 end
 hold off

    for i=1:length(Tall)
        rP_sol(i,:) = [Xall(i,1);Xall(i,3);0];
        rQ_sol(i,:) = rQ(Xall(i,5),Xall(i,1),Xall(i,3));
        rR_sol(i,:) = rR(Xall(i,5),Xall(i,7),Xall(i,1),Xall(i,3));
        RP = rR_sol(i,:)-rP_sol(i,:);
        ang(i) = abs(atand(RP(1)/RP(2)));
    end
    
 figure
 hold on
 myplot(Tall,rR_sol(:,2),'','','-','r');
 myplot(Tall,rQ_sol(:,2),'','','-','g');
 myplot(Tall,rP_sol(:,2),'$Time [s]$','Y [m]','-','blue');
 for i=1:length(Teall)
     xline(Teall(i),'--');
 end
 hold off
 Legend=legend('$Point - R$','$Point - Q$','$Point - P$');
 set(Legend,'interpreter','latex','FontSize',15)

 figure
 hold on
 myplot(Tall,ang,'$Time [s]$','$|\angle RP-Y_{axis}|  [\circ]$','-','blue');
 for i=1:length(Teall)
     xline(Teall(i),'--');
 end
 hold off



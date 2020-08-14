% events slip function:
function [value,isterminal,direction]=events_slip(t,X)
    global sol_slip_Func sigma rQ rR 
    

    
    tau = calc_tau(t);
    sol_slip_Num=sol_slip_Func(sigma,tau,X(5),X(7),X(6),X(8));
    
    lambda_n = sol_slip_Num(5);
    

    
    rP_sol = [X(1);X(3);0];
    rQ_sol = rQ(X(5),X(1),X(3));
    rR_sol = rR(X(5),X(7),X(1),X(3));
    
     W_t = [1 0 0 0];
     q_dot = [X(2);X(4);X(6);X(8)];
     vt = W_t*q_dot;

    
    %check_exceptions:
    exceptions(rP_sol,rQ_sol,rR_sol,X(7),lambda_n);
    


    value = [lambda_n; vt; rQ_sol(2); rR_sol(2)];
    isterminal = [1;1;1;1];
    direction = [0;0;0;0];


end
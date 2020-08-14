function [value,isterminal,direction]=events_stick(t,X)
    global sol_stick_Func rQ rR mu 
    
    rP_sol = [X(1);X(3);0];
    rQ_sol = rQ(X(5),X(1),X(3));
    rR_sol = rR(X(5),X(7),X(1),X(3));
    

    
    tau = calc_tau(t);
    sol_stick_Num=sol_stick_Func(tau,X(5),X(7),X(6),X(8));
    lambda_t = sol_stick_Num(5);
    lambda_n = sol_stick_Num(6);
    

    
    % check exceptions:
    exceptions(rP_sol,rQ_sol,rR_sol,X(7),lambda_n);
    
    value = [lambda_t - mu*lambda_n; -lambda_t - mu*lambda_n; lambda_n; rQ_sol(2); rR_sol(2)];
    isterminal=[1;1;1;1;1];
    direction=[0;0;0;0;0];
    
    

end


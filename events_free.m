% free state events function:
function [value,isterminal,direction]=events_free(~,X)
    global rQ rR % matlabFunctions
    
    rP_sol = [X(1);X(3);0];
    rQ_sol = rQ(X(5),X(1),X(3));
    rR_sol = rR(X(5),X(7),X(1),X(3));
    lambda_n=0;

    
    %check_exceptions:
    exceptions(rP_sol,rQ_sol,rR_sol,X(7),lambda_n);

    value = X(3);
    isterminal = 1;
    direction = 0;
end

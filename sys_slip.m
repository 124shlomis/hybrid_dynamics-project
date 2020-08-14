% slip system function:
function dXdt = sys_slip(t,X)
    global sol_slip_Func sigma 
    tau=calc_tau(t);
    
   
    sol_slip_Num=sol_slip_Func(sigma,tau,X(5),X(7),X(6),X(8));
    dXdt=zeros(8,1);
    dXdt(1)=X(2);
    dXdt(2)=sol_slip_Num(1);
    dXdt(3)=0;%X(4);
    dXdt(4)=sol_slip_Num(2);
    dXdt(5)=X(6);
    dXdt(6)=sol_slip_Num(3);
    dXdt(7)=X(8);
    dXdt(8)=sol_slip_Num(4);

    
    % calculate sgn_slip - sigma - maybe need earlier
%     W_t = [1 0 0 0];
%     q_dot = [X(2);X(4);X(6);X(8)];
%     v_t = W_t * q_dot;
%     sigma = sign(v_t);
    
end
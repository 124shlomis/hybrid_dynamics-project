% free state function:
function dXdt = sys_free(t,X)
    global sol_free_Func 
    tau=calc_tau(t);
    sol_free_Num=sol_free_Func(tau,X(5),X(7),X(6),X(8));
    dXdt=zeros(8,1);
    dXdt(1)=X(2);
    dXdt(2)=sol_free_Num(1);
    dXdt(3)=X(4);
    dXdt(4)=sol_free_Num(2);
    dXdt(5)=X(6);
    dXdt(6)=sol_free_Num(3);
    dXdt(7)=X(8);
    dXdt(8)=sol_free_Num(4);

end
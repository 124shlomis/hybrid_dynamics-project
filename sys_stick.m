function dXdt = sys_stick(t,X)
    global sol_stick_Func 
    tau=calc_tau(t);
    sol_stick_Num=sol_stick_Func(tau,X(5),X(7),X(6),X(8));
    dXdt=zeros(8,1);
    dXdt(1)=X(2);
    dXdt(2)=sol_stick_Num(1);
    dXdt(3)=X(4);
    dXdt(4)=sol_stick_Num(2);
    dXdt(5)=X(6);
    dXdt(6)=sol_stick_Num(3);
    dXdt(7)=X(8);
    dXdt(8)=sol_stick_Num(4);

end
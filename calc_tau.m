% tau function:
function tau=calc_tau(t)
    t1 = 0.14;
    t2 = 0.17;
    t3 = 0.181;
    tau1=-0.1;
    tau2=-10.0;
    tau3=8.9;
    tau4=0;
    if t < t1
        tau=tau1;
        
    end
    if t >= t1 && t < t2
%         max = 10;
%         min = -tau1;
%         t0 = t1;
%         k = 100;
%         a=17;
%         tau =-( min+(max-min)*((1./(1+exp(-k*(t-t0)))).^a));
        tau=tau2;
    end
        
    if t >= t2 && t < t3  
        tau=tau3;
%         max = 2;
%         min =-10;
%         t0 = t2;
%         k = 100;
%         a=17;
%         tau =( min+(max-min)*((1./(1+exp(-k*(t-t0)))).^a));
    end
    
    if t>= t3
        tau=tau4;
    end

   
    
end
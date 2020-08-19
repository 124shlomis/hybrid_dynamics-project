% tau function:
function tau=calc_tau(t)
    t1 = 0.114;
    t2 = 0.117;
    t3 = 0.1181;
    tau1=-0.11;
    tau2=-10.0;
    tau3=8.19;
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

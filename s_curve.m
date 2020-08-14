t=linspace(0.1,0.3,100);
        max = 10;
        min = -0.2;
        t0 = 0.1;
        k = 350;
        a=17;
        tau =-( min+(max-min)*((1./(1+exp(-k*(t-t0)))).^a));
        
        plot(t,tau);
function [lambda_t_vec,lambda_n_vec] = calc_lambdas(X,TAU,state)
    global sol_stick_Func sol_slip_Func sigma mu
    lambda_t_vec=zeros(length(TAU),1);
    lambda_n_vec=lambda_t_vec;
    switch state
        case 'stick'
            for i=1:length(TAU)
                sol_stick=sol_stick_Func(TAU(i),X(i,5),X(i,7),X(i,6),X(i,8));
                lambda_t_vec(i)=sol_stick(5);
                lambda_n_vec(i)=sol_stick(6);
            end
        case 'slip'
                for i=1:length(TAU)
                    sol_stick=sol_slip_Func(sigma,TAU(i),X(i,5),X(i,7),X(i,6),X(i,8));
                    lambda_n_vec(i)=sol_stick(5);
                    lambda_t_vec(i)=-sigma*mu*sol_stick(5);
                end
        case 'free'
                    lambda_n_vec=zeros(size(TAU));
                    lambda_t_vec=zeros(size(TAU));
            
    end     
end


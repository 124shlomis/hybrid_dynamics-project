function Xnew = impact_law(Xold)
%IMPACT_LAW calculates the change in the state vector according to impact
%   state vector [x x_dot y y_dot theta1 theta1_dot theta2 theta2_dot]'
load('M_Func.mat','M_Func');
global mu
e_t=0;e_n=0;

Xnew=zeros(8,1);

Xnew(1)=Xold(1);
Xnew(3)=Xold(3);
Xnew(5)=Xold(5);
Xnew(7)=Xold(7);

Mc=M_Func(Xold(5),Xold(7));
Wc=[1 0 0 0;0 1 0 0];

A = Wc * (Mc \ Wc');
q_dot_minus = [Xold(2);Xold(4);Xold(6);Xold(8)];
V_minus = Wc * q_dot_minus;

Lambda1 = [0; -V_minus(2) / A(2,2)];
Lambda2 = -A \ V_minus;


Lambda_hat = (1 + e_n)*Lambda1 + (1 + e_t)*(Lambda2 - Lambda1);


if (abs(Lambda_hat(1)) <= mu*Lambda_hat(2))
    kappa = 1 + e_t;
else
    kappa = (mu*(1+e_n)*Lambda1(2)) / (abs(Lambda2(1)) - mu*(Lambda2(2) - Lambda1(2)));
end

Lambda = (1+e_n)*Lambda1 + kappa*(Lambda2 - Lambda1);

V_plus = V_minus + A*Lambda;

q_dot_plus = q_dot_minus + (Mc \ Wc') * Lambda;

Xnew(2) = q_dot_plus(1);
Xnew(4) = q_dot_plus(2);
Xnew(6) = q_dot_plus(3);
Xnew(8) = q_dot_plus(4);
end


function TAU = calc_tau_vec(tvec)
%calc_tau_vec Summary of this function goes here
%   Detailed explanation goes here
    TAU=zeros(length(tvec),1);
    for i=1:length(tvec)
        TAU(i)=calc_tau(tvec(i));
    end
end


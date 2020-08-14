function exceptions(rP_sol,rQ_sol,rR_sol,theta2,lambda_n)
    global collision_state 
    
    
 % exceptions:
    switch collision_state
        case 'before' %
             %1) angle between P-R and Y axis
             %2) Q must be higher than P and lower than R
             %3) theta2 must be lower than +-180 degrees
            RP = rR_sol-rP_sol;
            ang = abs(atand(RP(1)/RP(2)));
            
            if ang>60
                error('BeforeCollision::angle between RP and Y is greater than 60 degrees');
            end

            if (rQ_sol(2) > rR_sol(2))
               error('BeforeCollision::Q is higher than R');
            end
            
            if (rQ_sol(2) < rP_sol(2) && rQ_sol(2)>0)
                 error('BeforeCollision::P is higher than Q');
            end
            if (abs(rad2deg(theta2)) > 180 )
                 error('BeforeCollision::theta2 is higher than 180');
            end
            
        case 'after'
             % exceptions:
             %1) P must be in contact with the surface
             %2) theta2 must be lower than +-180 degrees
             if lambda_n <=1e-15
                 error('AfterCollision::contact force is lower than 1e-15');
                 %disp(lambda_n);
             end
            
             if (abs(rad2deg(theta2)) > 180 )
                 error('AfterCollision::theta2 is higher than 180');
            end
    end
end


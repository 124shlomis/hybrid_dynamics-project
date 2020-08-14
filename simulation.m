function simulation(Tall,Xall)
%SIMULATION simulate the jumper robot jump
%   Tall - time vector of all movment
%   Xall - state vector of all movment 
    load('ends_points.mat','rQ','rR');
    Tlast = Tall(1);
    delta = 0.001;
    index = 0;
    for i = 2 : length(Tall)
        dist = (Tall(i)-Tlast)-delta;
        if dist>=0
            index = index +1;
            Tnew(index) = Tall(i);
            Xnew(index,:) = Xall(i,:);
            Tlast = Tall(i);
        end
    end
    Tall = Tnew;
    Xall = Xnew;
    v=[];
    
    for i=1:length(Tall)-1
        rP_sol = [Xall(i,1);Xall(i,3);0];
        rQ_sol = rQ(Xall(i,5),Xall(i,1),Xall(i,3));
        rR_sol = rR(Xall(i,5),Xall(i,7),Xall(i,1),Xall(i,3));
        del_t = Tall(i+1) - Tall(i);
        
        v(:,:,i) = [rP_sol'; rQ_sol'; rR_sol'];
        t(i)=del_t;
    end
    
    
% animation
fig=figure(1);
grid on

axis equal
xlim([-0.9,0.1]);
ylim([0,1]);
lower_link = line([nan,nan],[nan,nan]);
upper_link = line([nan,nan],[nan,nan]);

VV = VideoWriter('jump','MPEG-4');
VV.Quality = 100;
 open(VV);
for i = 1:2:length(t)
    title([num2str(Tall(i)) ' [s]'],'FontSize',20)
    
    drawnow
    set(lower_link,'XData',[v(1,1,i),v(2,1,i)],'YData',[v(1,2,i),v(2,2,i)],'linewidth',4,'color','k');
    set(upper_link,'XData',[v(2,1,i),v(3,1,i)],'YData',[v(2,2,i),v(3,2,i)],'linewidth',4,'color','k');
    xlabel('X [m]','interpreter','latex','FontSize',15);
    ylabel('Y [m]','interpreter','latex','FontSize',20);
    frame = getframe(gcf);
    writeVideo(VV,frame);
end
close(VV);
end




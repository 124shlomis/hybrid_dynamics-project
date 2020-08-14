function Frames(Tall,Xall)

  load('ends_points.mat','rQ','rR');
%     Tlast = Tall(1);
%     delta = 0.001;
%     index = 0;
%     for i = 2 : length(Tall)
%         dist = (Tall(i)-Tlast)-delta;
%         if dist>=0
%             index = index +1;
%             Tnew(index) = Tall(i);
%             Xnew(index,:) = Xall(i,:);
%             Tlast = Tall(i);
%         end
%     end
%     Tall = Tnew;
%     Xall = Xnew;

    T = [0 0.14 0.17 0.3419 0.5138 0.6857 0.8133 0.9409 1.0683];
    index = 1;
    for i = 1 : length(Tall)
        if Tall(i)-T(index)>=0
        Tnew(index) = Tall(i);
        Xnew(index,:) = Xall(i,:);
        index = index +1;
        if index>length(T)
            break
        end
        end
    end
    
    Tall = Tnew;
    Xall = Xnew;
    v=[];
    
    for i=1:length(Tall)
        rP_sol = [Xall(i,1);Xall(i,3);0];
        rQ_sol = rQ(Xall(i,5),Xall(i,1),Xall(i,3));
        rR_sol = rR(Xall(i,5),Xall(i,7),Xall(i,1),Xall(i,3));
        v(:,:,i) = [rP_sol'; rQ_sol'; rR_sol'];
    end
    
    
% animation
fig=figure(1);
grid on
axis equal
xlim([-0.9,0.1]);
ylim([0,1]);
title([num2str(0) ' [s]'],'FontSize',20)
xlabel('X [m]','interpreter','latex','FontSize',15);
ylabel('Y [m]','interpreter','latex','FontSize',20);
lower_link = line([v(1,1,1),v(2,1,1)],[v(1,2,1),v(2,2,1)],'linewidth',4,'color','k');
upper_link = line([v(2,1,1),v(3,1,1)],[v(2,2,1),v(3,2,1)],'linewidth',4,'color','k');


for i = 1:1:length(Tall)
    title([num2str(Tall(i)) ' [s]'],'FontSize',20)    
    drawnow
    set(lower_link,'XData',[v(1,1,i),v(2,1,i)],'YData',[v(1,2,i),v(2,2,i)],'linewidth',4,'color','k');
    set(upper_link,'XData',[v(2,1,i),v(3,1,i)],'YData',[v(2,2,i),v(3,2,i)],'linewidth',4,'color','k');
    xlabel('X [m]','interpreter','latex','FontSize',15);
    ylabel('Y [m]','interpreter','latex','FontSize',20);
end

end



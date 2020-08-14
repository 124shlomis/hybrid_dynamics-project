T_frames = [0 0.170000000000001 0.341849370653706 0.513537076683205 0.685682859896521 0.800157495799228 0.900356005016269 1.068450150658988];

ind=1;
for i=1:length(Tall)-1
    
    if Tall(i) == T_frames(ind)
        
    rP_sol1 = [Xall(i,1);Xall(i,3);0];
    rQ_sol1 = rQ(Xall(i,5),Xall(i,1),Xall(i,3));
    rR_sol1 = rR(Xall(i,5),Xall(i,7),Xall(i,1),Xall(i,3));
    del_t1 = Tall(i+1) - Tall(i);

    v1(:,:,ind) = [rP_sol1'; rQ_sol1'; rR_sol1'];
    t1(ind)=del_t1;
    ind=ind+1;
    end 
end

figure
axis equal
xlim([-0.9,0.1]);
ylim([0,1]);

grid on
lower_link = line([nan,nan],[nan,nan]);
upper_link = line([nan,nan],[nan,nan]);
for i = 1:1:length(T_frames)
    title([num2str(T_frames(i)) ' [s]'],'FontSize',20)
    drawnow
    set(lower_link,'XData',[v1(1,1,i),v1(2,1,i)],'YData',[v1(1,2,i),v1(2,2,i)],'linewidth',4,'color','k');
    set(upper_link,'XData',[v1(2,1,i),v1(3,1,i)],'YData',[v1(2,2,i),v1(3,2,i)],'linewidth',4,'color','k');
    xlabel('X [m]','interpreter','latex','FontSize',15);
    ylabel('Y [m]','interpreter','latex','FontSize',20);
end 
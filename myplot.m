function myplot(x,y,x_label,y_label,line_style,color)
    plot(x,y,'LineWidth',2.2,'color',color,'LineStyle',line_style)
    xlabel(x_label,'interpreter','latex','FontSize',15);
    ylabel(y_label,'interpreter','latex','FontSize',20);
    grid on
end


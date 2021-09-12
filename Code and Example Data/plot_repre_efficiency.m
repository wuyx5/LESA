function plot_repre_efficiency(dist_elastic,dist_spdm)

% Plot individual reconstructions
figure; xlim ([0 50]); hold on;
for i = 1:size(dist_elastic,1)
    a = plot(1:50,dist_elastic(i,1:50),'.-','MarkerSize',8,'LineWidth',1.7,'Color','b');
    a.Color = [a.Color 2/3];
    a.MarkerEdgeColor = [a.MarkerEdgeColor 1 / 2];
    a.MarkerFaceColor = [a.MarkerFaceColor 1 / 2];
    hold on;
    b = plot(1:50,dist_spdm(i,1:50),'.-','MarkerSize',8,'LineWidth',1.7,'Color','r');
    b.Color = [b.Color 1.3/3];
    b.MarkerEdgeColor = [b.MarkerEdgeColor 1 / 4];
    b.MarkerFaceColor = [b.MarkerFaceColor 1 / 4];
    hold on;
end
legend('SRNF','SPHARM-PDM');
set(gca,'FontSize',20);
set(gca,'box','off') ;

% Plot total error
dist_diff = dist_spdm - dist_elastic;
total_dist_diff = sum(dist_diff,1);
total_dist_improve = total_dist_diff./sum(dist_spdm,1);

figure; xlim ([0 50]); hold on; ylim([0 30]); hold on;
plot(sum(dist_elastic(:,1:50),1),'b','linewidth',3);
hold on;
plot(sum(dist_spdm(:,1:50),1),'--r','linewidth',3);
legend('SRNF','SPHARM-PDM');
set(gca,'FontSize',20);
set(gca,'box','off') ;

% Plot improvement
figure; xlim ([0 50]); hold on; ylim([0 35]); hold on;
plot(1:50,total_dist_improve(1:50)*100,'linewidth',3.5);
set(gca,'FontSize',20);
set(gca,'box','off') ;

end
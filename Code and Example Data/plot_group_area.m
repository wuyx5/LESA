function plot_group_area(area_AD_mean,area_MCI_mean,area_NL_mean,...
                         area_AD_diff,area_MCI_diff,area_NL_diff)

% Area Trajectories
figure;
ax = gca;
ax.YAxis.Exponent = 0;
ax.YAxis.TickLabelFormat = '%.0f';
hold on;

plot(outa+60,area_AD_mean,'.-','LineWidth',2.5,'MarkerSize',20); hold on;
plot(outa+60,area_MCI_mean,'.-','LineWidth',2.5,'MarkerSize',20); hold on;
plot(outa+60,area_NL_mean,'.-','LineWidth',2.5,'MarkerSize',20);
legend('AD','MCI','NC');
set(gca,'FontSize',15);
title('Area Trajectories');

% area difference
figure;
plot(outa(2:end)+60,area_AD_diff*100,'.-','LineWidth',2.5,'MarkerSize',20); hold on;
plot(outa(2:end)+60,area_MCI_diff*100,'.-','LineWidth',2.5,'MarkerSize',20); hold on;
plot(outa(2:end)+60,area_NL_diff*100,'.-','LineWidth',2.5,'MarkerSize',20);
legend('AD','MCI','NC');
set(gca,'FontSize',15);
title('Area Changing Rate Trajectories');

end

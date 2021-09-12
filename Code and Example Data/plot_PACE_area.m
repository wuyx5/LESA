function plot_PACE_area(age_min,age_max,area_pred,area_mean_estimate,outa)

figure;
ax = gca;
ax.YAxis.Exponent = 0;
ax.YAxis.TickLabelFormat = '%.0f';
xlim([age_min,age_max]); hold on;

plot(outa+age_min,area_mean_estimate,'k--','LineWidth',2.5); hold on;
for i = 1:length(area_pred)
    a = plot(outa+age_min,area_pred{i},'-','LineWidth',2.5);
    a.Color = [a.Color 1 / 3];
    hold on;
end
plot(outa+age_min,area_mean_estimate,'k--','LineWidth',5);
hold on;
legend('Mean trajectory');
set(gca,'FontSize',20);

end

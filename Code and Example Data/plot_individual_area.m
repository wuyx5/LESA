function plot_individual_area(age_min,age_max,area_pred,area_mean_estimate,outa,sparse_t,sparse_area,idx)

figure;
ax = gca;
ax.YAxis.Exponent = 0;
ax.YAxis.TickLabelFormat = '%.0f';
xlim([age_min,age_max]); hold on;
plot(age_min+outa,area_pred{idx},'b-','LineWidth',2.5,'MarkerSize',20);
hold on;
plot(age_min+outa,area_mean_estimate,'b--','LineWidth',2.5);
hold on;
plot(age_min+sparse_t{idx},sparse_area{idx},'r.-','LineWidth',2,'MarkerSize',20);
legend({'PACE Fitting','PACE mean','True Sparse Data'},'Location','northwest');
set(gca,'FontSize',15);
set(gca,'box','off') ;

end

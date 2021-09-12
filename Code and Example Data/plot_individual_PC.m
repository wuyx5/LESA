function plot_individual_PC(age_min,age_max,coef_pred,coef_mean_estimate,outa,sparse_t,sparse_coef,idx)
pc = 1;

figure;
xlim([age_min age_max]); hold on;
plot(age_min+outa,coef_pred{idx}(:,pc),'b-','LineWidth',2.5,'MarkerSize',20);
hold on;
plot(age_min+outa,coef_mean_estimate{pc},'b--','LineWidth',2.5);
hold on;
plot(age_min+sparse_t{idx},sparse_coef{idx}(:,pc),'r.-','LineWidth',2,'MarkerSize',20);
legend({'PACE Fitting','PACE mean','True Sparse Data'},'Location','northwest');
set(gca,'FontSize',15);
set(gca,'box','off') ;

end

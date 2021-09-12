function plot_PACE_PC(age_min,age_max,coef_pred,coef_mean_estimate,outa)

figure;
xlim([age_min,age_max]); hold on;

plot(outa+age_min,coef_mean_estimate{1},'k--','LineWidth',2.5); hold on;
for i = 1:length(coef_pred)
    a = plot(outa+age_min,coef_pred{i}(:,1),'LineWidth',2.5);
    a.Color = [a.Color 1 / 3];
    hold on;
end
plot(outa+age_min,coef_mean_estimate{1},'k--','LineWidth',5);
hold on;
legend('Mean trajectory');
set(gca,'FontSize',20);

end

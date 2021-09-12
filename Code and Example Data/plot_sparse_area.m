function plot_sparse_area(age_min,area,sparse_t)

figure;
ax = gca;
ax.YAxis.Exponent = 0;
ax.YAxis.TickLabelFormat = '%.0f';

for idx = 1:length(sparse_t)
    plot(sparse_t{idx}+age_min,area{idx},'.-','LineWidth',2,'MarkerSize',20);
    hold on;
end
set(gca,'FontSize',15);
title('Sparse Area Trajectories')

end
function plot_sparse_PC(age_min,sparse_coef,sparse_t)

figure;

for idx = 1:length(sparse_t)
        plot(sparse_t{idx}+age_min,sparse_coef{idx}(:,1),'.-','LineWidth',2,'MarkerSize',20);
        hold on;
end
hold on;
set(gca,'FontSize',15);
title('Sparse PC1 Score Trajectories');

end
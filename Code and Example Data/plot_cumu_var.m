function pc_num = plot_cumu_var(S)

pc_num = find(cumsum(S(1:100,:))/sum(S(:,:)) >= 0.90,1);
figure;
plot(100*cumsum(S(1:100,:))/sum(S(:,:)),'LineWidth',3); hold on;
plot([0,pc_num],[100*sum(S(1:pc_num,1))/sum(S(:,:)),100*sum(S(1:pc_num,1))/sum(S(:,:))],'r--','LineWidth',2); hold on;
plot([pc_num,pc_num],[20,100*sum(S(1:pc_num,1))/sum(S(:,:))],'r--','LineWidth',2);
ax = gca;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
xlabel('Principal Components');
ylabel('Percentage');
title('Coefficient Cumulative Percentage');
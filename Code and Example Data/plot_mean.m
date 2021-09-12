function plot_mean(muF)
mycolor = [0.45 0.68 0.82];
figure;
surface(muF(:,:,1),muF(:,:,2),muF(:,:,3),'FaceColor',mycolor,'EdgeAlpha',0.3);
axis equal off;
view([-170 -90]);
title('Karcher Mean');
end
function DisplaySurfaceMatchClosedCS(F2,j,rr,cc,N)

nFigs=size(F2,2);
%nFigs=3;
F=[];
for i=1:nFigs
    F{i}=MakeClosedGrid(F2{i},N);
end;

[n,t,d] = size(F{1});
c = max(max(F{1}(:,:,1)))+.5;

figure(j);


for i=1:nFigs
    subplot(rr,cc,i)
    a=plot3(F{i}(1,1,1),F{i}(1,1,2),F{i}(1,1,3),'y*','LineWidth',4);
    b=plot3(F{i}(end,end,1),F{i}(end,end,2),F{i}(end,end,3),'g*','LineWidth',4);
    c=plot3(F{i}(end,round(end/2),1),F{i}(end,round(end/2),2),F{i}(end,round(end/2),3),'k*','LineWidth',4);
    d=plot3(F{i}(round(end/2),round(end/2),1),F{i}(round(end/2),round(end/2),2),F{i}(round(end/2),round(end/2),3),'c*','LineWidth',4);
    e=plot3(F{i}(round(end/4),round(end/2),1),F{i}(round(end/4),round(end/2),2),F{i}(round(end/4),round(end/2),3),'m*','LineWidth',4);
    f=plot3(F{i}(round(3*end/4),round(end/2),1),F{i}(round(3*end/4),round(end/2),2),F{i}(round(3*end/4),round(end/2),3),'b*','LineWidth',4);
    h2 = surface(F{i}(:,:,1),F{i}(:,:,2),F{i}(:,:,3),F{1}(:,:,3));

    set(h2,'FaceColor','interp');
    axis equal;
    axis off;
    view([-30 30]);
    lighting phong;
end
% shading flat;
% colormap([.9 .9 .9]);
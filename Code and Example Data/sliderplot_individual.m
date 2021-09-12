function sliderplot_individual(mu_time)
mycolormap = customcolormap(linspace(0,1,11), {'#d83023','#e44d2b','#f66e44','#faac5d','#ffdf93','#eeffee','#adeffe','#75cdec','#5DA0C9','#5981be','#365B93'});

f = mu_time(:,:,:,1);
diff = mu_time(:,:,:,end)-mu_time(:,:,:,1);
C = sqrt(diff(:,:,1).^2+diff(:,:,2).^2+diff(:,:,3).^2);
C_max = max(C(:));

    function update3DPointS(~,~)
        f = mu_time(:,:,:,get(b,'Value'));
        
        diff = f(:,:,:)-mu_time(:,:,:,1);
        C = sqrt(diff(:,:,1).^2+diff(:,:,2).^2+diff(:,:,3).^2);
        C = C/C_max;
        
        set(h,'x',f(:,:,1),'y',f(:,:,2),'z',f(:,:,3),'Cdata',C,'EdgeAlpha',0.3);
        uicontrol('Parent',fig,'Style','text','Position',[250,500,50,50],...
            'string',num2str(20+get(b,'value')),'BackgroundColor',bgcolor,'FontSize',20);
    end

t0 = 1;
fig = figure;
pos = get(fig,'position');
set(fig,'position',[pos(1:2)/1.7 pos(3:4)*1.5]);
xlim([-8000,8000]);
ylim([-8000,8000]);
zlim([-8000,8000]);
x = f(:,:,1); y = f(:,:,2); z = f(:,:,3);
c = zeros(size(mu_time,1),size(mu_time,1));
h = surface(x,y,z,c,'EdgeAlpha',0.5);
view([-170 -90]);
% axis equal;
axis off;
set(gcf,'color','w');
colormap(mycolormap);
colorbar; caxis([0 1]);
xlabel('x');
ylabel('y');
zlabel('z');


b = uicontrol('Parent',fig,'Style','slider','Position',[140,45,500,23],...
              'value',t0, 'min',1, 'max',48,'SliderStep',[1/47 1/47],'Callback',{@update3DPointS});
bgcolor = fig.Color;
uicontrol('Parent',fig,'Style','text','Position',[50,45,90,25],...
                'String','21','FontSize',15,'BackgroundColor',bgcolor);
uicontrol('Parent',fig,'Style','text','Position',[640,45,90,25],...
                'String','68','FontSize',15,'BackgroundColor',bgcolor);
uicontrol('Parent',fig,'Style','text','Position',[200,20,400,23],...
                'String','Age','FontSize',15,'BackgroundColor',bgcolor);
            
end            
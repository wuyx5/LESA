function sliderplot_group_shape(mu_time,color)
mycolormap = customcolormap(linspace(0,1,11), {'#d83023','#e44d2b','#f66e44','#faac5d','#ffdf93','#eeffee','#adeffe','#75cdec','#5DA0C9','#5981be','#365B93'});

f = mu_time(:,:,:,1);
C = color(:,:,1);

    function update3DPointS(~,~)
        f = mu_time(:,:,:,get(b,'Value')+1);
        
        C = color(:,:,get(b,'Value')+1);
        
        set(h,'x',f(:,:,1),'y',f(:,:,2),'z',f(:,:,3),'Cdata',C,'EdgeAlpha',0.3);
        uicontrol('Parent',fig,'Style','text','Position',[250,500,50,50],...
            'string',num2str(60+get(b,'value')),'BackgroundColor',bgcolor,'FontSize',20);
    end

t0 = 0;
fig = figure;
xlim([-0.7,0.7]);
ylim([-0.7,0.7]);
zlim([-0.7,0.7]);
pos = get(fig,'position');
set(fig,'position',[pos(1:2)/1.7 pos(3:4)*1.5]);
x = f(:,:,1); y = f(:,:,2); z = f(:,:,3);
c = zeros(size(mu_time,1),size(mu_time,1));
h = surface(x,y,z,c,'EdgeAlpha',0.5);
view([-170 -90]););
axis off;
set(gcf,'color','w');
colormap(mycolormap);
colorbar; caxis([0 1]);


b = uicontrol('Parent',fig,'Style','slider','Position',[140,45,500,23],...
              'value',t0, 'min',0, 'max',30,'SliderStep',[1/30 1/30],'Callback',{@update3DPointS});
bgcolor = fig.Color;
uicontrol('Parent',fig,'Style','text','Position',[50,45,90,25],...
                'String','60','FontSize',15,'BackgroundColor',bgcolor);
uicontrol('Parent',fig,'Style','text','Position',[640,45,90,25],...
                'String','90','FontSize',15,'BackgroundColor',bgcolor);
uicontrol('Parent',fig,'Style','text','Position',[200,20,400,23],...
                'String','Age','FontSize',15,'BackgroundColor',bgcolor);
            
end            
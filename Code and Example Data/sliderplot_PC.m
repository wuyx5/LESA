function sliderplot_PC(mu,U,S,mycolormap)
% mycolormap = customcolormap(linspace(0,1,11), {'#d83023','#e44d2b','#f66e44','#faac5d','#ffdf93','#eeffee','#adeffe','#75cdec','#5DA0C9','#5981be','#365B93'});
std = 1;
dir = 1;

f = mu + std*3*S(dir)^2*U(:,:,:,dir);
diff = f - mu;
C = sqrt(diff(:,:,1).^2+diff(:,:,2).^2+diff(:,:,3).^2);
C_max = max(C(:));

    function update3DPointS(~,~)
        f = mu + get(b,'Value')*3*S(dir)^2*U(:,:,:,dir);
        
        diff = f-mu;
        C = sqrt(diff(:,:,1).^2+diff(:,:,2).^2+diff(:,:,3).^2);
        C = C/C_max;
        
        if get(b,'Value') <= 0
            C = -C;
        else
            C = C;
        end
        
        set(h,'x',f(:,:,1),'y',f(:,:,2),'z',f(:,:,3),'Cdata',C);
        uicontrol('Parent',fig,'Style','text','Position',[330,5,100,23],...
            'string',get(b,'value'),'FontSize',13,'BackgroundColor',bgcolor);
    end

t0 = 0;
fig = figure;
pos = get(fig,'position');
set(fig,'position',[pos(1)/1.5 pos(2)/4 pos(3)*1.5 pos(4)*1.8]);
x = mu(:,:,1); y = mu(:,:,2); z = mu(:,:,3);
c = zeros(size(mu,1),size(mu,2));
h = surface(x,y,z,c);
view([-170 -90]);
axis off;
axis equal;
set(gcf,'color','w');
colormap(mycolormap);
colorbar; caxis([-1 1]);
    
b = uicontrol('Parent',fig,'Style','slider','Position',[135,55,500,23],...
              'value',t0, 'min',-std, 'max',std,'Callback',{@update3DPointS});
bgcolor = fig.Color;
uicontrol('Parent',fig,'Style','text','Position',[50,55,80,25],...
                'String',sprintf('\x03bc - \x03c3'),'FontSize',15,'BackgroundColor',bgcolor);
uicontrol('Parent',fig,'Style','text','Position',[635,55,80,25],...
                'String',sprintf('\x03bc + \x03c3'),'FontSize',15,'BackgroundColor',bgcolor);
uicontrol('Parent',fig,'Style','text','Position',[290,30,190,23],...
                'String','Standard Deviation','FontSize',13,'BackgroundColor',bgcolor);
            
end            
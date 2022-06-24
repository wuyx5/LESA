function [age_min,age_max,sparse_t,area_pred,area_mean_estimate,outa,...
    coef_pred,pc_mean_estimate,surf_estimate,surf_mean]=...
    pace_fitting(sub_scan_age,sparse_area,sparse_coef,pc_num,muF,U)

% Generate sparse time points 
for i = 1:length(sub_scan_age)
        age_sub_min(i) = min(sub_scan_age{i});
        age_sub_max(i) = max(sub_scan_age{i});
end
age_min = min(age_sub_min);
age_max = max(age_sub_max);

sparse_t = cellfun(@(x) x - age_min, sub_scan_age, 'un', 0);

% Area trajectories
p = setOptions('yname','x','regular',0,'selection_k', 'FVE','FVE_threshold', 0.999,'screePlot',0, 'designPlot',0,...
               'corrPlot',0,'numBins',0, 'verbose','on','newdata',0:1:47,'bwmu_gcv',0,'bwxcov_gcv',0);

[aa] = FPCA(sparse_area,sparse_t,p);

outa = getVal(aa,'out1');      %vector of time points for mu, phi and ypred
area_mean_estimate = getVal(aa,'mu');

area_pred=FPCAeval(aa,[],0:1:47);

% PC trajectories
p = setOptions('yname','x','regular',0,'selection_k', 'FVE','FVE_threshold', 0.999,'screePlot',0, 'designPlot',0,...
               'corrPlot',0,'numBins',0, 'verbose','on','newdata',0:1:47,'bwmu_gcv',0,'bwxcov_gcv',0);  

% p = setOptions('yname','x','regular',0,'selection_k', 'FVE','FVE_threshold', 0.999,'screePlot',0, 'designPlot',0,...
%                'corrPlot',0,'numBins',0, 'verbose','on','newdata',0:1:47,'bwmu_gcv',0,'bwxcov',[2,2]);  
           
for i = 1:pc_num
    for j=1:length(sparse_coef)     
         t{j} = sparse_t{j};
         y{j} = sparse_coef{j}(:,i)';
    end

    [yy] = FPCA(y,t,p);
    
    out1 = getVal(yy,'out1');      %vector of time points for mu, phi and ypred
    pc_mean_estimate{i} = getVal(yy,'mu');
    
    ypred=FPCAeval(yy,[],0:1:47); 
    
    for j=1:length(sparse_coef) 
        coef_pred{j}(:,i) = ypred{j};
    end
end

for i = 1:length(coef_pred)
    for j = 1:size(coef_pred{1},1)
        surf_estimate{i}(:,:,:,j) = muF;
        for k = 1:pc_num
            surf_estimate{i}(:,:,:,j) = surf_estimate{i}(:,:,:,j) + coef_pred{i}(j,k)*U(:,:,:,k);
        end
        surf_estimate{i}(:,:,:,j) = surf_estimate{i}(:,:,:,j)*area_pred{i}(j);
    end
end

for i = 1:length(outa)
    surf_mean(:,:,:,i) = muF;
    for j = 1:pc_num
        surf_mean(:,:,:,i) = surf_mean(:,:,:,i) + pc_mean_estimate{j}(i)*U(:,:,:,j);
    end
    surf_mean(:,:,:,i) = area_mean_estimate(i) * surf_mean(:,:,:,i);
end

end
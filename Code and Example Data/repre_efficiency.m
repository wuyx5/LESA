function [dist_elastic,dist_spdm] = repre_efficiency(U,coef,muF,v,U_SPDM,coef_SPDM,muF_SPDM,v_SPDM)

[Theta,~,~,~]=spherharmbasis(5,50);

% Compute elastic distance
[~,anew,~,sqrtmultfactnew] = area_surf_geod_closed(muF);

dist_elastic = zeros(length(v_SPDM),100);
for id = 1:length(v_SPDM)
    for pcs = 1:100
        
    tmpsurf = zeros(50,50,3);
    for j=1:pcs
        tmpsurf(:,:,:) = tmpsurf(:,:,:) + coef(id,j)*U(:,:,:,j);
    end
    surfp = muF + tmpsurf;
    
    surft = muF + v(:,:,:,id);
   
    tmpv = surft - surfp;
    dist_elastic(id,pcs) =  sqrt(innerprodnewmet(muF,anew,sqrtmultfactnew,tmpv,tmpv,Theta));
    end
end

% Compute spdm distance
[~,anew,~,sqrtmultfactnew] = area_surf_geod_closed(muF_SPDM);

dist_spdm= zeros(length(v_SPDM),100);
for id = 1:length(v_SPDM)
    for pcs = 1:100
        
    tmpsurf = zeros(50,50,3);
    for j=1:pcs
        tmpsurf(:,:,:) = tmpsurf(:,:,:) + coef_SPDM(id,j)*U_SPDM(:,:,:,j);
    end
    surfp = muF_SPDM + tmpsurf;
    
    surft = muF_SPDM + v_SPDM(:,:,:,id);
    
    tmpv = surft - surfp;
    dist_spdm(id,pcs) =  sqrt(innerprodnewmet(muF_SPDM,anew,sqrtmultfactnew,tmpv,tmpv,Theta));
    end
end

end
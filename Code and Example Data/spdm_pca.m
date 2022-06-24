function [S_SPDM,U_SPDM,coef_SPDM,v_SPDM,muF_SPDM]=spdm_pca(F)

[Theta,~,~,~]=spherharmbasis(5,50);

for i = 1:size(F,4)
    [A(i),~,~,~] = area_surf_geod_closed(F(:,:,:,i));
    F_rescale(:,:,:,i) = scale_surf(F(:,:,:,i),A(i));
    [A1,~,multfact1,~] = area_surf_geod_closed(F_rescale(:,:,:,i));
    F_rescale(:,:,:,i) = center_surface_closed(F_rescale(:,:,:,i),multfact1,A1,Theta);
end

T = size(F_rescale,4);
N = size(F_rescale,1);

muF_SPDM = sum(F_rescale,4)/T;
muF_SPDM = MakeClosedGrid(muF_SPDM,N);

[A1,~,~,~] = area_surf_geod_closed(muF_SPDM);

muF_SPDM = scale_surf(muF_SPDM,A1);
[A1,~,multfact1,~] = area_surf_geod_closed(muF_SPDM);
muF_SPDM = center_surface_closed(muF_SPDM,multfact1,A1,Theta);

v_SPDM = F_rescale;
for j=1:T
    v_SPDM(:,:,:,j)=F_rescale(:,:,:,j)-muF_SPDM;
end

[S_SPDM,U_SPDM,coef_SPDM]=surf_pca(v_SPDM,muF_SPDM,1);
% S_SPDM = diag(S_SPDM);

end
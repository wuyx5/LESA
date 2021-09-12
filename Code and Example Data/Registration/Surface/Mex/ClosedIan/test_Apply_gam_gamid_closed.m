function test_Apply_gam_gamid_closed()
matlabd = '../../Matlab/Closed';
mexd = pwd;
l=2;
    
cd(matlabd);
    
if ~exist('Xdata','var')
    load('data.mat');
end
    
F{l}=MakeClosedGrid(Xdata{l},50);
[n,t,d] = size(F{l});

[Theta,Phi,Psi,b] = spherharmbasis(2,n);
gamid = MakeDiffeo_Closed(0,n,0,b);

fprintf('Testing original Apply_gam_gamid_closed.\n');

[A1,multfact1,sqrtmultfact1] = area_surf_closed(F{l});
F{l} = center_surface_closed(F{l},multfact1,A1,Theta);
F{l} = scale_surf(F{l},A1);
[A1,multfact1,sqrtmultfact1] = area_surf_closed(F{l});
q1 = surface_to_q(F{l},sqrtmultfact1);

for i=1:length(Xdata)
    if i == l
        continue
    end
    
    F{i}=MakeClosedGrid(Xdata{i},50);
    [A2,multfact2,sqrtmultfact2] = area_surf_closed(F{i});
    F{i} = center_surface_closed(F{i},multfact2,A2,Theta);
    F2n = scale_surf(F{i},A2);
    [A2n,multfact2n,sqrtmultfact2n] = area_surf_closed(F2n);
    q2n = surface_to_q(F2n,sqrtmultfact2n);
    %Hstart=Calculate_Distance_Closed(q1,q2n,Theta);
    [A2n,multfact2n,sqrtmultfact2n] = area_surf_closed(F2n);
    q2n = surface_to_q(F2n,sqrtmultfact2n);
    Ot = optimal_rot_surf(q1,q2n,Theta);
    F2n = rotate3D(F2n,Ot);

    [f1,f2new,A2new,A_tmp12new,A_tmp22new,A_tmp21,tmpoptdo,tmpoptrot]=findoptimalparamet(F{l},F2n,Theta,Phi);

    [A2n,multfact2n,sqrtmultfact2n] = area_surf_closed(f2new);
    q2n = surface_to_q(f2new,sqrtmultfact2n);
    Ot = optimal_rot_surf(q1,q2n,Theta);
    f2new = rotate3D(f2new,Ot);
    [A2n,multfact2n,A_tmp22new] = area_surf_closed(f2new);
    
    % ReParamclosed
    q1 = surface_to_q(f1,A_tmp21);
    q2 = surface_to_q(f2new,A_tmp22new);
    w = findphistarclosed(q2,Psi,b,Theta);
    for j=1:size(q1,3)
        v(:,:,j) = q1(:,:,j)-q2(:,:,j);
    end
    gamupdate = findupdategamclosed(v,w,b,Theta);
    gamnew{i} = updategam(gamupdate,gamid,eps);
    gamp1{i} = Apply_gam_gamid_closed(gamid,gamnew{i},n);
end
    
cd(mexd);
    
fprintf('Testing MEX Apply_gam_gamid_closed.\n');

for i=1:length(Xdata)
    if i == l
        continue
    end
    gamp2{i} = Apply_gam_gamid_closed(gamid,gamnew{i},n);
end

fprintf('Comparing:\n');

for i=1:length(Xdata)
    if i == l
        continue
    end
    
    gamperr1 = norm(gamp2{i}(:,:,1)'-gamp1{i}(:,:,1)')/norm(gamp1{i}(:,:,1)');
    gamperr2 = norm(gamp2{i}(:,:,2)-gamp1{i}(:,:,2))/norm(gamp1{i}(:,:,2));
    fprintf('Surface F%d vs F%d: gamp%d_L2relerr1 = %g, gamp%d_L2relerr2 = %g\n', l, i, i, gamperr1, i, gamperr2);
end

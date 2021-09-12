function test_findoptimalparamet()
matlabd = '../../Matlab/Closed';
mexd = pwd;
l=1;
scale=0;
    
cd(matlabd);
    
if ~exist('Xdata','var')
    load('data.mat');
end
    
F{l}=MakeClosedGrid(Xdata{l},50);
[n,t,d] = size(F{l});

[Theta,Phi,Psi,b] = spherharmbasis(2,n);
gamid = MakeDiffeo_Closed(0,n,0,b);

fprintf('Testing original findoptimalparamet.\n');

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
    F2n{i} = scale_surf(F{i},A2);
    [A2n,multfact2n,sqrtmultfact2n] = area_surf_closed(F2n{i});
    q2n = surface_to_q(F2n{i},sqrtmultfact2n);
    Ot = optimal_rot_surf(q1,q2n,Theta);
    F2n{i} = rotate3D(F2n{i},Ot);

    [f11{i},f2new1{i},A2new1{i},A_tmp12new1{i},A_tmp22new1{i},A_tmp211{i},optdo1{i},optrot1{i}]=findoptimalparamet(F{l},F2n{i},Theta,Phi,scale);
end

cd(mexd);
    
fprintf('Testing MEX findoptimalparamet.\n');

for i=1:length(Xdata)
    if i == l
        continue
    end
    
    [f12{i},f2new2{i},A2new2{i},A_tmp12new2{i},A_tmp22new2{i},A_tmp212{i},optdo2{i},optrot2{i}]=findoptimalparamet(F{l},F2n{i},Theta,Phi,scale);
end

fprintf('Comparing:\n');

for i=1:length(Xdata)
    if i == l
        continue
    end

    for j=1:3
        f1err(j) = norm(f12{i}(:,:,j)-f11{i}(:,:,j))/norm(f11{i}(:,:,j));
        f2err(j) = norm(f2new2{i}(:,:,j)-f2new1{i}(:,:,j))/norm(f2new1{i}(:,:,j));
    end
    
    A2err = abs(A2new2{i}-A2new1{i})/abs(A2new1{i});
    A_tmp12err = norm(A_tmp12new2{i}-A_tmp12new1{i})/norm(A_tmp12new1{i});
    A_tmp22err = norm(A_tmp22new2{i}-A_tmp22new1{i})/norm(A_tmp22new1{i});
    A_tmp21err = norm(A_tmp212{i}-A_tmp211{i})/norm(A_tmp211{i});
    optroterr = norm(optrot2{i}-optrot1{i})/norm(optrot1{i});
    
    for j=1:2
        optdoerr(j) = norm(optdo2{i}(:,:,j)-optdo1{i}(:,:,j))/norm(optdo1{i}(:,:,j));
    end
    
    fprintf('F%d vs F%d: f1_L2relerr1 = %g, f1_L2relerr2 = %g, f1_L2relerr3 = %g\n', l, i, f1err(1), f1err(2), f1err(3));
    fprintf('\tf2_L2relerr1 = %g, f2_L2relerr2 = %g, f2_L2relerr3 = %g\n', f2err(1), f2err(2), f2err(3));
    fprintf('\tA2_relerr = %g, A_tmp12_L2relerr = %g, A_tmp22_L2relerr = %g, A_tmp21_L2relerr = %g\n', A2err, A_tmp12err, A_tmp22err, A_tmp21err);
    fprintf('\toptdo_L2relerr1 = %g, optdo_L2relerr2 = %g\n', optdoerr(1), optdoerr(2));
    fprintf('\toptrot_L2relerr = %g\n', optroterr);
end


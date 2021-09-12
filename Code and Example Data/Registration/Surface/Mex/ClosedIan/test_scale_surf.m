function test_scale_surf()
    matlabd = '../../Matlab/Closed';
    mexd = pwd;
    
    cd(matlabd);
    
    if ~exist('Xdata','var')
        load('data.mat');
    end
    
    F{1}=MakeClosedGrid(Xdata{1},50);
    [n,t,d] = size(F{1});
    [Theta,Phi,Psi,b] = spherharmbasis(2,n);
    
    fprintf('Testing original scale_surf.\n');
    
    for i=1:length(Xdata)
        F{i}=MakeClosedGrid(Xdata{i},50);
        [A{i},multfact,sqrtmultfact] = area_surf_closed(F{i});
        F{i} = center_surface_closed(F{i},multfact,A{i},Theta);
        F1{i} = scale_surf(F{i},A{i});
    end
    
    cd(mexd);
    
    fprintf('Testing MEX scale_surf.\n');
    
    for i=1:length(Xdata)
        F2{i} = scale_surf(F{i},A{i});
    end
    
    fprintf('Comparing:\n');
    
    for i=1:length(Xdata)
        Ferr1 = norm(F2{i}(:,:,1)-F1{i}(:,:,1))/norm(F1{i}(:,:,1));
        Ferr2 = norm(F2{i}(:,:,2)-F1{i}(:,:,2))/norm(F1{i}(:,:,2));
        Ferr3 = norm(F2{i}(:,:,3)-F1{i}(:,:,3))/norm(F1{i}(:,:,3));
        fprintf('Surface F%d: F%d_L2relerr1 = %g, F%d_L2relerr2 = %g, F%d_L2relerr3 = %g\n', i, i, Ferr1, i, Ferr2, i, Ferr3);
    end
    
function test_surface_to_q()
    matlabd = '../../Matlab/Closed';
    mexd = pwd;
    
    cd(matlabd);
    
    if ~exist('Xdata','var')
        load('data.mat');
    end
    
    F{1}=MakeClosedGrid(Xdata{1},50);
    [n,t,d] = size(F{1});

    [Theta,Phi,Psi,b] = spherharmbasis(2,n);
    
    fprintf('Testing original surface_to_q.\n');
    
    for i=1:length(Xdata)
        F{i}=MakeClosedGrid(Xdata{i},50);
        [A,multfact,sqrtmultfact{i}] = area_surf_closed(F{i});
        F{i} = center_surface_closed(F{i},multfact,A,Theta);
        F{i} = scale_surf(F{i},A);
        [A,multfact,sqrtmultfact{i}] = area_surf_closed(F{i});
        q1{i} = surface_to_q(F{i},sqrtmultfact{i});
    end
    
    cd(mexd);
    
    fprintf('Testing MEX surface_to_q.\n');
    
    for i=1:length(Xdata)
       q2{i} = surface_to_q(F{i},sqrtmultfact{i}); 
    end
    
    fprintf('Comparing:\n');
    
    for i=1:length(Xdata)
        qerr1 = norm(q2{i}(:,:,1)-q1{i}(:,:,1))/norm(q1{i}(:,:,1));
        qerr2 = norm(q2{i}(:,:,2)-q1{i}(:,:,2))/norm(q1{i}(:,:,2));
        qerr3 = norm(q2{i}(:,:,3)-q1{i}(:,:,3))/norm(q1{i}(:,:,3));
        fprintf('Surface F%d: q%d_L2relerr1 = %g, q%d_L2relerr2 = %g, q%d_L2relerr3 = %g\n', i, i, qerr1, i, qerr2, i, qerr3);
    end
    
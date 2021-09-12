function test_Calculate_Distance_Closed()
    matlabd = '../../Matlab/Closed';
    mexd = pwd;
    l=2;
    
    cd(matlabd);
    
    if ~exist('Xdata','var')
        load('data.mat');
    end
    
    F1=MakeClosedGrid(Xdata{l},50);
    [n,t,d] = size(F1);

    [Theta,Phi,Psi,b] = spherharmbasis(2,n);
    
    fprintf('Testing original Calculate_Distance_Closed()\n');
    
    [A1,multfact1,sqrtmultfact1] = area_surf_closed(F1);
    F1 = center_surface_closed(F1,multfact1,A1,Theta);
    F1 = scale_surf(F1,A1);
    [A1,multfact1,sqrtmultfact1] = area_surf_closed(F1);
    q1 = surface_to_q(F1,sqrtmultfact1);
    
    for i=1:length(Xdata)
        if i == l
            continue
        end
        [A2,multfact2,sqrtmultfact2] = area_surf_closed(Xdata{i});
        F2 = center_surface_closed(Xdata{i},multfact2,A2,Theta);
        F2n = scale_surf(F2,A2);
        [A2n,multfact2n,sqrtmultfact2n] = area_surf_closed(F2n);
        q2n{i} = surface_to_q(F2n,sqrtmultfact2n);
        
        dist1{i} = Calculate_Distance_Closed(q1,q2n{i},Theta);
    end
    
    cd(mexd);
    
    fprintf('Testing MEX Calculate_Distance_Closed()\n');
    
    for i=1:length(Xdata)
        if i == l
            continue
        end
        dist2{i} = Calculate_Distance_Closed(q1,q2n{i},Theta);
    end
    
    fprintf('Comparing:\n');
    
    for i=1:length(Xdata)
        if i == l
            continue
        end
       fprintf('Surface F%d to F%d: dist_relerr = %g\n', l, i, abs((dist2{i}-dist1{i})/dist1{i}));
    end
    
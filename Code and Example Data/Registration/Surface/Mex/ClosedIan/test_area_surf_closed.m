function test_area_surf_closed()
    matlabd = '../../Matlab/Closed';
    mexd = pwd;
    
    cd(matlabd);
    
    if ~exist('Xdata','var')
        load('data.mat');
    end
    
    fprintf('Testing original area_surf_closed.\n');
    
    for i=1:length(Xdata)
        F{i}=MakeClosedGrid(Xdata{i},50);
       [A1{i},multfact1{i},sqrtmultfact1{i}] = area_surf_closed(F{i}); 
    end
    
    cd(mexd);
    
    fprintf('Testing MEX area_surf_closed.\n');
    
    for i=1:length(Xdata)
       [A2{i},multfact2{i},sqrtmultfact2{i}] = area_surf_closed(F{i}); 
    end
    
    fprintf('Comparing:\n');
    for i=1:length(Xdata)
        fprintf('Surface F%d: A_relerr = %g, multfact_L2relerr = %g\n', i, abs((A2{i}-A1{i})/A1{i}), norm(multfact2{i}-multfact1{i})/norm(multfact1{i}));
    end
    
    
function test_optimal_rot_surf()
matlabd = '../../Matlab/Closed';
mexd = pwd;
l=1;
    
cd(matlabd);
    
if ~exist('Xdata','var')
    load('data.mat');
end
    
F{l}=MakeClosedGrid(Xdata{l},50);
[n,t,d] = size(F{l});

[Theta,Phi,Psi,b] = spherharmbasis(2,n);
gamid = MakeDiffeo_Closed(0,n,0,b);

fprintf('Testing original optimal_rot_surf.\n');

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
    q2n{i} = surface_to_q(F2n,sqrtmultfact2n);
    Ot1{i} = optimal_rot_surf(q1,q2n{i},Theta);
end

cd(mexd);
    
fprintf('Testing MEX optimal_rot_surf.\n');

for i=1:length(Xdata)
    if i == l
        continue
    end
    Ot2{i} = optimal_rot_surf(q1,q2n{i},Theta);
end

fprintf('Comparing:\n');

for i=1:length(Xdata)
    if i == l
        continue
    end
    
    Oterr = norm(Ot1{i}-Ot2{i})/norm(Ot1{i});
    
    fprintf('F%d vs F%d: Ot_L2relerr = %g\n', l, i, Oterr);
end

keyboard;
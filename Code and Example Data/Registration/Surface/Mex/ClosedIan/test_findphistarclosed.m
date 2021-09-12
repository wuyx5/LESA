function test_findphistarclosed
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

fprintf('Testing original findphistarclosed.\n');

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
    Ot = optimal_rot_surf(q1,q2n,Theta);
    F2n = rotate3D(F2n,Ot);

    [f1,f2new,A2new,A_tmp12new,A_tmp22new,A_tmp21,tmpoptdo,tmpoptrot]=findoptimalparamet(F{l},F2n,Theta,Phi);

    [A2n,multfact2n,sqrtmultfact2n] = area_surf_closed(f2new);
    q2n = surface_to_q(f2new,sqrtmultfact2n);
    Ot = optimal_rot_surf(q1,q2n,Theta);
    f2new = rotate3D(f2new,Ot);
    [A2n,multfact2n,A_tmp22new] = area_surf_closed(f2new);
    
    % ReParamclosed
    q2{i} = surface_to_q(f2new,A_tmp22new);
    w1{i} = findphistarclosed(q2{i},Psi,b,Theta);
end

cd(mexd);
    
fprintf('Testing MEX findphistarclosed.\n');

for i=1:length(Xdata)
    if i == l
        continue
    end
    w2{i} = findphistarclosed(q2{i},Psi,b,Theta);
end

fprintf('Comparing:\n');

for i=1:length(Xdata)
    if i == l
        continue
    end
    
    for j=1:3
        werrmax(j)=0;
        for k=1:size(w1,4)
            werr = norm(w2{i}(:,:,j,k)-w1{i}(:,:,j,k))/norm(w1{i}(:,:,j,k));
            if werr > werrmax(j)
                werrmax(j) = werr;
            end
        end
    end
    
    fprintf('F%d vs F%d: max w_L2relerr1 = %g, max w_L2relerr2 = %g, max w_L2relerr3 = %g\n', l, i, werrmax(1), werrmax(2), werrmax(3));
end

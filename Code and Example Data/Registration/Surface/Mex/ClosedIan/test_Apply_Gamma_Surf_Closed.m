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
O=DodecaElements;

for k=1:60
    for i=1:n
        for j=1:n
            [x(1),x(2),x(3)]=spherical_to_cart(Theta(i,j),Phi(i,j),1);
            y=O{k}*x';
            [Thetan(i,j,k),Phin(i,j,k),tmp]=cartesian_to_sph(y(1),y(2),y(3));
            if (Phin(i,j,k)<0)
                Phin(i,j,k)=Phin(i,j,k)+2*pi;
            end
        end
    end
    Thetan(:,:,k)=min(max(0,Thetan(:,:,k)),pi);
    Phin(:,:,k)=min(max(0,Phin(:,:,k)),2*pi);
    gamnew{k}(:,:,1)=Thetan(:,:,k);
    gamnew{k}(:,:,2)=Phin(:,:,k);
end

fprintf('Testing original Apply_Gamma_Surf_Closed.\n');

[A1,multfact1,sqrtmultfact1] = area_surf_closed(F{l});
F{l} = center_surface_closed(F{l},multfact1,A1,Theta);
F{l} = scale_surf(F{l},A1);
[A1,multfact1,sqrtmultfact1] = area_surf_closed(F{l});
q1 = surface_to_q(F{l},sqrtmultfact1);

[A1,A_tmp11,A_tmp21] = area_surf_closed(F{l});
F{l} = center_surface_closed(F{l},A_tmp11,A1,Theta);
F{l} = scale_surf(F{l},A1);
[A1,A_tmp11,A_tmp21] = area_surf_closed(F{l});
q1 = surface_to_q(F{l},A_tmp21);

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
    %Hstart=Calculate_Distance_Closed(q1,q2n,Theta);
    [A2n,multfact2n,sqrtmultfact2n] = area_surf_closed(F2n{i});
    q2n = surface_to_q(F2n{i},sqrtmultfact2n);
    Ot = optimal_rot_surf(q1,q2n,Theta);
    F2n{i} = rotate3D(F2n{i},Ot);
    
    % findoptimalparamet

    [A2,A_tmp12,A_tmp22] = area_surf_closed(F2n{i});
    F2n{i} = center_surface_closed(F2n{i},A_tmp12,A2,Theta);
    F2n{i} = scale_surf(F2n{i},A2);
    
    for k=1:60
        f1{k,i}=Apply_Gamma_Surf_Closed(F2n{i},Theta,Phi,gamnew{k});
    end
end

cd(mexd);
    
fprintf('Testing MEX Apply_Gamma_Surf_Closed.\n');

for i=1:length(Xdata)
    if i == l
        continue
    end
    
    for k=1:60
        f2{k,i}=Apply_Gamma_Surf_Closed(F2n{i},Theta,Phi,gamnew{k});
    end
end

fprintf('Comparing:\n');

for i=1:length(Xdata)
    if i == l
        continue
    end
    
    errmax = zeros(1,3);
    for j=1:3
        for k=1:60
            err = norm(f2{k,i}(:,:,j)-f1{k,i}(:,:,j))/norm(f1{k,i}(:,:,j));
            if (err > errmax(j))
                errmax(j) = err;
            end
        end
    end
    fprintf('F%d vs F%d: L2_maxrelerr1 = %g, L2_maxrelerr2 = %g, L2_maxrelerr3 = %g\n', l, i, errmax(1), errmax(2), errmax(3));
end

function test_findgrad_closed()
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
    gamid = MakeDiffeo_Closed(0,n,0,b);
    
    [a1,a2,a3,a4] = size(b);

    Psi1=Psi(:,:,1:3);
    Psi2=Psi(:,:,4:8);
    Psi3=Psi(:,:,9:end);
    c1=size(Psi1,3);
    c2=size(Psi2,3);

    idx=1;
    for j=1:a4/2
        if (idx<=c1)
            divb(:,:,j)=-2*Psi1(:,:,idx);
            idx=idx+1;
        elseif (c1<idx && idx<=c1+c2)
            divb(:,:,j)=-6*Psi2(:,:,idx-c1);
            idx=idx+1;
        elseif (idx>c2)
            divb(:,:,j)=-12*Psi3(:,:,idx-c1-c2);
            idx=idx+1;
        end
    end
    
    fprintf('Testing original findgrad_closed.\n');
    
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
        q2n = surface_to_q(F2n,sqrtmultfact2n);
        Hstart=Calculate_Distance_Closed(q1,q2n,Theta);
        [A2n,multfact2n,sqrtmultfact2n] = area_surf_closed(F2n);
        q2n = surface_to_q(F2n,sqrtmultfact2n);
        Ot = optimal_rot_surf(q1,q2n,Theta);
        F2n = rotate3D(F2n,Ot);
        
        [f1,f2new,A2new,A_tmp12new,A_tmp22new,A_tmp21]=findoptimalparamet(F1,F2n,Theta,Phi);
        
        [A2n,multfact2n,sqrtmultfact2n] = area_surf_closed(f2new);
        q2n = surface_to_q(f2new,sqrtmultfact2n);
        Ot = optimal_rot_surf(q1,q2n,Theta);
        f2new = rotate3D(f2new,Ot);
        [A2n,multfact2n,A_tmp22new] = area_surf_closed(f2new);
        
        %ReParamclosed
        q2{i} = surface_to_q(f2new,A_tmp22new);
        
        %findphistarclosed

        [dq2du1{i}, dq2dv1{i}] = findgrad_closed(q2{i},Theta);
    end
    
    cd(mexd);
    
    fprintf('Testing MEX findgrad_closed.\n');
    
    for i=1:length(Xdata)
        if i == l
            continue
        end
        [dq2du2{i}, dq2dv2{i}] = findgrad_closed(q2{i},Theta);
    end
    
    fprintf('Comparing:\n');
    
    for i=1:length(Xdata)
        if i == l
            continue
        end
        dq2duerr1 = norm(dq2du2{i}(:,:,1)-dq2du1{i}(:,:,1))/norm(dq2du1{i}(:,:,1));
        dq2duerr2 = norm(dq2du2{i}(:,:,2)-dq2du1{i}(:,:,2))/norm(dq2du1{i}(:,:,2));
        dq2duerr3 = norm(dq2du2{i}(:,:,3)-dq2du1{i}(:,:,3))/norm(dq2du1{i}(:,:,3));
        dq2dumax = max([dq2duerr1,dq2duerr2,dq2duerr3]);
        
        dq2dverr1 = norm(dq2dv2{i}(:,:,1)-dq2dv1{i}(:,:,1))/norm(dq2dv1{i}(:,:,1));
        dq2dverr2 = norm(dq2dv2{i}(:,:,2)-dq2dv1{i}(:,:,2))/norm(dq2dv1{i}(:,:,2));
        dq2dverr3 = norm(dq2dv2{i}(:,:,3)-dq2dv1{i}(:,:,3))/norm(dq2dv1{i}(:,:,3));
        dq2dvmax = max([dq2dverr1,dq2dverr2,dq2dverr3]);
        fprintf('Surface F%d to F%d: max dq2du_L2relerr = %g, max dq2dv_L2relerr = %g\n', l, i, dq2dumax, dq2dvmax);
    end
    
    
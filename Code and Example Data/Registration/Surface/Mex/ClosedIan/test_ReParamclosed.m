function test_ReParamclosed()
matlabd = '../../Matlab/Closed';
mexd = pwd;
l=2;

set(0,'DefaultFigurePosition',[680 678 560 420]);
    
cd(matlabd);
    
if ~exist('Xdata','var')
    load('data.mat');
end
    
F{l}=MakeClosedGrid(Xdata{l},50);
[n,t,d] = size(F{l});

[Theta,Phi,Psi,b] = spherharmbasis(2,n);
gamid = MakeDiffeo_Closed(0,n,0,b);
eps=0.2;

fprintf('Testing original ReParamclosed.\n');

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

    [f1{i},f2new{i},A2new,A_tmp12new,A_tmp22new{i},A_tmp21{i},tmpoptdo,tmpoptrot]=findoptimalparamet(F{l},F2n,Theta,Phi);
    
    figure(100);
    winsize = get(figure(100),'Position');
    winsize(1:2) = [0 0];
    numframes=100;
    A=moviein(numframes,figure(100),winsize);
    set(figure(100),'NextPlot','replacechildren');
    DisplaySurfaceMatchCLosed(f1{i},f2new{i},100);
    A(:,1)=getframe(figure(100),winsize);

    [A2n,multfact2n,sqrtmultfact2n] = area_surf_closed(f2new{i});
    q2n = surface_to_q(f2new{i},sqrtmultfact2n);
    Ot = optimal_rot_surf(q1,q2n,Theta);
    f2new{i} = rotate3D(f2new{i},Ot);
    [A2n,multfact2n,A_tmp22new{i}] = area_surf_closed(f2new{i});
    
    [F2n1{i},H1,gamcum1{i},iter1,A] = ReParamclosed(f1{i},f2new{i},A_tmp21{i},A_tmp22new{i},b,gamid,gamid,Theta,Phi,Psi,2,A,winsize,5,eps);
end

cd(mexd);
    
fprintf('Testing MEX ReParamclosed.\n');

for i=1:length(Xdata)
    if i == l
        continue
    end
    [F2n2{i},H1,gamcum2{i},iter1,A] = ReParamclosed(f1{i},f2new{i},A_tmp21{i},A_tmp22new{i},b,gamid,gamid,Theta,Phi,Psi,2,A,winsize,5,eps);
end

fprintf('Comparing:\n');

for i=1:length(Xdata)
    if i == l
        continue
    end
    
    for j=1:3
        Ferr(j) = norm(F2n2{i}(:,:,j)-F2n1{i}(:,:,j))/norm(F2n1{i}(:,:,j));
    end
    
    for j=1:2
        gamerr(j) = norm(gamcum2{i}(:,:,j)-gamcum1{i}(:,:,j))/norm(gamcum1{i}(:,:,j));
    end
    
    fprintf('F%d vs F%d: F_L2relerr1 = %g, F_L2relerr2 = %g, F_L2relerr3 = %g\n\tgam_L2relerr1 = %g, gam_L2relerr2 = %g\n', l, i, Ferr(1), Ferr(2), Ferr(3), gamerr(1), gamerr(2));
end


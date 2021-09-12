function [Fnew,Fold,v] = registertomean(muF,f1,Theta,Phi,Psi,b,gridroteval)

[a,b1,c,d]=size(f1);

dphi=2*pi/(a-1);
dtheta=pi/(a-1);

for j=1:d
    f(:,:,:,j)=MakeClosedGrid(f1(:,:,:,j),50);
    [~,A1,multfact1,~] = area_surf_closed(f(:,:,:,j));
    f(:,:,:,j) = center_surface_closed(f(:,:,:,j),multfact1,A1,Theta);    
    [~,A1,~,~] = area_surf_closed(f(:,:,:,j));
    f(:,:,:,j) = scale_surf(f(:,:,:,j),A1);
end

for j=1:d
    cd('C:\Users\kurtek.1\Desktop\ShapeAnalysis\Surface\Mex\ClosedIan');
    addpath('C:\Users\kurtek.1\Desktop\ShapeAnalysis\Surface\Matlab\ClosedIan');
    [Fnew(:,:,:,j),F1,Fold(:,:,:,j)] = Compute_Elastic_Geod_Surf_Closednewq(muF,f(:,:,:,j),50,Theta,Phi,Psi,b,gridroteval,.1);
    for t=1:7
        s=(t-1)/6;
        F(:,:,t,:)=(1-s)*F1+s*Fnew(:,:,:,j);
    end
    
    for k=1:3
        [~,~,dFndt(:,:,:,k)]=gradient(F(:,:,:,k),dtheta,dphi,1/6);
    end
    v(:,:,:,j)=squeeze(dFndt(:,:,1,:));
end
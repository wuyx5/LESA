function [muF,initmu,nmv,v] = Karchermeansurf_closed_CS(f1,gridroteval,Theta,Phi,Psi,b,Resamp)

[a,b1,c,d]=size(f1);

dphi=2*pi/(a-1);
dtheta=pi/(a-1);

for j=1:d
    f(:,:,:,j)=MakeClosedGrid(f1(:,:,:,j),Resamp);
    [~,A1,multfact1,~] = area_surf_closed(f(:,:,:,j));
    f(:,:,:,j) = center_surface_closed(f(:,:,:,j),multfact1,A1,Theta);    
    [~,A1,~,~] = area_surf_closed(f(:,:,:,j));
    f(:,:,:,j) = scale_surf(f(:,:,:,j),A1);
end

[a,b1,c,d]=size(f);

muF=sum(f,4)/d;
eps=.3;
iter=1;
nmvch=1;
initmu=muF;

while (iter<100 && nmvch>1e-16)
    mv=zeros([a b1 c]);
    
    for j=1:d
        if (sum(sum(sum(muF-f(:,:,:,j))))==0)
            v=zeros(a,a,3);
        else
% %             cd('C:\Users\kurtek.1\Desktop\ShapeAnalysis\Surface\Mex\ClosedIan');
% %             addpath('C:\Users\kurtek.1\Desktop\ShapeAnalysis\Surface\Matlab\ClosedIan');
            cd('C:\Users\student\Desktop\OneDrive - Florida State University\Registration\Surface\Mex\ClosedIan');
            addpath('C:\Users\student\Desktop\OneDrive - Florida State University\Registration\Surface\Matlab\ClosedIan');
            [Fnew,F1] = Compute_Elastic_Geod_Surf_Closednewq(muF,f(:,:,:,j),Resamp,Theta,Phi,Psi,b,gridroteval,.1);
             
            for t=1:7
                s=(t-1)/6;
                F(:,:,t,:)=(1-s)*F1+s*Fnew;
            end
            
            for jj=1:3
                [~,~,dFndt(:,:,:,jj)]=gradient(F(:,:,:,jj),dtheta,dphi,1/6);
            end
            v=squeeze(dFndt(:,:,1,:));
        end
        mv=mv+v/d;
    end
    [nmv(iter)] = sum(sum(sum(mv.*mv,3).*sin(Theta))*dphi)*dtheta;
    [nmv(iter) iter]
%     if (iter>2)
%         if(nmv(iter)>nmv(iter-1))
%             break;
%         end
%     end
    nmvch=nmv(iter);
    muF=muF+eps*mv;
    [~,A1,multfact1,~] = area_surf_closed(muF);
    muF = center_surface_closed(muF,multfact1,A1,Theta);
    [~,A1,~,~] = area_surf_closed(muF);
    muF = scale_surf(muF,A1);
    iter=iter+1;
end

for j=1:d
%     cd('C:\Users\kurtek.1\Desktop\ShapeAnalysis\Surface\Mex\ClosedIan');
%     addpath('C:\Users\kurtek.1\Desktop\ShapeAnalysis\Surface\Matlab\ClosedIan');
    cd('C:\Users\student\Desktop\OneDrive - Florida State University\Registration\Surface\Mex\ClosedIan');
    addpath('C:\Users\student\Desktop\OneDrive - Florida State University\Registration\Surface\Matlab\ClosedIan');
    [Fnew,F1] = Compute_Elastic_Geod_Surf_Closednewq(muF,f(:,:,:,j),Resamp,Theta,Phi,Psi,b,gridroteval,.1);
    for t=1:7
        s=(t-1)/6;
        F(:,:,t,:)=(1-s)*F1+s*Fnew;
    end
    
    for k=1:3
        [~,~,dFndt(:,:,:,k)]=gradient(F(:,:,:,k),dtheta,dphi,1/6);
    end
    v(:,:,:,j)=squeeze(dFndt(:,:,1,:));
end
function [S,vnn1,c2,sparse_c2]=surf_pca(v,muF,sub_times)

[Theta,~,~,~]=spherharmbasis(5,50);

%random v
[a1,a2,a3,a4]=size(v);
idx = randperm(a4);
pv = v(:,:,:,idx);

[~,anew,~,sqrtmultfactnew] = area_surf_geod_closed(muF);
vn = Gram_Schmidt_cov_closed(pv,muF,anew,sqrtmultfactnew,Theta);

% % % 
for j=1:a4
    j
    for k=1:size(vn,4)
        c1(j,k)= innerprodnewmet(muF,anew,sqrtmultfactnew,v(:,:,:,j),vn(:,:,:,k),Theta);
    end
end

% PCA
K = c1'*c1;
[U,S]=svd(K);

%new basis
vn1=zeros(a1,a2,a3,a4);
for j=1:a4
    for k=1:size(vn,4)
        vn1(:,:,:,j)=vn1(:,:,:,j)+U(k,j)*vn(:,:,:,k);
    end
end

%check orthogonality 
vnn1 = Gram_Schmidt_cov_closed(vn1,muF,anew,sqrtmultfactnew,Theta);

for j=1:a4
    j
    for k=1:size(vn,4)
        c2(j,k)= innerprodnewmet(muF,anew,sqrtmultfactnew,v(:,:,:,j),vnn1(:,:,:,k),Theta);
    end
end

if length(sub_times)>1
    j = 1;
    for i = 1:length(sub_times)
        sparse_c2{i} = c2(j:j+sub_times(i)-1,:);
        j = j+sub_times(i);
    end
end

S = diag(S);
end

    

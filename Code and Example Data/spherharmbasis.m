function [Theta,Phi,Psi,b] = spherharmbasis(l,n)

n=n-1;

theta = pi*[.01:n+1-.01]/(n+.02);
phi = 2*pi*[0:n]/n;
Theta = repmat(theta,n+1,1);
Phi = repmat(phi',1,n+1);

[Psi,b] = formbasiselements(n,Theta,Phi);

[n,t,d]=size(Psi);
n=n-1;

dphi=(2*pi)/(n);
dtheta=(n*pi+pi-.02*pi)/(n^2-n);
 
for j=1:d
    lenpsi(j)=sum(sum(squeeze(Psi(:,:,j)).*squeeze(Psi(:,:,j)).*sin(Theta)))*(dphi*dtheta);
    Psi(:,:,j)=Psi(:,:,j)/sqrt(lenpsi(j));
end

for i=1:d
    for j=1:d
        R(i,j)=sum(sum(squeeze(Psi(:,:,i)).*squeeze(Psi(:,:,j)).*sin(Theta)))*(dphi*dtheta);
    end
end

[a1,a2,a3,a4] = size(b);

for j=1:a4
    blen(j) = vfinnerprod(b(:,:,:,j),b(:,:,:,j),Theta);
    b(:,:,:,j) = b(:,:,:,j)/sqrt(blen(j));
end

for i=1:a4
    for j=1:a4
        Q(i,j)=vfinnerprod(b(:,:,:,i),b(:,:,:,j),Theta);
    end
end

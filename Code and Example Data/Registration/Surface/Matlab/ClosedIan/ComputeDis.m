m=1;%9;
k=2;%8;

load('C:\Users\Master Carlos\Documents\OneDrive - Florida State University\Registration\Surface\Matlab\ClosedIan\data.mat')

% cd('C:\Documents and Settings\skurtek\Desktop\ShapeAnalysis\Surface\Mex\ClosedIan')
cd('C:\Users\Master Carlos\Documents\OneDrive - Florida State University\Registration\Surface\Mex\ClosedIan')
[F2n,F1] = Compute_Elastic_Geod_Surf_Closednewq(Xdata{m},Xdata{k},100,Theta,Phi,Psi,b,0,.1);
[F2n] = Compute_Elastic_Geod_Surf_Closednewq(F1,F2n,100,Theta,Phi,Psi1,b1,0,.1);
[F2n] = Compute_Elastic_Geod_Surf_Closednewq(F1,F2n,100,Theta,Phi,Psi2,b2,0,.1);

% cd('C:\Documents and Settings\skurtek\Desktop\ShapeAnalysis\Surface\Mex\Closed')
cd('C:\Users\Master Carlos\Documents\OneDrive - Florida State University\Registration\Surface\Mex\Closed')
[F2n1,F11] = Compute_Elastic_Geod_Surf_Closed(Xdata{m},Xdata{k},100,Theta,Phi,Psi,b,0,.3);
[F2n1] = Compute_Elastic_Geod_Surf_Closed(F11,F2n1,100,Theta,Phi,Psi1,b1,0,.3);
[F2n1] = Compute_Elastic_Geod_Surf_Closed(F11,F2n1,100,Theta,Phi,Psi2,b2,0,.3);

for j=1:7
s=(j-1)/6;
F(:,:,j,:)=F1*(1-s)+F2n*s;
end
DisplayGeod(F,1,30,30)
for j=1:7
s=(j-1)/6;
F(:,:,j,:)=F11*(1-s)+F2n1*s;
end
DisplayGeod(F,2,30,30)
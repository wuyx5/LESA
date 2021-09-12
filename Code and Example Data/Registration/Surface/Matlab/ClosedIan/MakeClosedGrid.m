function fn = MakeClosedGrid(f,n2)

[n1,t1,d1]=size(f);

n1=n1-1;
t1=t1-1;
theta1 = pi*[0:t1]/(n1);
Theta1 = repmat(theta1,n1+1,1);
phi1 = 2*pi*[0:n1]/(n1);
Phi1 = repmat(phi1',1,t1+1);

n2=n2-1;
% theta = pi*[0:n2]/(n2);
theta = pi*[.01:n2+1-.01]/(n2+.02);
phi = 2*pi*[0:n2]/n2;
Theta = repmat(theta,n2+1,1);
Phi = repmat(phi',1,n2+1);

fn(:,:,1) = interp2(Theta1,Phi1,f(:,:,1),Theta,Phi,'spline');
fn(:,:,2) = interp2(Theta1,Phi1,f(:,:,2),Theta,Phi,'spline');
fn(:,:,3) = interp2(Theta1,Phi1,f(:,:,3),Theta,Phi,'spline');
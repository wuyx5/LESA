function [muF,v] = Karcher_mean(F)

addpath('Code and Example Data\Registration\Surface\Matlab\ClosedIan');
[Theta,Phi,Psi,b]=spherharmbasis(5,50);

[muF,v] = Karchermeansurf_closed(F,0,20,Theta,Phi,Psi,b);

end

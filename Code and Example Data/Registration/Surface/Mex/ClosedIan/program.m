c={'Lcaudatesurf15.mat','Lpallidumsurf15.mat','Lputamensurf15.mat','Lthalamussurf15.mat','Rcaudatesurf15.mat','Rpallidumsurf15.mat','Rputamensurf15.mat','Rthalamussurf15.mat'};

D=zeros(34,34,8);
for idx=1:8
    cd('C:\Users\admin\Desktop\LaptopBackup\Desktop\Research\Surfaces\Closed Surfaces\36subjectex')
    load(c{idx})
    cd('C:\Users\admin\Desktop\LaptopBackup\Desktop\ShapeAnalysis\Surface\Mex\ClosedIan')
    for j=1:33
        for k=j+1:34
            [~,~,~,~,D(j,k,idx)] = Compute_Elastic_Geod_Surf_Closednewq(Xdata{j},Xdata{k},50,Theta,Phi,Psi,b,0,.3);
        end
    end
    D(:,:,idx)=D(:,:,idx)+D(:,:,idx)';
end
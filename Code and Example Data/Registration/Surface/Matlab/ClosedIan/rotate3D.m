function Fnew=rotate3D(F,Ot)

[n,t,d]=size(F);

for i=1:n
    for j=1:t
        Fnew(i,j,:)=Ot*squeeze(F(i,j,:));
    end
end
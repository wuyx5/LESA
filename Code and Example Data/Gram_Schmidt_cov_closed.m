function vn = Gram_Schmidt_cov_closed(v,Fnew,anew,sqrtmultfactnew,Theta)

[e]=size(v,4);

cnt=1;

for i=1:e
    vn(:,:,:,i)=v(:,:,:,i);
    for j=1:i-1
        t = innerprodnewmet(Fnew,anew,sqrtmultfactnew,v(:,:,:,i),vn(:,:,:,j),Theta);
        vn(:,:,:,i)=vn(:,:,:,i)-t.*vn(:,:,:,j);
    end
    l = innerprodnewmet(Fnew,anew,sqrtmultfactnew,vn(:,:,:,i),vn(:,:,:,i),Theta);
    ll=sqrt(l);
    if ll>0
        vn(:,:,:,cnt)=vn(:,:,:,i)/ll;
        cnt=cnt+1;
        len = innerprodnewmet(Fnew,anew,sqrtmultfactnew,vn(:,:,:,cnt-1),vn(:,:,:,cnt-1),Theta);
    else
        len = innerprodnewmet(Fnew,anew,sqrtmultfactnew,vn(:,:,:,cnt),vn(:,:,:,cnt),Theta);
    end
end
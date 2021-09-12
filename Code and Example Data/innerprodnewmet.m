function innprod = innerprodnewmet(Fnew,anew,sqrtmultfactnew,v,v1,Theta)

a=size(Fnew,1);
d=size(Fnew,3);

dphi=(2*pi)/(a);
dtheta=(a*pi+pi-.02*pi)/(a^2+.02*a);

for i=1:d
    [dFnewdu(:,:,i), dFnewdv(:,:,i)] = gradient(Fnew(:,:,i),dtheta,dphi);
    [dvdu(:,:,i),dvdv(:,:,i)]=gradient(v(:,:,i),dtheta,dphi);
    [dv1du(:,:,i),dv1dv(:,:,i)]=gradient(v1(:,:,i),dtheta,dphi);
end

vn=reshape(permute(v,[3 1 2]),3,a*a);
v1n=reshape(permute(v1,[3 1 2]),3,a*a);
Fnewn=reshape(permute(Fnew,[3 1 2]),3,a*a);
anewn=reshape(permute(anew,[3 1 2]),3,a*a);
sqrtmultfactnewn=reshape(sqrtmultfactnew,1,a*a);
dFnewdun=reshape(permute(dFnewdu,[3 1 2]),3,a*a);
dFnewdvn=reshape(permute(dFnewdv,[3 1 2]),3,a*a);
dvdun=reshape(permute(dvdu,[3 1 2]),3,a*a);
dvdvn=reshape(permute(dvdv,[3 1 2]),3,a*a);
dv1dun=reshape(permute(dv1du,[3 1 2]),3,a*a);
dv1dvn=reshape(permute(dv1dv,[3 1 2]),3,a*a);
sinth=reshape(sin(Theta),1,a*a);

%         dadp(:,j)=cross(dvdun(:,j),dFnewdvn(:,j))+cross(dFnewdun(:,j),dvdvn(:,j));
%         dadm(:,j)=cross(dv1dun(:,j),dFnewdvn(:,j))+cross(dFnewdun(:,j),dv1dvn(:,j));
%         adotdadp(j)=dot(anewn(:,j),dadp(:,j));
%         adotdadm(j)=dot(anewn(:,j),dadm(:,j));
        dadp=cross(dvdun,dFnewdvn)+cross(dFnewdun,dvdvn);
        dadm=cross(dv1dun,dFnewdvn)+cross(dFnewdun,dv1dvn);
        adotdadp=dot(anewn,dadp);
        adotdadm=dot(anewn,dadm);


for j=1:a*a
        term1(:,j)=(1/(4*sqrtmultfactnewn(j)^6))*adotdadp(j)*Fnewn(:,j);
        term2(:,j)=adotdadm(j)*Fnewn(:,j);
        term3(:,j)=(1/(2*sqrtmultfactnew(j)^2))*(adotdadm(j)*vn(:,j)+adotdadp(j)*v1n(:,j));
        term4(:,j)=sqrtmultfactnew(j)^2*vn(:,j);
        t1(:,j)=term1(:,j).*term2(:,j).*sinth(:,j);
        t2(:,j)=term3(:,j).*Fnewn(:,j).*sinth(:,j);
        t3(:,j)=term4(:,j).*v1n(:,j).*sinth(:,j);
end

% for j=1:a
%     for k=1:a
%         dadp(j,k,:)=cross(dvdu(j,k,:),dFnewdv(j,k,:))+cross(dFnewdu(j,k,:),dvdv(j,k,:));
%         dadm(j,k,:)=cross(dv1du(j,k,:),dFnewdv(j,k,:))+cross(dFnewdu(j,k,:),dv1dv(j,k,:));
%         adotdadp(j,k)=dot(anew(j,k,:),dadp(j,k,:));
%         adotdadm(j,k)=dot(anew(j,k,:),dadm(j,k,:));
%         term1(j,k,:)=(1/(4*sqrtmultfactnew(j,k)^6))*adotdadp(j,k)*Fnew(j,k,:);
%         term2(j,k,:)=adotdadm(j,k)*Fnew(j,k,:);
%         term3(j,k,:)=(1/(2*sqrtmultfactnew(j,k)^2))*(adotdadm(j,k)*v(j,k,:)+adotdadp(j,k)*v1(j,k,:));
%         term4(j,k,:)=sqrtmultfactnew(j,k)^2*v(j,k,:);
%     end
% end

innprod=sum(sum(t1,1))*dtheta*dphi+sum(sum(t2,1))*dtheta*dphi+sum(sum(t3,1))*dtheta*dphi;
% innprod=sum(sum(sum(term1.*term2,3))*du)*dv+sum(sum(sum(term3.*Fnew,3))*du)*dv+sum(sum(sum(term4.*v1,3))*du)*dv;

% % % % for j=1:a
% % % %     for k=1:a
% % % %         dadp(j,k,:)=cross(dvdu(j,k,:),dFnewdv(j,k,:))+cross(dFnewdu(j,k,:),dvdv(j,k,:));
% % % %         dadm(j,k,:)=cross(dv1du(j,k,:),dFnewdv(j,k,:))+cross(dFnewdu(j,k,:),dv1dv(j,k,:));
% % % %         adotdadp(j,k)=dot(anew(j,k,:),dadp(j,k,:));
% % % %         adotdadm(j,k)=dot(anew(j,k,:),dadm(j,k,:));
% % % %         FnewdFnew(j,k)=dot(Fnew(j,k,:),Fnew(j,k,:));
% % % %         vdv1(j,k)=dot(v(j,k,:),v1(j,k,:));
% % % %         Fnewdv(j,k)=dot(Fnew(j,k,:),v(j,k,:));
% % % %         Fnewdv1(j,k)=dot(Fnew(j,k,:),v1(j,k,:));
% % % %     end
% % % % end
% % % % 
% % % % for j=1:3
% % % %     term1(:,:,j)=(1./(4.*sqrtmultfactnew.^6)).*adotdadp.*Fnew(:,:,j);
% % % %     term2(:,:,j)=adotdadm.*Fnew(:,:,j);
% % % %     term3(:,:,j)=(1./(2.*sqrtmultfactnew.^2)).*(adotdadp.*v(:,:,j)+adotdadm.*v1(:,:,j)).*Fnew(:,:,j);
% % % %     term4(:,:,j)=sqrtmultfactnew.^2.*v(:,:,j).*v1(:,:,j);
% % % % end
% % % % % % 
% % % % innprod=sum(sum(sum(term1.*term2,3))*du)*dv+sum(sum(sum(term3,3))*du)*dv+sum(sum(sum(term4,3))*du)*dv;
% % % % % innprod1 = (1./(4.*sqrtmultfactnew.^6)).*adotdadp.*adotdadm.*FnewdFnew+(1./(2.*sqrtmultfactnew.^2)).*(adotdadp.*Fnewdv+adotdadm.*Fnewdv1)+sqrtmultfactnew.^2.*vdv1;
% % % % 
% % % % % innprod=sum(sum(innprod1)*du)*dv;

% for i=1:d
%     [dFnewdu(:,:,i), dFnewdv(:,:,i)] = gradient(Fnew(:,:,i),dtheta,dphi);
%     [dvdu(:,:,i),dvdv(:,:,i)]=gradient(v(:,:,i),dtheta,dphi);
%     [dv1du(:,:,i),dv1dv(:,:,i)]=gradient(v1(:,:,i),dtheta,dphi);
% end
% 
% for j=1:a
%     for k=1:a
%         dadp(j,k,:)=cross(dvdu(j,k,:),dFnewdv(j,k,:))+cross(dFnewdu(j,k,:),dvdv(j,k,:));
%         dadm(j,k,:)=cross(dv1du(j,k,:),dFnewdv(j,k,:))+cross(dFnewdu(j,k,:),dv1dv(j,k,:));
%         adotdadp(j,k)=dot(anew(j,k,:),dadp(j,k,:));
%         adotdadm(j,k)=dot(anew(j,k,:),dadm(j,k,:));
%         FnewdFnew(j,k)=dot(Fnew(j,k,:),Fnew(j,k,:));
%         vdv1(j,k)=dot(v(j,k,:),v1(j,k,:));
%         Fnewdv=dot(Fnew(j,k,:),v(j,k,:));
%         Fnewdv1=dot(Fnew(j,k,:),v(j,k,:));
%     end
% end
% 
% innprod1 = (1./(4.*sqrtmultfactnew.^6)).*adotdadp.*adotdadm.*FnewdFnew+(1./(2.*sqrtmultfactnew.^2)).*(adotdadp.*Fnewdv+adotdadm.*Fnewdv1)+sqrtmultfactnew.^2.*vdv1;
% 
% innprod=sum(sum(innprod1.*sin(Theta))*dtheta)*dphi;
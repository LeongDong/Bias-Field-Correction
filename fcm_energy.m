function energy = fcm_energy(Img,q,u,c,b)
classNum = size(u,3);
energy = 0;
for i=1:classNum
    cc(:,:,i) = c(i) * ones(size(Img));
    energy = energy + sum(sum(u(:,:,i).^q .* (Img - b .* cc(:,:,i)).^2));
end
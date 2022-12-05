function [output] = MSE(img1,img2) %Mean square error

img1 = double(img1);
img2 = double(img2);
numdim1 = length(size(img1));
numdim2 = length(size(img2));

if(numdim1~=numdim2)
    error('The dimensions of two image should be same');
end

if(numdim1 == 3)
    simg1 = img1(:,:,1);
    simg2 = img2(:,:,1);
else
    simg1 = img1;
    simg2 = img2;
end

output = mean(mean((simg1 - simg2).^2));
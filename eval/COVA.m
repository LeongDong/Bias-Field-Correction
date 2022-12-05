function [output] = COVA(img1,img2) %Coefficient of variation

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
    simg2 = img2 + (img2 == 0);
end

xy = simg1 ./ simg2;
uxy = mean(mean(xy));
sigmaxy = mean(mean((xy-uxy).^2));
output = sigmaxy / uxy;
function [output] = COCO(img1,img2) %Correlation coefficient

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

ux = mean(mean(img1));
uy = mean(mean(img2));
Dx = mean(mean((img1-ux).^2))+1e-9;
Dy = mean(mean((img2-uy).^2))+1e-9;
covxy = mean(mean((img1-ux).*(img2-uy))) + 1e-9;
output = covxy / (sqrt(Dx)*sqrt(Dy));
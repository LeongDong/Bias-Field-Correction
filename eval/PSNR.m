function [output] = PSNR(img1,img2)

img1 = double(img1);
img2 = double(img2);
MAX = 255;
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

[M,N] = size(simg1);

imgdiff = simg1 - simg2;
imgdiff2 = imgdiff.*imgdiff;
mse = sum(sum(imgdiff2)) / (M*N) + 1e-9;

output = 10*log10(MAX^2/mse);
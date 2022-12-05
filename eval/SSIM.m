function [output] = SSIM(img1,img2,blocknum)

img1 = double(img1);
img2 = double(img2);
% img1 = normalize01(img1);
% img2 = normalize01(img2);

L = 255;
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
ssim = zeros(blocknum,blocknum);
[M,N] = size(simg1);
m = floor(M / blocknum);
n = floor(N / blocknum);
for i=1:blocknum
    for j=1:blocknum
        simg1b = simg1(((i-1)*m+1):i*m,((j-1)*n+1):j*n);
        simg2b = simg2(((i-1)*m+1):i*m,((j-1)*n+1):j*n);
        ux = mean(mean(simg1b));
        uy = mean(mean(simg2b));

        sigmax2 = mean(mean((simg1b - ux).^2));
        sigmay2 = mean(mean((simg2b - uy).^2));
        sigmaxy = mean(mean((simg1b - ux).*(simg2b - uy)));

        k1 = 0.01;
        k2 = 0.03;
        c1 = (k1*L)^2;
        c2 = (k2*L)^2;
        c3 = c2/2;

        l = (2*ux*uy+c1)/(ux*ux+uy*uy+c1);
        c = (2*sqrt(sigmax2)*sqrt(sigmay2)+c2) / (sigmax2+sigmay2+c2);
        s = (sigmaxy+c3) / (sqrt(sigmax2)*sqrt(sigmay2)+c3);
        ssim(i,j) = l*c*s;
    end
end

output = mean(mean(ssim));
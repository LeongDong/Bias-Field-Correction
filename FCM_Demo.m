clc;close all; clear all;
iterNum = 80;
classNum = 10;
iter = 1;
q = 2;
Img = imread('image/16.png');
Img = double(Img);
Img = Img + 1e-9;
mask = (Img>10);
Img = Img / 255.0;
[row, col] = size(Img);
c = rand(classNum,1);
b = ones(size(Img));
bunchange = ones(size(Img));
udiff = ones(size(Img));
u = rand(row,col,classNum);
ufcm = rand(row,col,classNum);
a = sum(u,3);
sigma = 5;
Ksigma = fspecial('gaussian',round(2*sigma)*2+1,sigma);
miu = 30;
enrecord = 1;
fcmflag = 1;
bflag = 1;
bcount = 0;

for i=1:classNum
    u(:,:,i) = u(:,:,i)./a;
end

for i=1:iterNum
    pause(0.1);
    
    [u,b,c] = FCM_mul(Img,q,u,b,Ksigma);    
    energy(i) = fcm_energy(Img,q,u,c,b);
    if(abs(energy(i) - enrecord) / energy(i) > 0.001 && fcmflag == 1)
       b = ones(size(Img));
       enrecord = energy(i);
    else
        fcmflag = 0;
    end
    PC = zeros(size(Img));
    for j=1:classNum
        PC = PC + u(:,:,j).*(c(j) * ones(size(Img)));
    end
    img_correct = Img ./ b;
    subplot(241), imshow(uint8(Img*255)), title('original image');
    subplot(242), imshow(uint8(PC.*mask*255)), seg = ['segmentation', num2str(i),'iteration']; title(seg);
    subplot(243), imshow(uint8(b.*mask*100)), title('bias');
    subplot(244), imshow(uint8(img_correct.*mask*255)), title('corrected image');
    subplot(2,4,[5,6,7,8]), plot(energy(:)), xlabel('iteration number'), ylabel('energy');
    pause(0.1);
end
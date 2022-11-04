function [u_out, b_out, c_out] = FCM_mul(Img,q,u,b,Ksigma)
c = updatec(Img,u,q,b);
classNum = size(u,3);
for j=1:classNum
    cc = c(j) * ones(size(Img));
    miD = (Img - cc .* b).^2;
    D(:,:,j) = miD;
end
u = updateu(D,q);
b_out = updateb(Img,u,c,q,Ksigma);
u_out = u;
c_out = c;

function newc = updatec(Img,u,q,b)
classNum = size(u,3);
b2 = b.*b;
for i=1:classNum
    newc(i) = sum(sum(u(:,:,i).^q.*Img.*b)) / sum(sum(u(:,:,i).^q.* b2));
end


function newu = updateu(D,q)
classNum = size(D,3);
p = 1 / (q-1);
D = D + 1e-9;
f = 1./(D.^p);
f_sum = sum(f,3);
for i=1:classNum
    newu(:,:,i) = 1./(D(:,:,i).^p.*f_sum);
end

function newb = updateb(Img,u,c,q,Ksigma)
classNum = size(u,3);
bd = 0;
db = 0;
for i=1:classNum
    bd = bd + Img * c(i) .* u(:,:,i).^q;
    db = db + c(i) * c(i) .* u(:,:,i).^q;
end 
kbd = conv2(bd,Ksigma,'same');
kdb = conv2(db,Ksigma,'same');
newb = kbd ./ kdb;

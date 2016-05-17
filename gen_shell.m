function [  ] = parameter( RawImg, FilledImg, width )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
iteration=width^(1.5);
pv=255*ones(1,200);
pv(101:200)=0;
g=1/3*ones(3,1);%fspecial('gaussian',[7 1],1);
for s=1:iteration
    for i=1+floor(size(g,1)/2):200-floor(size(g,1)/2)
        pv(i)=pv(i-floor(size(g,1)/2):i+floor(size(g,1)/2))*g;
    end
end
px_tol=ceil(width/10);% choose 1,2,3.... define the border's pixel width
pv_out=pv(101-width);
tol_out=pv(101-width)-pv(101-width+px_tol);
pv_in=pv(101+width);
tol_in=pv(101+width-px_tol)-pv(101+width);%get the parameters

raw=rgb2gray(imread(RawImg));
filled=rgb2gray(imread(FilledImg));
imshow(raw)
pause;
imshow(filled)
pause;
G = fspecial('gaussian',[7 7],1);%1/9*ones(3)
for i=1:iteration
    filled = imfilter(filled,G,'replicate','same');
end
imshow(filled)
pause;
shell_out=filled>=round(pv_out-tol_out)&filled<=round(pv_out);%the outer boundary
shell_in=filled>=round(pv_in)&filled<=round(pv_in+tol_in);%the inner boundary
raw_bit=raw==0;
g=bitor(raw_bit,shell_out);
imshow(255*(1-g))
pause;
g=bitor(raw_bit,shell_in);
imshow(255*(1-g))

end


clc; clear; close all;
warning('off');
im=imread('jesusbrain.png');
im=rgb2gray(im);
%original=im;
%im=im>115;
im=imbinarize(im);
%im=imcomplement(im);
B=zeros(size(im,1),size(im,2));
section=128; 
    
tic
for i=1:size(im,1)
    for j=1:size(im,2)
        if im(i,j)==1
        B(i,j)=vecin(im,i,j,section);
        else 
            B(i,j)=NaN;
        end
    end
end
toc
subplot(1,2,1);
imshow(im);
subplot(1,2,2);
colormap jet;
imagesc(B);
axis off;   
%vecin(im,22,26,section)

function dim=vecin(im,pozi,pozj,marime)
scale=0;
index=1;
k=1;
s(1)=1;
while(k<=marime)
M=k-1;

if(pozi-M<1)
    infi=1;
else
    infi=pozi-M;
end

if(pozj-M<1)
    infj=1;
else
    infj=pozj-M;
end

if(pozi+M>size(im,1))
    supi=size(im,1);
else
    supi=pozi+M;
end

if(pozj+M>size(im,2))
    supj=size(im,2);
else
    supj=pozj+M;
end

summ=nnz(im(infi:supi,infj:supj));

Ns(index)=summ;
if(index>1)
s(index)=s(index-1)+2^scale;
end
scale=scale+1;
index=index+1;
k=k*2;
end
boxLog=log(Ns);
totalLog=log(s);
%indexes=isfinite(boxLog) & isfinite(totalLog);
P=polyfit(totalLog,boxLog,1); %Ns pe y neaparat

%interval=linspace(-4,4);
%C=polyval(P,interval);
%plot(totalLog,boxLog,'r*',interval,C,'b-');
dim=P(1);

end
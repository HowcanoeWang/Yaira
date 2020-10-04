function [ X,Y,Z ] = meshgrid4scatter3( px,py,pz )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[xsize,~]=size(px);
[ysize,~]=size(py);
[zsize,~]=size(pz);
X=zeros(1,xsize*ysize*zsize);
Y=zeros(1,xsize*ysize*zsize);
Z=zeros(1,xsize*ysize*zsize);
for Xi=1:xsize
    X(1,ysize*zsize*(Xi-1)+1:ysize*zsize*(Xi))=px(Xi,1);
    for Yi=1:ysize
        Y(1,(ysize*zsize*(Xi-1))+zsize*(Yi-1)+1:(ysize*zsize*(Xi-1))+zsize*(Yi))=py(Yi,1);
        for Zi=1:zsize
            Z(1,(ysize*zsize*(Xi-1))+zsize*(Yi-1)+Zi)=pz(Zi,1);
        end
    end
end
end


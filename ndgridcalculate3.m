function [spline] = ndgridcalculate3( data_calcu,sample_size,sample_accuracy )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
x=data_calcu{2};
y=data_calcu{3};
z=data_calcu{4};
t=data_calcu{5}(1:size(data_calcu{6},4),1);
[Y,X,Z,T]=ndgrid(y,x,z,t);
time0=data_calcu{5}(1,1);
time1=data_calcu{5}(end,1);
y0=sample_size(3);
y1=sample_size(4);
x0=sample_size(1);
x1=sample_size(2);
z0=sample_size(5);
z1=sample_size(6);
if size(X,4)>1
    if isempty(find(isnan(data_calcu{6})==1, 1))
        [YI,XI,ZI,TI]=ndgrid(y0:(y1-y0)/sample_accuracy:y1,x0:(x1-x0)/sample_accuracy:x1,z0:(z1-z0)/sample_accuracy:z1,time0:(time1-time0)/sample_accuracy:time1);
        spline=interpn(Y,X,Z,T,data_calcu{6},YI,XI,ZI,TI,'spline');
    else
        spline=nan(size(X));
    end
else
    [YI,XI,ZI]=ndgrid(y0:(y1-y0)/sample_accuracy:y1,x0:(x1-x0)/sample_accuracy:x1,z0:(z1-z0)/sample_accuracy:z1);
    spline=interpn(Y,X,Z,data_calcu{6},YI,XI,ZI,'spline');
end

end


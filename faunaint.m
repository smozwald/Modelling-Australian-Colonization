%Create matrices for fauna with initial fauna values.
function [x_h,x_e,z_h,z_e]=faunaint(sea,rows,cols,dim,usa)

%Import global constants

global k_AU_x;
global k_AU_z;
ini_x=k_AU_x.*usa;
ini_z=k_AU_z.*usa;
x_h=NaN(dim);
x_e=NaN(dim);
z_h=NaN(dim);
z_e=NaN(dim);
for i=1:rows
    for j=1:cols
        if sea(i,j)==1
            x_h(i,j)=NaN;
x_e(i,j)=NaN;
z_h(i,j)=NaN;
z_e(i,j)=NaN;
        elseif sea(i,j)==0
x_h(i,j)=ini_x.*0.5;
x_e(i,j)=ini_x.*0.5;
z_h(i,j)=ini_z.*0.5;
z_e(i,j)=ini_z.*0.5;
    end
end
end

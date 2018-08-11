
function [m]=totalcatch(e,techx,techz,x_h,x_e,z_h,z_e)
%Globals for m calculation
global qxh;
global qxe;
global qzh;
global qze;

%m value for total catch calculated using provided formula. 
m=e.*techx.*(qxh.*x_h+qxe.*x_e)+e.*techz.*(qzh.*z_h+qze.*z_e);

end

%Calculate birth and death rates for fauna, based on the current SHP
%values, and the initial constants.
function[bx,dx,bz,dz]=birthdeaths(SHP)
%Summon ini values from inicon
global bxini;
global dxini;
global bzini;
global dzini;
%Recalculate birth and death matrices using the product of the SHP and the
%ini constant values.
bx=SHP.*bxini;
dx=SHP.*dxini;
bz=SHP.*bzini;
dz=SHP.*dzini;
end
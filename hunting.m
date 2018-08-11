%This function defines a static e value, quantifying the effort required to
%hunt in a certain cell. It is static over the course of the model, and
%based on distance to water resources.
function[e]=hunting(Di_weight,Di_diff,Dci_weight,Dci_diff)

global betaconst
global l_h

%Calculate WW value using provided formula.
WB=Di_weight.*Di_diff+Dci_weight.*Dci_diff;
MaxWB=max(WB(:));
MinWB=min(WB(:));
WW=1-((WB-MinWB)./(MaxWB-MinWB));

%Using labor per household value, calculate the total effort for
%a cell.

l=l_h
beta=betaconst.*WW
e=beta.*l
end
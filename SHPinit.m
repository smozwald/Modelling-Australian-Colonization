function [Di,Dci,S]=SHPinit(Di_weight,Di_diff,Dci_weight,Dci_diff,Sw)
global S_weight;

Di=Di_weight.*Di_diff;
Dci=Dci_weight.*Dci_diff;
S=S_weight.*Sw;
end
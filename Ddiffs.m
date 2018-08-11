function [Di_diff,Dci_diff]=Ddiffs(pools,sea)


global Di_opt

%Calculate the distance from each cell to an inland water source using bwdist function. Use this
%to calculate Di value. Matrix 'D' is created and than calculated for the
%distance from every cell to the closest inland pool. D values for cells where D=0 are recalculated to equal 1(to prevent infinite maximum). Using these values,
%'Dinv' and 'Di' formulas are applied.
D=bwdist(pools);
D(D==0)=1
Dinv=1./(D.^2);
Dinvmax=max(Dinv(:));
Di=Dinv./Dinvmax;
Di_diff=((Di-Di_opt)./Di_opt).^2;
%Calculate the distance from each cell to a coastal water source. Use this
%to calculate Di value. Same proces as above, however "Dc" now denotes
%coastal.
Dc=bwdist(sea)
Dc(Dc==0)=1
Dcinv=1./(Dc.^2);
Dcinvmax=max(Dcinv(:));
Dci=Dcinv./Dcinvmax;
Dci_diff=((Dci-Di_opt)./Di_opt).^2;
end

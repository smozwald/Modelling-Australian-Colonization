%function to calculate slope for Australia, using inputs of slopes, dem, rows,
%cols and resolution

function [slope]=slopes(dem,rows,cols,r)
%convert NaN values in dem to zero, as otherwise coastal zones appear as
%NaN slope.
dem(isnan(dem))=0
for i=2:rows-1;
    for j=2:cols-1;
        dzdy=(dem(i-1,j)-dem(i+1,j))/2.*r;
        dzdx=(dem(i,j-1)-dem(i,j+1))/2.*r;
        S(i,j)=(dzdx.^2+dzdy.^2).^0.5;
    end
end
%calculate slope weight using max and min slope values. Minimum slope is
%taken for slope values >0 in matrix Sm, as these values were only found to occur on sea
%cells, and not on the continent during testing.
smax=max(S(:));
Sm=S(S>0)
smin=min(Sm(:));
slope=(S-smin)./(smax-smin);
end


%Calculate rate of change in human populations, then add those changes to
%the current population for each cell.
function [N,dN]=popchange(N,m)

%retrieve global subsistence rate and natural population growth rates. As population must be an
%integer value, results are rounded to the nearest whole number upon
%calculation.
global sub;
global growth;

dN=growth.*(N).*(1-sub./m);
%Calculate new population using rate of change.
N=round(N+dN);
%If population is less than 0, population becomes 0.
N(N<=0)=0;
end
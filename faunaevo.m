%Calculate rate of change in fauna populations, then add these rates of
%change to current population.
function[p_d]=faunaevo(N,p_d,dr,br,p_od,qpd,thetap,e,kp,NB,eta)
%p_d equals population(x or z) and difficulty(e or h), p_od equals other
%diffuclty(i.e. for x_h p_od would be x_e).
%dr=deathrate,br=birthrate.
global NB;
global eta;
%Convert NaN human population values to zero
N(isnan(N))=0;
%Use formula for population rate of change, add this rate of change to the initial population.
p_dc=-dr.*p_d+eta.*br.*p_d+(1-eta).*br.*p_od-(((br-dr).*p_d).*(p_d+p_od))./kp-(N./NB).*qpd.*thetap.*e.*p_d;
p_d=round(p_d+p_dc);
p_d(p_d<=0)=0;
end

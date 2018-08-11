clear all;
close all;

%--Set for either 'spring'=0 route or 'coastal'=1 route
route=1;
if route==0
    Di_weight=3;
    Dci_weight=3;
elseif route==1
    Di_weight=0;
    Dci_weight=3;
end;

%--Loading of initial provided data. DEM=Elevation map of Australia.
%pools=binary map of inland water sources. T=Static temperature map.
%T_var=variable temperature modifier per year. Sea=binary map of ocean
%cells. P_var variable precipitation modifier per year. P=Static
%precipitation map.
load DEM;
load pools;
load T;
load T_var;
load sea;
load P_var;
load P;
%--Inicon function used to store variables. To change any global value or for
%further explanation of the constants used, see this function.
inicon;
%--Use dimensions of DEM to create basic sizes for future matrices
dim=size(DEM);
rows=dim(1);
cols=dim(2);
%--set resolution (r) of map cells at 40 km
r=40;
%--Calculate usable surface area for each cell in square miles for fauna calculations
usa=(r.*r).*0.386102159;



%--Take initial global constants for population and technology. Initfam=Number of families,
%--NB=population per family. Irow=first row location, Icol=firstcol location.
%--time equals total period for model. Constants can be found and
%changed in "inicon.m". Technology coefficients x and z are also
%established as "techx" and "techz". 
global Initfam;
global NB;
global Irow;
global Icol;
global time;
global techxinit;
global techzinit;
%Initiate technology arrays, x for technology to hunt megafauna, z to hunt
%minifauna. Also initiate totalpopulation array, to track total pop
techx=zeros(1,time);
techx(1)=techxinit;
techz=zeros(1,time);
techz(1)=techzinit;
totalpop=zeros(1,time);
%--Set initial matrices for birth and death rate of animals, plus total catch
%per household(m)
bx=NaN(dim);
dx=NaN(dim);
bz=NaN(dim);
dz=NaN(dim);
m=NaN(dim);

N=zeros(dim);
Nn=single(zeros(dim));
N(Irow,Icol)=Initfam.*NB;
%Initiate total fauna population arrays
totalfauna=zeros(1,time);
x_hfauna=zeros(1,time);
x_efauna=zeros(1,time);
z_hfauna=zeros(1,time);
z_efauna=zeros(1,time);
Xfauna=zeros(1,time);
Zfauna=zeros(1,time);
%Find date of first migration to each cell.
migdate=zeros(dim);

%--Calculate Slope weight(Sw) using "slopes" function, Additional row and
%column added afterwards to make equal to other matrices.
Sw=slopes(DEM,rows,cols,r);
Sw(85,111)=NaN;

%--Calculate euclidean distance for all non-water access points to nearest
%pool or coastal access.
[Di_diff,Dci_diff]=Ddiffs(pools,sea);
%--Initialize constant values for SHP calculation
[Di,Dci,S]=SHPinit(Di_weight,Di_diff,Dci_weight,Dci_diff,Sw);

%--Set initial fauna values, with x_h(megafauna-hard),
%x_e(megafauna-easy),z_h(minifauna-hard),z_e(minfauna-easy). Sea used to
%delimit values only to continental tiles.
[x_h,x_e,z_h,z_e]=faunaint(sea,rows,cols,dim,usa);
%--inicon global parameters for calculating fauna populations.
global k_AU_x;
global k_AU_z;
global qxh;
global qxe;
global qzh;
global qze;
%calculate carrying capacities
kx=usa.*k_AU_x;
kz=usa.*k_AU_z;
%--calculate e hunting effort values for all cells
e=hunting(Di_weight,Di_diff,Dci_weight,Dci_diff);
%--convert NaN results to "0" so that future problems, namely SHP values, are calculated
%correctly.
e(isnan(e))=0;
e(sea==1)=0;

%--create video file for population. To choose population type to be followed in model, see. Following model run, move
%videos to file delineating whether for spring, coastal, etc. Turn off with
%'%' symbol if not recording video of model
v=VideoWriter('population.avi');
open(v);


%--Timeseries function, with timescale as the final year i indicates year.
for i=1:time
%--Function calculate standardized habitat potential based on formula. For
%the variables P_var and T_var, the ith value in the series is taken.
SHP=habitat(P,P_var(i),T,T_var(i),Di,Dci,S);
%--calculate birth and death rates of animals using birth and death matrices,
%updated for each timeseries from previously calculated SHP.
[bx,dx,bz,dz]=birthdeaths(SHP);
%--catch per household per cell
m=totalcatch(e,techx(i),techz(i),x_h,x_e,z_h,z_e);
%--Calculate changing populations of flora and fauna for each type.
x_h=faunaevo(N,x_h,dx,bx,x_e,qxh,techx(i),e,kx);
x_e=faunaevo(N,x_e,dx,bx,x_h,qxe,techx(i),e,kx);
z_h=faunaevo(N,z_h,dz,bz,z_e,qzh,techz(i),e,kz);
z_e=faunaevo(N,z_e,dz,bz,z_h,qze,techz(i),e,kz);

%--Create matrices of total mega(X) and mini(Z) fauna, as well as combined
%fauna, for the purposes of calculating total populations. Turn on/off
%using '%' depending on whether total or mega/mini fauna data required.
X=x_h+x_e;
Z=z_h+z_e;
%ALLFAUNA=X+Z;

%--calculate change in population per cell for next cycle.
[N,dN]=popchange(N,m);
%--calculate changing techcoefficient for next cycle
[techx(i+1),techz(i+1)]=techchange(techx(i),techz(i));
%--calculate migration
N=migration(rows,cols,N,Nn,dN,SHP,dim);

%--BELOW FUNCTIONS ARE NOT PART OF MODEL, BUT ARE USED TO GATHER INFORMATION
%FROM MODEL. TURN ON/OFF ANY AS DESIRED TO IMPROVE INFORMATION/MODEL SPEED by ADDING/REMOVING '%'.

%Find out when each cell is first migrated to. This can be visualized
%following the model run.
migdate(migdate==0 & N>0)=i;

%--Create video using population model. First draw image and have it redrawn
%every cycle. Use this to get the frame then add this to the video. Use %
%to add or remove any videos which do/dont need to be recorded
imagesc(N)          %Use to display human changing population and migration
%imagesc(X)         %--use to display megafauna changing population and migration
%imagesc(Z)         %--Use to display minifauna changing population
%imagesc(ALLFAUNA)  %--Use to display all fauna changing populationa
caxis([0 2000])     %Scale for human population
%caxis([0 10000])   %Scale for fauna population
%colorbar
xlabel(i)
drawnow;
frame=getframe(gcf);
writeVideo(v,frame);

%Record total continental populations for megafauna, minifauna, total faun
%and human population. Used for testing of model.
x_hfauna(i)=nansum(x_h(:));
x_efauna(i)=nansum(x_e(:));
z_hfauna(i)=nansum(z_h(:));
z_efauna(i)=nansum(z_e(:));
%Xfauna(i)=nansum(X(:));
%Zfauna(i)=nansum(Z(:));
%totalfauna(i)=nansum(ALLFAUNA(:));     %--Use if preferred to seperate
%fauna values
totalpop(i)=nansum(N(:));  
end;
close(v);

%--Create plot of the changing population of humans and fauna over time
%x=[1:1:time];
%yyaxis left
%plot(x,totalpop);
%xlabel('year')
%ylabel('human population')
%yyaxis right
%plot(x,x_hfauna,'g',x,x_efauna,'m',x,z_hfauna,'y',x,z_efauna,'r');
%ylabel('fauna population')

%--Create image showing the year of migration to each cell
%imagesc(migdate)
%caxis([0 5000])
%colorbar
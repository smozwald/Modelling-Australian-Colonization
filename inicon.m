%initial row Irow and initial col Icol for initially settled cell
global Irow
Irow=19;
global Icol
Icol=36;

%Time for model to run
global time
time=5000;
%initial families
global Initfam
Initfam=400;
%Size of family/household
global NB
NB=4;

%Weighting values for precipitation(P), temperature(T), slope(S)
global P_weight
P_weight=1;
global T_weight
T_weight=1;
global S_weight
S_weight=1;

%Optimal values for Temperature(T), Precipitation (P) and Di, a weighting
%used for inland pool resources.
global T_opt
T_opt = 15;
global P_opt
P_opt=1500;
global Di_opt
Di_opt=1;

%initial birth(b) and death(d) rates for mega(x) fauna and mini(z) fauna
global bxini
bxini=0.25;
global dxini
dxini=0.05;
global bzini
bzini=0.5;
global dzini
dzini=0.25;

%tech modifiers, used as factors in determining technology change. Init
%implies initial values, x or z implies for hunting mini or mega fauna, max
%is the max tech value, r is rate of change.
global techxinit
techxinit=1;
global techzinit
techzinit=0.3;
global txmax
txmax=3;
global tzmax
tzmax=3;
global rtechx
rtechx=0;
global rtechz
rtechz=0.001;

%Catchability parameters for each species and difficulty(hard h or easy e).
global qzh
qzh=7.10.^-8;
global delta
delta=1./(0.6);
global qze
qze=delta.*qzh;
global gamma
gamma=1.2;
global qxh
qxh=gamma.*qzh;
global qxe
qxe=gamma.*qze;
%Beta constant and labour hours per household, used to calculate the total
%hunting catch of a human population.
global betaconst
betaconst=2
global l_h
l_h=7800

%Carrying capacity for animals per square mile
global k_AU_x
k_AU_x=25;
global k_AU_z
k_AU_z=25;

%Birth and population change ratio parameters. eta is related to the birth
%rate of animals, in this case is global for all. Sub is the subsistence
%rate for human populations, growth is the natural human growth rate. migP
%is the percentage of a population which will migrate, when conditions for
%migration are triggered.
global eta
eta=0.9;
global sub
sub=3.5
global growth
growth=0.15
global migP
migP=0.5
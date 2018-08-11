%Function used to calculate SHP, using a number of data inputs, primarily
%varies based on precipitation and temperature variance.
function [SHP]=habitat(P,P_var,T,T_var,Di,Dci,S)
%insert global variables from inicon function
%Globals for SHP calculation
global P_weight;
global T_weight;
global T_opt;
global P_opt;
%Calculation of P_diff value, using inputs of P_opt, P and P-var
P_act=P_var.*P;
P_diff=((P_act-P_opt)./P_opt).^2;

%Calculation of P_diff value, using inputs of P_opt, P and P-var
T_act=T_var.*T;
T_diff=((T_act -T_opt)./T_opt).^2;

%Calculate Wtot using variables, weightings and constants as per provided
%formula. Similarly calculate Max Wtot, Wsc, maxWsc and ultimately SHP
%again using the formulas.
Wtot=((P_weight.*P_diff)+(T_weight.*T_diff)+Di+Dci+S);
maxWtot=max(Wtot(:));
Wsc=maxWtot-Wtot;
maxWsc=max(Wsc(:));
SHP=Wsc./maxWsc;
end

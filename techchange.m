%Calculate changing rate of technology based on current tech and inicon
%inputs
function[techx,techz]=techchange(techx,techz)

global txmax
global tzmax
global rtechx
global rtechz

%formula from assignment instructions.
techx=techx+(rtechx.*techx).*(1-(techx./txmax))
techz=techz+(rtechz.*techz).*(1-(techz./tzmax))
end
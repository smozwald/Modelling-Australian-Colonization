%--Function to calculate migration for cells where population is decreasing
function[N]=migration(rows,cols,N,Nn,dN,SHP,dim)
%--Function to calculate migration for cells where population is decreasing
global migP;

%--Create random war matrix, all cells are assigned either a 0(Peace) or
%1(War value), in later calculations
WAR=single(randi([0 1],dim))
Nn(:)=0;
for i=1:rows
    for j=1:cols
        if dN(i,j)<0
            %--reset K value, used to check for highest nonpopulated cell
            K=0;
            %--calculate indexes for SHPNear and Nnear, i.e. all the cells
            %surrounding the target cell, where migration is possible; and
            %whether those cells are populated or sea cells(SHPNan).
            SHPnear=[SHP(i-1,j-1) SHP(i,j-1) SHP(i+1,j-1) SHP(i-1,j) SHP(i+1,j) SHP(i-1,j+1) SHP(i,j+1) SHP(i+1,j+1)];
            ROW=[i-1 i i+1 i-1 i+1 i-1 i i+1];
            COL=[j-1 j-1 j-1 j j j+1 j+1 j+1];
            SHPNan=sum(isnan(SHPnear));
            Nnear=[N(i-1,j-1) N(i,j-1) N(i+1,j-1) N(i-1,j) N(i+1,j) N(i-1,j+1) N(i,j+1) N(i+1,j+1)];  
            [highSHP,I]=sort(SHPnear,'descend');
            %correct N cells so that only cells which arent sea cells can be calculated.
            Nnear(isnan(Nnear))=0;
            Ncheck=sort(Nnear,'descend');
           
            Ncheck=Ncheck(1:(numel(Ncheck)-SHPNan));
         
            %--if all non-sea cells are occupied, migration cell is best SHP, with war to occur between the two populations. If peace, function
            %continues as normal with new population added to existing cell
            %population. If war, highest population becomes the sole
            %population of cell.
          if all(Ncheck>0)
               
           mig=I(1);
               % --if atleast one cell is unoccupied, find it by descending
               % order, using a while loop.
           else
               Ki=0;
         while K==0
             Ki=Ki+1;
           
             if and(Nnear(I(Ki))==0,~isnan(highSHP(Ki)));
                 mig=I(Ki);
                K=1;
             end;
         end;
         
          end;
           
           %--Set the row and column for the migration matrix to equal the migration cell values.
            R=ROW(mig);
            C=COL(mig);
            %--Have the migration cell be summed up. Initially, this also
            %included a resolution of war between migrating populations,
            %however this feature was removed as it does not appear that it
            %is needed in the instructions. The relic of this code is shown
            %below, prior to the summation of the Nn matrix cells. To make
            %sure additional people arent added to the population, a floor
            %value is used for migration cells(i.e. they round down),
            %whilst for regular population cells, they round up(by default,
            %as this will never be less than a .5 fraction)
%            if WAR(R,C)==1     %%--War between migrating populations
%                                   removed, as intructions state that
%                                   these populations should be summed up
%                Nn(R,C)=(max(N(i,j).*migP,Nn(R,C)));
%            else
                Nn(R,C)=floor((Nn(R,C)+N(i,j).*migP));
 %           end
            N(i,j)=round((N(i,j)-N(i,j).*migP));
        end;

    end;
        
end;

%For cells where migration is occuring and a population already exists in
%that cell, resolve war function for the (previously chosen) highest
%migration value against the current cell population.

N(WAR==1)=max(N(WAR==1),Nn(WAR==1));
N(WAR==0)=N(WAR==0)+Nn(WAR==0);  
N(N<20)=0;


end
      
         
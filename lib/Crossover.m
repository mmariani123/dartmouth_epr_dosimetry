function [stdCrossover] = Crossover(spec,stdStart,stdEnd)

%Function originally written by Stephen Marsh at the University of Florida.
%crossover  find the cross over of the standard for both the basis spectra and samples
%input is the experiment.spec and experiment.field 
%output is the crossover point of the standard peak
%stdStart=  1600;         %1525; %about 3530 G
%stdSend  =  1800;          %1725; %about 3560 G
%std_start=1525; %about 3530 G
%std_end=1725; %about 3560 G
	
    localMax=[spec(stdStart),0];
    localMin=[spec(stdStart),0];
    
    for i=stdStart:stdEnd
        if spec(i)>localMax(1)
            localMax=[spec(i),i];
        elseif spec(i)<localMin(1)
            localMin=[spec(i),i];
        end
    end
    
    stdCrossover=floor((localMin(2)-localMax(2))/2)+localMax(2)+1;
    
end



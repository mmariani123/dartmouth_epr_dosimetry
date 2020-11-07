function [pre_trun irra_trun cut_trun]=data_align_sm_mike(pre,irra,cut,field)
    pre_trun = alignment_epr(pre,field);
    irra_trun = alignment_epr(irra,field);
    cut_trun = alignment_epr(cut,field);

end

function spectra_truncate = alignment_epr(spectra, field)
    %field is magnetic field data of the spectra
    %spectra size,eg 2048x10
    field_pts = length(field);
    assert(field_pts == 2048);
    
    NPTS=1400;
%    NPTS=700;
    POS=200;
%   POS=100;
    dimz = size(spectra); 
    
    spectra_truncate = zeros(NPTS-POS,dimz(2));
    
    
    for j=1:dimz(2)
        temp = smooth(spectra(:,j),10) ;% smooth(spectra(:,j),10,'lowess',1) ; %malowess(1:length(field),spectra(:,j))    
        StdCrossover = crossover(temp);%crossover(spectra(:,j));
        spectra_truncate(:,j) = spectra(StdCrossover-NPTS+1:StdCrossover-POS,j);
    end
    
    
end

function StdCrossover=crossover(spec)
%crossover  find the cross over of the standard for both the basis spectra and samples
%input is the experiment.spec and experiment.field 
%output is the crossover point of the standard peak
    
    std_start=1570; %about 3450 G
    std_end=1800; %about 3460 G *check this <
	localMax=[spec(std_start),0];
    localMin=[spec(std_start),0];
    for i=std_start:std_end
        if spec(i)>localMax(1)
            localMax=[spec(i),i];
        elseif spec(i)<localMin(1)
            localMin=[spec(i),i];
        end
    end
    if localMin(2)==0 %print error message, Bruker Standard Not Found
    end
    StdCrossover=floor((localMin(2)-localMax(2))/2)+localMax(2);

    
end
    
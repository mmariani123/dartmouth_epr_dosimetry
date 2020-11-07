function [pre_trun irra_trun cut_trun]=data_align(pre,irra,cut,field)
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
    
    POS=200;
   
    dimz = size(spectra); 
    
    spectra_truncate = zeros(NPTS-POS,dimz(2));
    
    
    for j=1:dimz(2)
        temp = malowess(1:length(field),spectra(:,j));       
        StdCrossover =crossover(temp);
        spectra_truncate(:,j) = spectra(StdCrossover-NPTS+1:StdCrossover-POS,j);
    end
    
    
end

function StdCrossover=crossover(spec)
%crossover  find the cross over of the standard for both the basis spectra and samples
%input is the experiment.spec and experiment.field 
%output is the crossover point of the standard peak
    
    std_start=1570; %about 3540 G
    std_end=1680; %about 3548 G
	
    for i=std_start:std_end
        if spec(i)*spec(i+1)<=0
            if spec(i)<=abs(spec(i+1))
                StdCrossover=i;
            else StdCrossover=i+1;
            end
            break
        end
    end
end


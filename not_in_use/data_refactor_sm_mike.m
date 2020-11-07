function [pre_re irra_re cut_re fieldVal]=data_refactor_sm_mike(pre,irra,cut,field)
    [fieldVal, pre_re] = resize_epr(pre,field);
    [~, irra_re] = resize_epr(irra,field); % ~ = ignore output
    [~, cut_re] = resize_epr(cut,field);

end

function [x2 spectra_truncate] = resize_epr(spectra, field)         %spectra is 1020 x 10 here.
    %field is magnetic field data of the spectra
    %spectra size,eg 1020x10
    field_pts = length(field);  %2048 for Bruker machine at Rubin, 1020 for UF group.
    assert(field_pts == 1020);
    dimz = size(spectra); 
    newMatrixLength = 2360;
    finalLength = newMatrixLength -(2048 -1);   %FinalLength = 311
    x2=linspace(min(field),max(field),newMatrixLength); %takes 150 gauss and divides it into newMatrixLength number of divisions, note that max and min are INCLUDED within the total number of points.
    spectra_truncate = zeros(newMatrixLength,dimz(2));
    for j=1:dimz(2)
        temp = (pchip(field,spectra(:,j),x2))';% could also use spline in the same fashion as pchip.  pchip is 'Piecewise Cubic Hermite Interpolating Polynomial'.
        StdCrossover = refcrossover(temp);%refcrossover(spectra(:,j));
        spectra_truncate(:,j) = temp - StdCrossover(1); %MakeBrukerZero
    end
spectra_truncate = spectra_truncate(finalLength:end,:);
x2 = x2(:,finalLength:end);
end

function StdCrossover=refcrossover(spec)
%refcrossover  find the cross over of the standard for both the basis spectra and samples
%input is the experiment.spec and experiment.field 
%output is the crossover point of the standard peak
    
    std_start=1950; %about 3450 G
    std_end=2060; %about 3460 G
    brukerMax=[spec(std_start),0];
    brukerMin=[spec(std_start),0];
    for i=std_start:std_end
        if spec(i)>brukerMax(1)
            brukerMax=[spec(i),i];
        elseif spec(i)<brukerMin(1)
            brukerMin=[spec(i),i];
        end
    end
    
    StdCrossover=[0 0];%creates/initializes a variable which will be returned
    StdCrossover(1)=(brukerMax(1)-brukerMin(1))/2 +brukerMin(1);%generates the value at which Bruker Standard will cross zero
    StdCrossover(2)=floor((brukerMin(2)-brukerMax(2))/2)+brukerMax(2);%generates the index at which Bruker Standard (approximately) crosses zero
end
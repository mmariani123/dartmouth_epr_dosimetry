function [] = SpectraColumnCheck(spectraIn,numSpectraPoints)
    %Checks if spectraIn column length is equal to numSpectraPoints.
   
    sizeSpectraColumn=size(spectraIn,1);
    if(sizeSpectraColumn ~= numSpectraPoints)
    error('Spectral data may not be in column form!');
    end
    
end
function [spectraTruncate spectraOut crossoverPoints] = AlignmentEPR(spectraIn, numSpectraPoints, correctOffset, stdStart, stdEnd, posDown, posUp)
 
    
    SpectraColumnCheck(spectraIn,numSpectraPoints);
    
    sizeSpectra = size(spectraIn,2);
    spectraTruncate = zeros(posDown+posUp,sizeSpectra);             %zeros(NPTS-POS,dim(2)) for Xiaoming.
    
    for j=1:sizeSpectra
        temp = SmoothCorrect(1:numSpectraPoints,spectraIn(:,j),0.05,'lowess');
        StdCrossover = Crossover(temp,stdStart,stdEnd);
        offset = temp(StdCrossover);    
            if correctOffset == true                   
               spectraIn(:,j) = spectraIn(:,j) - offset;
               spectraOut(:,j) = spectraIn(:,j);
            else
               spectraOut(:,j) = spectraIn(:,j);
            end
        %Note that below smoothing is only used to find the standard
        %spectraOut is not affected by below smoothing.
        spectraTruncate(:,j) = spectraIn(StdCrossover-posDown+1:StdCrossover+posUp,j);    
        crossoverPoints(j) = StdCrossover;
    end
end
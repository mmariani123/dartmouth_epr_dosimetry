function [fieldArray crossoverPointsArray crossoverPointsGaussArray fieldStart fieldStop] = ...
    PointsConvertGauss(numSpectraPoints,truncateSpectra,numTruncPoints,crossoverPoints,posDown,posUp)

fieldStart = fieldCenter - fieldWidth/2;
fieldStop = fieldCenter + fieldWidth/2;
fieldIncrement = (fieldWidth)/numSpectraPoints;
fieldArray(1) = fieldStart;
for fieldArrayCounter = 2:numSpectraPoints
    fieldArray(fieldArrayCounter) = fieldArray(fieldArrayCounter-1)+fieldIncrement;
end
fieldArray = fieldArray(:);

if truncateSpectra == true
    crossoverPointsStart = crossoverPoints - posDown;
    crossoverPointsGaussArray = zeros(numTruncPoints,numberOfDoses);
    for i = 1:(posDown+posUp)
        crossoverPointsArray(i) = crossoverPointsStart+i;
        crossoverPointsGaussArray(i) = fieldArray(crossoverPointsStart)+i*fieldIncrement;
    end
else
    crossoverPointsArray = [];
    crossoverPointsGaussArray = [];
end


end
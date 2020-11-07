function results = DataFit(spectraIn,numSpectraPoints,basis,pointsToFit,fitType,fitStart,fitStop,normalize,normalizeValues)

% DataFit() fits the input spectrum based on the given basis spectrum(a).
% individual spectra to be in column format.
% The output 'amplitudes' are the signal amplitudes fitted basis spectra.
% fitted are the fitted spectra of spectraIn.
% leftover are the difference between fitting spectrum(a) and spectraIn.
% The output 'resNorm' is the sum of squared residuals after fitting. 
% Using inf or -inf  instead of large numbers for upper and lower bounds of lsqlin() seems to create issues.

results.amplitudes = [];
results.resNorm = [];
results.residual = [];
results.fitted = [];
results.fittedTotal = [];

SpectraColumnCheck(spectraIn,numSpectraPoints);
SpectraColumnCheck(basis,pointsToFit);
numSpectraColumns = size(spectraIn,2);
numBasisColumns  = size(basis,2);
initialData = spectraIn(fitStart:fitStop,:);
normalizeValues = normalizeValues(:);

fitLength = abs(fitStop-fitStart)+1;
initialDataRaw = zeros(fitLength,numSpectraColumns);
%basis = basis(fitStart:fitStop,:);
lengthNow = length(fitStart:fitStop);
%amplitudes = zeros(spectraRowSize,numBasisColumns);      
for i=1:numSpectraColumns          
    spec = initialData(:,i);    %1 to 1200 usually.
    if fitType == 0
        coef = basis\spec;
    elseif fitType == 1
        coef = lsqlin(basis,spec,[],[],[],[],[0,-10000,-10000],[10000,10000,10000],[]);
    else
        error('Must choose appropriate fit type!');
    end
    amplitudes = coef(:);
    results(i).amplitudes = amplitudes;
    for j = 1:numBasisColumns 
        results(i).residual(:,j) = spec - basis(:,j).*results(i).amplitudes(j);
        results(i).resNorm(:,j) = sum(results(i).residual(:,j).^2);
        results(i).fitted(:,j) = ((basis(:,j).*results(i).amplitudes(j)));
    end
results(i).fittedTotal = sum(results(i).fitted,2); 
if normalize == true
    results(i).amplitudes = amplitudes./normalizeValues(i);
else
    results(i).amplitudes = amplitudes;
end
end 
end
      








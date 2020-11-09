classdef AnalyzeClass < handle

%good to inherit from handle superclass.
    
properties(Access = public)
% define the properties of the class here, (like fields of a struct)

spectraIn;
numSpectraPoints;
basis;
pointsToFit;
fitType;
fitStart;
fitStop;
normalize;
normalizeValues;

amplitudes = [];
resNorm = [];
residual =[];
fitted =[];
fittedTotal =[];

end

methods(Access = public)
    
function obj = AnalyzeClass(spectraIn,basis,numSpectraPoints,pointsToFit,fitType,fitStart,fitStop,normalize,normalizeValues)
    % class constructor
    if(nargin > 0)       
        obj.spectraIn = spectraIn;
        obj.basis = basis;
        obj.numSpectraPoints = numSpectraPoints;
        obj.pointsToFit = pointsToFit;
        obj.fitType = fitType;
        obj.fitStart = fitStart;
        obj.fitStop = fitStop;
        obj.normalize = normalize;
        obj.normalizeValues = normalizeValues;
        obj.amplitudes;
        obj.resNorm;
        obj.residual;
        obj.fitted;
        obj.fittedTotal;
    end
end

function obj = DataFit(obj)

% DataFit() fits the input spectrum based on the given basis spectrum(a).
% individual spectra to be in column format.
% The output 'amplitudes' are the signal amplitudes fitted basis spectra.
% fitted are the fitted spectra of spectraIn.
% leftover are the difference between fitting spectrum(a) and spectraIn.
% The output 'resNorm' is the sum of squared residuals after fitting. 
% Using inf or -inf  instead of large numbers for upper and lower bounds of lsqlin() seems to create issues.

spectraIn = obj.spectraIn;
numBasisColumns  = size(obj.basis,2);
initialData = spectraIn(obj.fitStart:obj.fitStop,:);
normalizeValues = obj.normalizeValues(:);
basis=obj.basis;

fitLength = abs(obj.fitStop-obj.fitStart)+1;
initialDataRaw = zeros(fitLength,1);
%basis = basis(fitStart:fitStop,:);
lengthNow = length(obj.fitStart:obj.fitStop);
%amplitudes = zeros(spectraRowSize,numBasisColumns);               
    spec = initialData(:,2);    %1 to 1200 usually.
    if obj.fitType == 0
        coef = basis\spec;
    elseif obj.fitType == 1
        coef = lsqlin(basis,spec,[],[],[],[],[0,-10000,-10000],[10000,10000,10000],[]);
    else
        error('Must choose appropriate fit type!');
    end
    
    obj.amplitudes = coef(:); 
    for j = 1:numBasisColumns 
        obj.residual(:,j) = spec - basis(:,j).*obj.amplitudes(j);
        %obj.resNorm(:,j) = sum(results(i).residual(:,j).^2);
        obj.fitted(:,j) = ((basis(:,j).*obj.amplitudes(j)));
    end
    obj.fittedTotal = sum(obj.fitted,2); 
    if obj.normalize == true
        obj.amplitudes = amplitudes./normalizeValues(i);
    end
end

function [backAmp] = BackgroundAmplitude(backgroundIn)

    %subtract these two kinds of spectra
    %then get the amplitude using p2p or fitting
    specAmp = backgroundIn;
    specAmp = specAmp(1:1200,:);
    
    for i = 1:size(specAmp,2)
        specAmp(:,i) = smoothCorrect(1:size(specAmp,1),specAmp(:,i),0.05,'lowess');
    end
    
    backAmp = range(specAmp(600:1000,:));
    backAmp = backAmp;

end

function [RISamp] = AverageZeroGray(inputSpectra)

countC = 0;
    
    for c = 1:dosesToPlot
        if dosesToPlot(c) == 0
            countC  = countC + 1;
        end
    end
    
    for c2 = 1:length(dosesToPlot)
        if dosesToPlot(c2)<= countC
            RISamp(c2,1) = mean(RISspec(600:800,c2))-mean(RISspec(800:1000,c2));
            %RISamp(c2,1) = mean(pre_trun(600:800,c2)) - mean(pre_trun(800:1000,c2));
            %RISamp(c2,1) = mean(RIS_pure(740:760,c2))-mean(RIS_pure(840:860,c2));     %740 to 760     840 to 860
            %Peak around 750 and 850
       end
    end

end

%This SEP routine is taken from Xiaoming He's PhD thesis.

function [sep] = SEP(x,y,a,b)

for i = 1:length(y)
    y(i) = y(i)-a;
end

y = y./b;

for j = 1 : length(x)
    z(j) = x(j) - y(j);
    z(j) = z(j)^2;
end

sumNow = sum(z);

sep = sqrt(sumNow/(length(z)-2));       

end


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
      
end


%SETTERS AND GETTERS BELOW

methods

function amplitudes = get.amplitudes(obj)
    amplitudes = obj.amplitudes;
end
       
end


methods(Static)
    
   function crossovers = Crossover(spec,stdStart,stdEnd)

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
    
    crossovers=floor((localMin(2)-localMax(2))/2)+localMax(2)+1;
    
    end
    
end

end


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
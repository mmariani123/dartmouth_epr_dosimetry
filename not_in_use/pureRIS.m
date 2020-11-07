function [RISamp,RISspec] = pureRIS(data_preirra, data_irra)
    %subtract these two kinds of spectra
    %then get the amplitude using p2p or fitting
    RISspec = data_irra - data_preirra;
    %p2p after smooth
    for i = 1:size(RISspec,2)
        RISspec(:,i) = malowess(1:size(RISspec,1),RISspec(:,i));
    end
    RISamp = range(RISspec(600:1000,:));
    RISamp = RISamp';


end
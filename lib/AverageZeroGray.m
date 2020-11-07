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
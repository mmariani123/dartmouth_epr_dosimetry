function [pre_trun irra_trun cut_trun pre irra cut]=data_align_mike(pre,irra,cut,field,correctOffset,stdStart,stdEnd)
    
    [pre_trun  pre]  = alignment_epr(pre,field,correctOffset,stdStart,stdEnd);
    [irra_trun irra] = alignment_epr(irra,field,correctOffset,stdStart,stdEnd);
    [cut_trun  cut]  = alignment_epr(cut,field,correctOffset,stdStart,stdEnd);

end

                
    







  




%step 1: read EPR spectra
[pre irra cut field]=data_read();
%step 2: align EPR spectra based on the standard field postion
[pre_trun irra_trun cut_trun]=data_align(pre,irra,cut,field);

%step 3: fitting to obtain the amplitude and shape of MIS and RIS
load BASE;
data_postcut = cut_trun - pre_trun;
[amplitude,fitted, MIS_est, RIS_est, leftover]=data_fit(data_postcut,BASE);

%step 4: use direct subtraction to get pure RIS
[RISamp,RIS_pure] = pureRIS(pre_trun, irra_trun);

load xtrun;

%input the mass data (column vector)
% mass=[10.3;9.0;12.4; 8.9; 10.1];

%compute mass normalized RIS
%{
ris_norm_est = amplitude(:,1)./mass;
ris_norm_pure = RISamp./mass;

dose =[0 1 2 4 6]';
m_est=polyfit(dose,ris_norm_est,1);
m_pure=polyfit(dose,ris_norm_pure,1);
xfull = (0:0.5:10)';
yfulla=m_est(1)*xfull+m_est(2);
yfullb=m_pure(1)*xfull+m_pure(2);

%}
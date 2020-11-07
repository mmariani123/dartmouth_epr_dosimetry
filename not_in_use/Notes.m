%Notes




%3420 to 3580 gauss
%1200/160 = 7.500 points/gauss
%(3545 - 3420)*7.500 = point position = 937.50


%strcat chomps trailing spaces in strings. You might want to just use
%matrix concatenation (horzcat):



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


%'loess' uses 1st degree polynomial
%'lowess' uses 2nd degree polynomial

%[z,p,k] = butter(9,300/500,'high');
%[sos,g] = zp2sos(z,p,k);      % Convert to SOS form
%Hd = dfilt.df2tsos(sos,g);   % Create a dfilt object
%h = fvtool(Hd);              % Plot magnitude response
%set(h,'data_postcut(:,z)','freq')      % Display frequency response 



%{
if size(dosesToRemove) == [0,0]
else
sizePlots = size(dosesToRemove)
sizePlots = sizePlots(2)
for countPlots = 1 : sizePlots
    mass(dosesToRemove(countPlots)) = [0];
end
end
%}
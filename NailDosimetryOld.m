% NAIL DOSIMETRY V3.2            
% The new architecture is intended to allow a variety of different expeirmental 
% analysis procedures to be run. Inclusion of Temperature Study procedure
% file.  Use of PointsConvertGauss function.  Note that for spectra after
% alignement gauss field x-axis values will be innapropriate because Bruker
% Standard appears at different field value for each set of scans.
% Excetion Handling done with and/or conditional use of error() function
% and or try catch throw (Not much difference in MATLAB).
% Data is preferentially maintained in columns. 

donorID = '1299';                   %Enter ID string here after 'ID'
fitType = 0;                        %use 0 for old fit '\' and 1 for new fit 'lsqlin()'.
stdStart = 1500;                    %Points looks for Bruker Standard Start  1525(DHMC or UF) 1700(chemistry).
stdEnd   = 1800;                    %Points looks for Bruker Standard Stop   1725(DHMC or UF) 1900(chemistry).
numSpectraPoints = 2048;            %Initial Number of points in each spectra;  
scansToAverage = 5;                 %Number of scans that make up each spectra and are to be averaged.
smoothPostCut = true;               %If post_cut data is to be smoothed before fitting.  Default should be true.
timesSmoothPostCut = 1;             %How many iterations of smoothing for post_cut data.    
smoothRIS = true;                   %This just smooths RIS for presentation and does not affect point to point which also uses smoothing.
timesSmoothRIS = 1;                 %Number of times to smooth RIS before amplitude is calculated.
fitRIS = true;                      %set to true if RIS values for pre and irra spectra are to be determined by fitting rather than range() function in pureRIS.m, this is important variable!
dataFileType = '*.spc';             %Choose the file type of your data: '*.dta' and '*.spc' are most common.
experimentType = 'tbi';             %There are six options currently: 'original', 'cut', 'uf', 'ris5', 'temperature','tbi'.
MISType = '2comp';                  %Use '1comp' or '2comp' here.
dosesToPlot = [0 2];                %Enter the doses to be plotted.
dosesToRemove = [];                 %Enter the number of the dose in the list to remove e.g. 1 2 3 4 5 etc.

subtractBackground = true;          %If would like to subtract background in analysis.
rotateAxes = false;                 %Rotate x axes for figures 4 and 5 of in 'original' mode.

%Enter labels, index '{n}' cannot exceed number doses in 'dosesToPlot'
labelString = '10172013a';          %Use Backslash to escape underscores etc.
label = cell(1,length(dosesToPlot));
label(:) = {'empty'};            
label{1} = strcat(labelString,'\_1');
label{2} = strcat(labelString,'\_2');
%label{3} = strcat(labelString,'\_3');
%label{4} = strcat(labelString,'\_4');
%label{5} = strcat(labelString,'\_5');
%label{6} = strcat(labelString,'\_6');     

%Enter masses, index '(n)' cannot exceed number of doses in 'dosesToPlot'.
%Enter a mass for each dose in dosesToPlot corresponding to the order they appear.
mass = [];
mass(1) = 6.8;                      
mass(2) = 16.8;
%mass(3) = 19.4;
%mass(4) = 16.7;
%mass(5) = 14.9;
%mass(6) = 16.8;




%EXTRA:---------------------------------------------------------------------------------------------------
correctOffset = false;              %Most helpful in vertically aligning spectra from UF.
resizeSpectra = false;              %Most helpful in resizing spectra from University of Florida.
resizeNumPoints = 2048;             %Points desired after resizing, only used when resizeSpectra = true. 
numFitPoints = 1200;                %Equal to (fitStop-fitStart)+1, must be equal to number of points in basis spectrum(a).
fitStart = 1;                       %Begining point of section of spectra to be fit.
fitStop = 1200;                     %Stopping point of section of spectra to be fit.
posDown = 1400;                     %Number of points included downfield of Bruker Standard. Originally 1400 for Xiaoming.
posUp = 200;                        %Number of points included upfeild of Bruker Standard.  Originally 300 for Xiaoming. %May want to switch posUP to point possition e.g. '1700' etc.
                                    %NOTE THAT SLIGHT VARIATION IN POS UP
                                    %WILL AFFECT SMOOTHING OF BRUKER STANDARD DURING
                                    %ALIGNEMENT AND THUS SLIGHTLY AFFECT %SEP.
correctActual = false;              %corrects the two zero gray 'actual' RIS amplitudes using averaging etc. (does not do fitting). Only use when subtractBackground = true.
averageZero = false;                %If correct actual = true, and you would like the two zero gray doses to be averaged. Only use when subtractBackground = true.
smoothRange = false;                %Only for use when using the range function (when fitRIS =false).  May help reduce actual RIS SEP a little (06132013 test data).
timesSmoothRange = 1;               %How many times to smooth the RIS data that is input to the range() function (smoothRange must be set to 'true').
useXtrun = true;                    %When set to true will use Xiaoming's old 'xtrun' x-axis (gauss) values for figures 5 and 6.

%Temperature Study Variables
numExp = 1;                         %Number of Different temp runs being analyzed.
numDays = 7;                        %Number of temperature trials for each experiment.
tempPlotAllTogether = false;        %For 'temp' experiment.  If 'true' plots all temp data together, else plots individually.
tempTruncate = false;               %Does the 'temp' data need to be truncated at all for analysis purposes?
expTemps = {'Minus 80'};            %Enter the Names of the various experiments. 

%UF Only:
cutLengths = [1.0,2.0,3.0];         %Enter cut lengths in mm.

%---------------------------------------------------------------------------------------------------------

%Paths of Basis Spectra:
%Very small variances in result SEPs using excel bases versus original .mat
%bases. 
excel = false;
if excel == true
risBase         = xlsread('C:\Users\f000mps\Desktop\michael_mariani_files_2012-2014\Nail_Dosimetry\Nail_Dosimetry_Software\NailDosimetryV3.2\Spectral_Bases\basis_ris.xlsx');
risMisBase2comp = xlsread('C:\Users\f000mps\Desktop\michael_mariani_files_2012-2014\Nail_Dosimetry\Nail_Dosimetry_Software\NailDosimetryV3.2\Spectral_Bases\basis_ris_mis_composite.xlsx');
risMisBase3comp = xlsread('C:\Users\f000mps\Desktop\michael_mariani_files_2012-2014\Nail_Dosimetry\Nail_Dosimetry_Software\NailDosimetryV3.2\Spectral_Bases\basis_ris_mis_broadsinglet_doublet.xlsx');
BackgroundBase  = xlsread('C:\Users\f000mps\Desktop\michael_mariani_files_2012-2014\Nail_Dosimetry\Nail_Dosimetry_Software\NailDosimetryV3.2\Spectral_Bases\basis_background.xlsx');
xtrun           = xlsread('C:\Users\f000mps\Desktop\michael_mariani_files_2012-2014\Nail_Dosimetry\Nail_Dosimetry_Software\NailDosimetryV3.2\Spectral_Bases\xtrun.xlsx');
else
load 'C:\Users\f000mps\Desktop\michael_mariani_files_2012-2014\Nail_Dosimetry\Nail_Dosimetry_Software\NailDosimetryV3.2\Spectral_Bases\OldBases\BASERIS'
load 'C:\Users\f000mps\Desktop\michael_mariani_files_2012-2014\Nail_Dosimetry\Nail_Dosimetry_Software\NailDosimetryV3.2\Spectral_Bases\OldBases\BASE';
load 'C:\Users\f000mps\Desktop\michael_mariani_files_2012-2014\Nail_Dosimetry\Nail_Dosimetry_Software\NailDosimetryV3.2\Spectral_Bases\OldBases\BASEcombined';
load 'C:\Users\f000mps\Desktop\michael_mariani_files_2012-2014\Nail_Dosimetry\Nail_Dosimetry_Software\NailDosimetryV3.2\Spectral_Bases\OldBases\BackgroundBasis';
load 'C:\Users\f000mps\Desktop\michael_mariani_files_2012-2014\Nail_Dosimetry\Nail_Dosimetry_Software\NailDosimetryV3.2\Spectral_Bases\OldBases\xtrun';
risBase = BASERIS;
risMisBase2comp = BASE;
risMisBase3comp = BASEcombined;     %Are columns arranged appropriately in this file?
BackgroundBase = BackgroundBasis;
xtrun = xtrun;
end

%--------------------------------------------------------------------------------------------------

BeginAnalysis;
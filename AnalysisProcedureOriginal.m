%ANALYSIS PROCEDURE ORIGINAL


%Step 1: read EPR spectra.

[pre preField nailDataPre]    = DataRead(folderName1,dataFileType,numberOfDoses,dosesToRemove,numSpectraPoints,scansToAverage);
[irra irraField nailDataIrra] = DataRead(folderName2,dataFileType,numberOfDoses,dosesToRemove,numSpectraPoints,scansToAverage);
[cut cutField nailDataCut]    = DataRead(folderName3,dataFileType,numberOfDoses,dosesToRemove,numSpectraPoints,scansToAverage);

preNext  = zeros(numSpectraPoints,numberOfDoses);
irraNext = zeros(numSpectraPoints,numberOfDoses);
cutNext  = zeros(numSpectraPoints,numberOfDoses);

if resizeSpectra == true    
for q = 1:numberOfDoses
    preNext(:,q)   = ResizeSpectraFactor(pre(:,q));
    irraNext(:,q)  = ResizeSpectraFactor(irra(:,q));
    cutNext(:,q)   = ResizeSpectraFactor(cut(:,q));
end
pre = preNext;
irra = irraNext;
cut = cutNext;
end


%Step 2: align EPR spectra based on the standard field postion.


[preTrun  pre crossoverPointsPre]   = AlignmentEPR(pre,numSpectraPoints,correctOffset,stdStart,stdEnd,posDown,posUp);
[irraTrun irra crossoverPointsIrra] = AlignmentEPR(irra,numSpectraPoints,correctOffset,stdStart,stdEnd,posDown,posUp);
[cutTrun  cut crossoverPointsCut]   = AlignmentEPR(cut,numSpectraPoints,correctOffset,stdStart,stdEnd,posDown,posUp);


%Step 3: fitting to obtain the amplitude and shape of MIS and RIS.

if correctActual == true
   correctActualBasis = BackgroundBase;
else
   correctActualBasis = risBase;
end

if subtractBackground == true
dataPostCut = cutTrun - preTrun;
else
dataPostCut = cutTrun;
end

dataPostCutRaw = dataPostCut;

if smoothPostCut == true;
    for z = 1 : numberOfDoses;
        for z2 = 1:timesSmoothPostCut
            dataPostCut(:,z) = SmoothCorrect([1:length(dataPostCut)],dataPostCut(:,z),0.05,'lowess');
        end
    end
end
    
if MISType == '1comp'
    basis = risMisBase2comp;
else MISType == '2comp'
    basis = risMisBase3comp;
end

fitRIS1 = false;
[amplitudes, fitted, MISTotalEst, MIS1est, MIS2est, RISest, residual, resNorm, residualRaw]=DataFit(dataPostCut,dataPostCutRaw,posDown+posUp,basis,fitType,fitRIS1,MISType,fitStart,fitStop,correctActual,correctActualBasis);

[RISampPre,RISpurePre] = PureRIS(preTrun, preTrun, false, smoothRIS, timesSmoothRIS, smoothRange, timesSmoothRange,averageZero,dosesToPlot,fitRIS,BackgroundBase,fitType,correctActual,correctActualBasis,numFitPoints,posDown,posUp);
[RISampIrra,RISpureIrra] = PureRIS(preTrun, irraTrun, subtractBackground, smoothRIS, timesSmoothRIS, smoothRange, timesSmoothRange,averageZero,dosesToPlot,fitRIS,risBase,fitType,correctActual,correctActualBasis,numFitPoints,posDown,posUp);


%Step 4: Preparing Variables for Plots.

donorIDString = horzcat('Donor ID: ',donorID);
totalMass = 0;
for numMass = 1: length(mass)
    totalMass = totalMass + mass(numMass);
end

[fieldArray crossoverPointsCutArray crossoverPointsCutGaussArray fieldReturn spectraReturn paramReturn fieldStart fieldStop] = PointsConvertGauss(numSpectraPoints, true, numFitPoints, numberOfDoses, crossoverPointsCut, parameterPathName, parameterFileName, posDown, posUp);

risNormEst = amplitudes(:,1)./mass; %normally amplitude(:,1) with normal basis (2 component).
risNormPure = RISampIrra./mass;

[slopeEst offsetEst]=polyfit(dosesToPlot,risNormEst,1);
[slopePure offsetPure]=polyfit(dosesToPlot,risNormPure,1);
 
xfull=(0:0.5:10)';
yfulla=slopeEst(1)*xfull+slopeEst(2);
yfullb=slopePure(1)*xfull+slopePure(2);

x1 = dosesToPlot;
y1 = risNormEst;
a1 = slopeEst(2);
b1 = slopeEst(1);
sepReturn1 = SEP(x1,y1,a1,b1);
rSquared1 = 1 - offsetEst.normr^2 / norm(risNormEst-mean(risNormEst))^2;

x2 = dosesToPlot;
y2 = risNormPure;
a2 = slopePure(2);     %offset
b2 = slopePure(1);     %slope
sepReturn2 = SEP(x2,y2,a2,b2);
rSquared2 = 1 - offsetPure.normr^2 / norm(risNormPure-mean(risNormPure))^2;
    
totalMassString = num2str(totalMass);   % mat2str() turns matrix into string.
totalMassStringFull = horzcat('Total Sample Mass:',' ',totalMassString,' ','mg');
sepReturnString1 = num2str(sepReturn1);
sepReturnString1Full = horzcat('Est SEP: ',sepReturnString1,' ','Gy');
rSquaredString1 = num2str(rSquared1);
rSquaredString1Full = horzcat('Est R^2',':',' ',rSquaredString1);
sepReturnString2 = num2str(sepReturn2);
sepReturnString2Full = horzcat('Act SEP: ',sepReturnString2,' ','Gy');
rSquaredString2 = num2str(rSquared2);
rSquaredString2Full = horzcat('Act R^2',':',' ',rSquaredString2);
a1String = num2str(abs(a1));
b1String = num2str(b1);
a2String = num2str(abs(a2));
b2String = num2str(b2);
line1StringFull = horzcat('Est  y = ',b1String,'x',' ',LineSign(a1),' ',a1String);
line2StringFull = horzcat('Act  y = ',b2String,'x',' ',LineSign(a2),' ',a2String);

backAmp = [];
pureStart = 401;
pureEnd = 1200;
for backCounter = 1:numberOfDoses
RISpurePreNow(:,backCounter) = RISpurePre(pureStart:pureEnd,backCounter);
backAmp(backCounter) = range(RISpurePreNow(:,backCounter));
end
backAmpNorm = (backAmp')./mass;

if useXtrun == true
    start = [1:(posUp+(posDown-length(xtrun)))];
    %Code Below converts from points into Gauss.
    start(1) = xtrun(numFitPoints);
        for addCount = 2:length(start)
            start(addCount) = start(addCount-1)+0.0732;
        end
    xtrunNew = cat(2,xtrun,start)'
    xAxisValue  = xtrunNew;
    xAxisValues = repmat(xAxisValue,1,numberOfDoses);
else
    xAxisValues = crossoverPointsCutArray;
end
    xAxisStart  = xAxisValues(1);
    xAxisStop   = xAxisValues(end);

%Plot the actual RIS and the estimated RIS.
%Adjustment of y-axis for figure 5. 
if subtractBackground == true
    plotSize1 = -200;
    plotSize2 =  200;
else
    plotSize1 = -400;
    plotSize2 =  400;
end

%step 5: Retrun values to console:

Background_Amplitude_Normalized    = backAmpNorm
RIS_Amplitude_Estimated_Normalized = risNormEst 
RIS_Amplitude_Actual_Normalized    = risNormPure 
Sum_Squared_Residuals_From_Figure4 = resNorm'

%Step 6: Make the plots.

%Plot the spectra before irradiation.
figure(1)
clf
plot(fieldArray,pre)
xlabel('Magnetic Field (gauss)');
ylabel('Signal Amplitude (AU)');
legend(label); %change the name accordingly to your sample name
title('Pre-Irradiated Spectra');

%Plot the spectra after irradiation.
figure(2)
clf
plot(fieldArray,irra)
xlabel('Magnetic Field (gauss)');
ylabel('Signal Amplitude (AU)');
legend(label);  %change the name accordingly to your sample name
title('Irradiated Spectra');

%Plot the spectra after cutting.
figure(3)
clf
plot(fieldArray,cut)
xlabel('Magnetic Field (gauss)');
ylabel('Signal Amplitude (AU)');
legend(label);%change the name accordingly to your sample name
title('Post-Cut Spectra');

%Plot the original spectra and the fitted spectra.
figure(4)
clf
for i=1:numberOfDoses
subplot(2,3,i);
plot(xAxisValues(fitStart:fitStop,i),dataPostCut(fitStart:fitStop,i),'b','linewidth',2);
%axis([1,numSpectraPoints,-200,200]);
axis([xAxisStart,xAxisStop,plotSize1,plotSize2]);
set(gca, 'xTickLabel', num2str(get(gca,'xTick')','%g'))  %can use %E or %e as well or %.2g.
if rotateAxes == true
rotateXLabels(gca,45);
end
hold on
plot(xAxisValues(fitStart:fitStop,i),fitted(:,i),'r','linewidth',2);
%title(sprintf('normR^2 = %i', resNorm(i)));
end
Suptitle('Fitted MIS + RIS and Post-Cut Spectra');
% determine position of the axes
axp = get(gca,'Position');
% determine startpoint and endpoint for the arrows 
%xs=axp(1);
xs = 0.07;
xe=axp(1)+axp(3)+0.05;
%ys=axp(2);
ys = 0.05;
ye=axp(2)+axp(4)+0.5;
% make the arrows
annotation('arrow', [xs xe],[ys ys],'LineWidth',2);
annotation('arrow', [xs xs],[ys ye],'LineWidth',2);
if useXtrun == true
ylabel('Signal Amplitude (AU)','color','k','FontSize',12);
xlabel('Magnetic Field (gauss)','color','k','FontSize',12);
else
ylabel('Signal Amplitude (AU)','color','k','FontSize',12);
xlabel('Magnetic Field (sweep points)','color','k','FontSize',12);
end

figure(5)
clf
for i=1:numberOfDoses
subplot(2,3,i);
plot(xAxisValues(:,i),RISpureIrra(:,i),'b','linewidth',2);
axis([xAxisStart,xAxisStop,plotSize1,plotSize2]);
set(gca, 'xTickLabel', num2str(get(gca,'xTick')','%g'))  %can use %E or %e as well or %.2g.
if rotateAxes == true
rotateXLabels(gca,45); 
end
hold on
plot(xAxisValues(fitStart:fitStop,i),RISest(:,i),'r','linewidth',2);
end
Suptitle('Actual and Estimated RIS Spectra');
% determine position of the axes
axp = get(gca,'Position');
% determine startpoint and endpoint for the arrows 
%xs=axp(1);
xs = 0.07;
xe=axp(1)+axp(3)+0.05;
%ys=axp(2);
ys = 0.05;
ye=axp(2)+axp(4)+0.5;
% make the arrows
annotation('arrow', [xs xe],[ys ys],'LineWidth',2);
annotation('arrow', [xs xs],[ys ye],'LineWidth',2);
if useXtrun == true
ylabel('Signal Amplitude (AU)','color','k','FontSize',12);
xlabel('Magnetic Field (gauss)','color','k','FontSize',12);
else
ylabel('Signal Intensity (AU)','color','k','FontSize',12);
xlabel('Magnetic Field (sweep points)','color','k','FontSize',12);
end

%Plot the dose-response curve.
figure(6)
clf
plot(dosesToPlot,risNormEst,'s','markerfacecolor','r','markeredgecolor','r');
hold on
plot(dosesToPlot,risNormPure,'o','markerfacecolor','b','markeredgecolor','b');
plot(xfull,yfulla,'r','linewidth',2);
plot(xfull,yfullb,'b','linewidth',2);
xlabel('Dose (gray)');
ylabel('RIS Amplitude (Mass Normalized)');
legend('Estimated RIS','Actual RIS');
text('String',{totalMassStringFull;donorIDString;sepReturnString1Full;rSquaredString1Full;line1StringFull;sepReturnString2Full;rSquaredString2Full;line2StringFull});
title('Dose-Response Curve');
plotedit on;

%Plot background signal versus nail mass:
figure(7)
clf
plot(dosesToPlot,backAmpNorm,'o','markerfacecolor','g','markeredgecolor','g')
xlabel('Dose (gray)');
ylabel('Background  Amplitude (AU)');
axis([0,10,0,50]);
title('Background Signal (Mass Normalized)');

%{
%Plot residuals after fitting like Xiaomoing did for thesis. 
excelFile = 'C:\Users\f000mps\Desktop\05052014_xiaoming_residuals_sets_1-5.xlsx'
%xlswrite(excelFile,residualRaw);
%file directory
file = 'C:\Documents and Settings\desktop\rarb.xls'
% store data of file in variable a
residualData = xlsread('C:\Users\f000mps\Desktop\05052014_xiaoming_residuals_sets_1-5.xlsx');
% new data to write in file
t = ones(1,10)
% last row with data in the file
ncolumns = (size(residualData,2));
% plus 1 to write in the next line (if you have an header it should be + 2)
ncolumns = ncolumns +1;
% convert number to string
b = num2str(ncolumns)
% if you want to add data to the column A you make concat strings
c = strcat('A', b)
% right to file the data t on the sheet Folha1 begining in the row c (e.g. A20)
%xlswrite(excelFile,residualRaw, 'Y1:AD1200'); 



figure(8)
clf
set(gcf,'color','w');
for residualCounter = 1:30
subplot(5,6,residualCounter);
plot(1:1200,residualData(:,residualCounter),'color','k','LineWidth',2)
hold on
axis([0,1200,-200,200]);
set(gca, 'xTickLabel', num2str(get(gca,'xTick')','%g'),'LineWidth',2,'FontSize',12,'FontWeight','bold')  %can use %E or %e as well or %.2g.
end
%legend('1','2','3','4','5','6')
%xlabel('Magnetic Field [G]')
%ylabel('Signal Amplitude')
%axp = get(gca,'Position');
% determine startpoint and endpoint for the arrows 
%xs=axp(1);
%xs = 0.07;
%xe=axp(1)+axp(3)+0.05;
%ys=axp(2);
%ys = 0.05;
%ye=axp(2)+axp(4)+0.5;
% make the arrows
%annotation('arrow', [xs xe],[ys ys],'LineWidth',3);
%annotation('arrow', [xs xs],[ys ye],'LineWidth',3);
%text('String',{'0 Gy'},'FontSize',20)
%text('String',{'0 Gy'},'FontSize',20)
%text('String',{'1 Gy'},'FontSize',20)
%text('String',{'2 Gy'},'FontSize',20)
%text('String',{'4 Gy'},'FontSize',20)
%text('String',{'6 Gy'},'FontSize',20)
%}

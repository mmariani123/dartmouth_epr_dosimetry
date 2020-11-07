fieldStart = 3425;
fieldStop  = 3575;
posDown = 1400;
posUp = 300;


path = uigetdir();
cd(path);
data = dir('*spc'); 
dataSort= [data(:).datenum]
[s,s] = sort(dataSort)
s = {data(s).name}

spectra = zeros(2048,5);
lengthNow = length(data);

fieldWidth = abs(fieldStop-fieldStart);
fieldIncrement = (fieldWidth)/2047;
%fieldArray = [fieldStart:fieldIncrement:fieldStop];
%fieldArray = fieldArray';


[parameterFileName parameterPathName] = uigetfile();
[fieldArray crossoverPointsArray crossoverPointsGaussArray fieldReturn spectraReturn paramReturn fieldStart fieldStop]...
    = PointsConvertGauss(2048,false,[],[],[],parameterPathName,parameterFileName,[],[])

%crossoverPointsCutArray = zeros(1200,12);
cc = hsv(22);
figure(1)
clf
for i = 1:length(data)
    stringNow = strcat(path,'\');
    nameString = strcat(stringNow,data(i).name);
    spectra = eprload(s{i});
    meanNow(:,i) = mean(spectra,2);
    %[spectraTruncate spectraOut crossoverPoints(i)] = AlignmentEPR(meanNow(:,i),2048,false,1400,2000,posDown,posUp);
    %crossoverPoints(i)
    %crossoverPointsCutStart = crossoverPoints(i) - posDown;
    %{
    for z = 1:(posDown+posUp)
    crossoverPointsCutArray(z,i) = fieldArray(crossoverPointsCutStart)+z*0.0732;
    end
    %}
    %plot(crossoverPointsCutArray(:,i),spectraTruncate,'color',cc(i,:));
    %subplot(2,6,i)
    plot(fieldArray,spectra(:,1),'color',cc(i,:));
    %legend(s(i));
    axis([3425 3575 -2200 2200])
    ylabel('signal intensity (AU)');
    xlabel('magnetic field (G)');
    hold on
    
    %04.02.2014
    %ALignement PER : if spectra are shifted along the x-axis then after
    %alignement cannot use a common x-axis unless it is aprox.  Need to
    %check with Steve Swarts.
    
end
figure(1)
%title('MIS amplitude versus time stored in freezer at -20 degrees C');
legend(s,'Interpreter','none')
%suptitle('MIS amplitude versus time stored in freezer at -80 degrees C');
plotedit on

%meanCrossover = mean(crossoverPoints);

figure(2)
clf
plot(fieldArray,meanNow(:,9),'color','r')
hold on
plot(fieldArray,meanNow(:,10),'color','g')
hold on
plot(fieldArray,meanNow(:,22))
legend('Pre-Cut','Cut','21 Day','color','b')
axis([3425 3575 -1000 1000])
ylabel('signal intensity (AU)');
xlabel('magnetic field (G)');

%{
figure(3)
clf
plot(fieldArray,meanNow(:,2),'color','r')
hold on
plot(fieldArray,meanNow(:,11),'color','g')
hold on
plot(fieldArray,meanNow(:,17))
legend('Pre-Cut','Cut','21 Day','color','b')
axis([3425 3575 -2300 2300])
ylabel('signal intensity (AU)');
xlabel('magnetic field (G)');
    
figure(4)
clf
plot(fieldArray,meanNow(:,3),'color','r')
hold on
plot(fieldArray,meanNow(:,6),'color','g')
hold on
plot(fieldArray,meanNow(:,9))
legend('Pre-Irrad','Irrad','7 Day','color','b')
axis([3425 3575 -2000 2000])
ylabel('signal intensity (AU)');
xlabel('magnetic field (G)');
%}    

%{
[fieldReturn,SpectraReturn,paramReturn] = eprload(strcat(parameterPathName,parameterFileName));
fieldCenter = paramReturn.HCF;
fieldWidth = paramReturn.HSW;

fieldStart = fieldCenter - fieldWidth/2;
fieldStop = fieldCenter + fieldWidth/2;

fieldIncrement = (fieldWidth)/2047;
fieldArray = [fieldStart:fieldIncrement:fieldStop];
fieldArray = fieldArray';

crossoverPointsCutStart = crossoverPointsCut - posDown;
crossoverPointsCutArray = zeros(1200,6);
for j = 1:6
    for i = 1:(posDown+posUp)
    crossoverPointsCutArray(i,j) = fieldArray(crossoverPointsCutStart(j))+i*0.0732;
    end
end
%}





%From analysis_procedure

%figure(7)
%clf
%for i = 1:6
    %subplot(2,3,i);
   %superFit = RIS_pure(:,i)
    %[phased(1:1700,i), intPhased(1:1700,i)] = phase_fit(RIS_pure(:,i),-20.0);  %Note the indexing of function returns so that MATLAB does not becoem confused.
    %plot(xtrunNew,phased(:,i));
   %axis([xtrunNew(1),xtrunNew(end),-50,50]);
%end

%figure(8)
%plot(phased(6));

%'Position',[45 235],
%mTextBox = uicontrol('style','text');
%set(mTextBox,'Interpreter','tex');
%set(mTextBox,'String',{totalMassStringFull;sepReturnString1Full;rSquaredString1Full;sepReturnString2Full;rSquaredString2Full});
%set(mTextBox,'BackgroundColor','w');
%set(mTextBox,'FontSize',12);
%annotation('textbox',[0.2 0.4 0.1 0.1], 'String', totalMassString);              %annotation('textbox', [.2 .4 .1 .1], 'String', 'Straight Line Plot 1 to 10');
%plotedit on;
%figure(7)
%plot(irra_trun(:,1) - pre_trun(:,1))
%hold on
%plot(irra_trun(:,2) - pre_trun(:,2))
%hold on
%plot(irra_trun(:,3) - pre_trun(:,3))
%hold on
%plot(irra_trun(:,4) - pre_trun(:,4))
%hold on
%plot(irra_trun(:,5) - pre_trun(:,5))
%hold on
%plot(irra_trun(:,6) - pre_trun(:,6))

%figure(8)
%plot(malowess(1:length(irra_trun(:,1)),irra_trun(:,1)-pre_trun(:,1),'span',0.2))
%hold on
%plot(malowess(1:length(irra_trun(:,1)),irra_trun(:,2)-pre_trun(:,2),'span',0.2))
%hold on
%plot(malowess(1:length(irra_trun(:,1)),irra_trun(:,3)-pre_trun(:,3),'span',0.2))
%hold on
%plot(malowess(1:length(irra_trun(:,1)),irra_trun(:,4)-pre_trun(:,4),'span',0.2))
%hold on
%plot(malowess(1:length(irra_trun(:,1)),irra_trun(:,5)-pre_trun(:,5),'span',0.2))
%hold on
%plot(malowess(1:length(irra_trun(:,1)),irra_trun(:,6)-pre_trun(:,6),'span',0.2))

%figure(9)
%clf
%for i=1:6
%subplot(2,3,i);
%plot(RIS_pure(:,i),'b','linewidth',2);
%hold on
%plot(RIS_est(:,i),'r','linewidth',2);
%end

%figure(10)
%plot(irra-pre)




%From data_fit_mike - alternate fitting routines and methods.

%{
        
        elseif mode == 1
        MIS1 = repmat(basis(:,2),1,dimz(2)).*repmat(amplitude(:,2)',1200,1); %doublet
        MIS2 = repmat(basis(:,3),1,dimz(2)).*repmat(amplitude(:,3)',1200,1); %singlet
        MIS3 = repmat(basis(:,1),1,dimz(2)).*repmat(amplitude(:,1)',1200,1); %broad
        MIS = MIS1+MIS2+MIS3;
        RIScoef = MIS2 - 0.92*MIS3; 
        RIS = repmat(basis(:,3),1,dimz(2)).*repmat(amplitude(:,4)',1200,1);     % Page 148 of Xiaoming's thesis, C = 0.92
        fitted = RIS + MIS;
        elseif mode == 2 
        %normally amplitude(:,1) with normal basis.
        MIS1 = repmat(basis(:,2),1,dimz(2)).*repmat(amplitude(:,2)',1200,1);
        MIS2 = repmat(basis(:,3),1,dimz(2)).*repmat(amplitude(:,3)',1200,1);
        MIS = MIS1 + MIS2;
        RIS = repmat(basis(:,1),1,dimz(2)).*repmat(amplitude(:,1)',1200,1); 
        fitted = RIS + MIS;
        else
        assert('choose mode')
        end
        %}


%if mode == 1
%            amplitudeAdd(i,1) = amplitude(i,3) - 0.92*amplitude(i,1);
%end
            
%predictor = basis(:,1).*amplitude(1);
           
            
            %for n = 1 : length(spec(:,1))
            %totalSquares(n) = (spec(n) - mean(spec))^2;
            %end
            
            %sumTotalSquares(:,i) = sum(totalSquares);
            
            %rSquares(:,i) = 1 - resNorm(:,i) / sumTotalSquares(:,i)
            
            %rNow = (length(residual(:,i)-1))*var(residual(:,i));
            %rSquared = 1 - resNorm(1)^2 / rNow            %coefficient of determination.
            %rOutput = regstats(spec(:,i)
            
            %{
            if mode == 1
        amplitude = [amplitude amplitudeAdd];
        end
       
        
        if mode == 2
        amplitude(:,1) = amplitudeInsert';
        end
        
        if mode == 1
        amplitudeAdd =  zeros(6,1);
        end
        
         if mode == 2
            broadPeak = max(initialData(1:450))
            singletPeak = max(initialData(450:900))
            peakRatio = singletPeak / broadPeak;
            amplitudeInsert(:,i) = singletPeak - 0.92*broadPeak
         end
          %}  
         
          %coefficientArray = [194.8,0.005081, -0.3953, 177.8, 0.01003, 1.311, 69.16, 0.01931, 1.898, 71.39, 0.02678, 3.003, 32.8, 0.01509, -1.945, 37.71, 0.03044, -1.34, 12.82, 0.04426, -1.296]
            %function F = myfun(x,xdata)
            %F = x(1)*xdata.^2 + x(2)*sin(xdata) + x(3)*xdata.^3;

            %fitFunction = sum_of_sines(coefficientArray,7);
            %lsqcurvefit uses same algorithm as lsqnonlin
            %[coef] = lsqcurvefit(@sum_of_sines,0,spec,basis(1,:),0,[]);
            
            

%Xiaoming's CrossoverFunction:

%{

%Function below was Xiaoming's original crossover() function, currently
Stephen Marsh's corssover() function is being used.

function StdCrossover=crossover(spec)
%crossover  find the cross over of the standard for both the basis spectra and samples
%input is the experiment.spec and experiment.field 
%output is the crossover point of the standard peak
    
    %std_start=1570; %about 3540 G
    %std_end=1680; %about 3548 G
	
    std_start = 1570;
    std_end = 1680;
    
    for i=std_start:std_end
        if spec(i)*spec(i+1)<=0
            if spec(i)<=abs(spec(i+1))
                StdCrossover=i;
            else StdCrossover=i+1;
            end
            break
        end
    end
end
%}

%{
if sizeDoseRemove ~= 0 
    for q = 1 : sizeDoseRemove 
    spec(:,dosesToRemove(sizeDoseRemove+1-q)*3-2:dosesToRemove(sizeDoseRemove+1-q)*3) = [];
    end
end
%}

%{
experimentalSpectra = zeros(2048,numberOfDoses,numberExperiments);

for iterExperiment = 1:numberExperiments
    if numberExperiments == 1
    experimentalSpectra(:,:,iterExperiment) = spec(:,:);        %3D array here.
    else
    experimentalSpectra(:,:,iterExperiment) = spec(:,iterExperiment:numberExperiments:end); %3D array here.
    end
end

spectraOut = experimentalSpectra;
%}


%For AlignmentEPR UF:
%150/170 gauss = 0.8824
%0.8824*1020 = 900.0480
%so we take 900 of the points of 1020.
    
%From AlignmentEPR:
%temp = spectra(:,j);
%temp = malowess(1:length(field),spectra(:,j),'order',1);       %1:length(field) %Xiaoming had only x and y arguments here.
%temp = malowess(1:2048,spectra(:,j),'order',1);
%%default 'order' value is 1.  default window size is 0.05 (0.05%
%%of all data points)
%lowess is 1st degree poly, loess is 2nd degree polynomial.

%From AnalysisProcedureOrginal
%{
%Code Below converts from points into Gauss.
start(1) = xtrun(1200);
for i = 2:length(start)
    start(i) = start(i-1)+0.0732;
end
xtrunNew = cat(2,xtrun,start);
%}

%From AnalysisProcedureOrginal
%{
str = {''};
str2 = {''};
for z = 1:length(label)
    str{z} = strcat(num2str(label{z}), '\_',num2str(correspondingDoses(z)),'Gy');
    str2{z} = strcat(num2str(label{z}), '\_',num2str(correspondingDoses(z)),'Gy');
end
%}

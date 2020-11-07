function [YES2] = ResizeSpectra(spectraIn,setRandom)

%useArray = [256 512 768 1024 1280 1536 1792 2048];

%Multiply factor used below:
multFactor = 3200;
spectraIn = spectraIn.*multFactor;

%Need to truncate data because UF sweep is 170 gauss. 
%150/170 = 0.8824
%0.8824*1020 = 900 points. 
%Cut the above 1020-900 = 120 points off of the low end of the sweep.
%900*2 = 1800, 2048 - 1800 = 248. 
%every eight points interpolate, 1800/8 = 225 and 1800+225 = 2025, then can
%do on emore time. 




spectraIn(1:120) = []; 
lengthSpec = length(spectraIn);
desiredLength = 2048;
numberExtra = desiredLength-length(spectraIn)*2;
%numberExtra after truncate = 248.



jump = 8;


for i = 1:2:lengthSpec*2-1
    if i==1
        spectraOut(1) = spectraIn(1);
    else
    spectraOut(i:i+1,:) = spectraIn((i+1)/2,:);
    end    
end

poo = 1800;

for j = 1:jump:(poo+1)-jump
    j;
    block(:,((j-1)+jump)/jump) = spectraOut(j:(j+jump)-1);
end

    sizeBlock = size(block);
    dimsBlock = sizeBlock(2);
        
    for k = 1:dimsBlock
        blockNow(:,k) = vertcat(block(:,k),[0]);
    end
  
    YES = reshape(blockNow,1,2025)';
    
    %Now replace periodic zeros appropriately...
    useArray = [1:2025];
    useArray = useArray(9 : 9 : end);  % => 
    useArray(225) = 2025;
    
    for w = 1:225
    if w~=225
    indexNow = useArray(w);
    YES(indexNow) = (YES(indexNow-1)+YES(indexNow+1))/2;
    else
        YES(indexNow) = (YES(indexNow-2)+YES(indexNow-1))/2;
    end
    end
    
    size(YES);
    
    %r = randi(imax,m,n) and r = randi(imax,[m,n]) return an m-by-n matrix of numbers. 
    YES=YES';
    
    
    %Now do second round of iinterpolation.
    
   %2048-2025 = 23
   %2025/23 = 88.0435, 88 is too many extra points
   %2025/100 = 20.2500 
   %2025/90 = 22.5, OK (Can get 22 points, then add one zero point to
   %begining).
    
   jump2 = 90;
   poo2  = 2025;
   
for j2 = 1:jump2:(poo2+1)-jump2
    j2;
    block2(:,((j2-1)+jump2)/jump2) = YES(j2:(j2+jump2)-1);
end
    %Add on the rest 45 more points to get the toal to 2047
    
    extraNow = YES(1981:2025)';
    
    sizeBlock2 = size(block2);
    dimsBlock2 = sizeBlock2(2)
        
    for k2 = 1:dimsBlock2
        blockNow2(:,k2) = vertcat(block2(:,k2),[0]);
    end
  
    size(blockNow2)
    YES2 = reshape(blockNow2,1,2002)';
    size(YES2)
    YES2 = vertcat(YES2,extraNow);
    size(YES2)
    
    %Now replace periodic zeros appropriately...
    useArray = [1:2025];
    useArray = useArray(91 : 91 : end);  % => 
    %useArray(225) = 2025;
    
    for w2 = 1:22
    if w2~=225
    indexNow = useArray(w2);
    YES2(indexNow) = (YES2(indexNow-1)+YES2(indexNow+1))/2;
    else
        YES2(indexNow) = (YES2(indexNow-2)+YES2(indexNow-1))/2;
    end
    end
    
    %Now add in extra
    
    if setRandom == true
    for w2 = 1:23
    randSet = randi(2048-(13-w2),1,length(w2));
    randValue = randsample(randSet,1);
    if randValue == 1
        randValue =2;
    end
    YES2 = [YES2(1:randValue-1),0,YES2(randValue:end)];
    YES2(randValue) = (YES2(randValue-1) + YES2(randValue+1))/2;
    YES2 = YES2';
    end
    else
    YES2 = YES2';
    yesAdd = [];
    yesAdd = zeros(1,1);
    YES2 = vertcat(yesAdd,YES2')
    end
    size(YES2)
    figure(1)
    plot(YES2)
    hold on
    %{
    if your vector is:

a = [1 2 3 4];

and your index is

n = 3;

then

[a(1:n-1), 5, a(n:end)]

will give you what you want.

%}
          
end
    
    
    
%{
    for j = (length(spectraIn)-desiredLength)/8:(length(spectraIn)-desiredLength)/8:desiredLength
    for k = 1:8
spectraOut(k*+1+k:((length(spectraIn)-desiredLength)/8)+k:)= spectraIn(1+k:((length(spectraIn)-desiredLength)/8)+k):




nil Cheriyadat wrote:
> 
> reshape is pretty good matlab function which can hanlde this kind of
> matrix manipulations.
> 
> > a = [2 2 2;3 3 3;5 5 5;8 8 8] % origional 2-D array
> > b=reshape(a',1,12)

Also (:) is very useful.

   b = a(:)'

or
   b = a(:).'

(Use the second one if a is complex. Use either if a is real).

      - Randy 
 

%}
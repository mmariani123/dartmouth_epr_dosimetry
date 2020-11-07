function [amplitude,fitted, MIS, RIS, leftover]=data_fit(data_postcut,basis)
% fitMIS    fit the input spectrum based on the given basis spectra
% data_postcut e.g 1200x60 basis 1200x3 or 1200x2
% output
% amplitude are the signal amplitude of RIS and MIS
% fitted are the fitted spectra of data_postcut
% MIS are the MIS spectra from fitting
% RIS are the RIS spectra from fitting
% leftover are the difference between fitting and original
  
        dimz=size(data_postcut);
		basis_nbs=size(basis,2);
        amplitude=zeros(dimz(2),basis_nbs);      
        leftover=zeros(dimz);
               
      
        for i=1:dimz(2)
            spec = data_postcut(:,i); 
            %spec = malowess(1:length(spec),spec,'order',1);
            %spec = spec';
            %basis(:,1) = (1/var(spec)).*basis(:,1);
            %basis(:,2) = (1/var(spec)).*basis(:,2);
            %spec = (1/var(spec)).*spec;
            %l = 1/var(spec)
            %[coef norms] = lsqlin(basis,spec,[],[],[],[],0,[]);
            %coef = pinv(basis)*spec;
            coef=basis\spec;    
            %coef = basis(1000:1100,:)\spec(1000:1100);
            %x = pinv(A)*B;
            %coef = abs(coef);
            %l = norms
            amplitude(i,:)=coef';	
            leftover(:,i)=spec - basis*coef;  
            %for k = 1: length(leftover(:,1))
                %leftover(k,i) = leftover(k,i).^2;
            %end
                %norms(:,i) = sum(leftover(:,i))
        end
        
        RIS = repmat(basis(:,1),1,dimz(2)).*repmat(amplitude(:,1)',1200,1);
        MIS = repmat(basis(:,2),1,dimz(2)).*repmat(amplitude(:,2)',1200,1);
        fitted = RIS + MIS;
        
end
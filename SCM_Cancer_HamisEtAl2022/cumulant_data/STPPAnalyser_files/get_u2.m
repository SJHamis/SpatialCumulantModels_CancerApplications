function u2 = get_u2(i,j,coordinate_data, x_max_coord, y_max_coord, bin_size, no_rbins,tp)

    pop_i=i;
    pop_j=j;
    coordinate_data_i = coordinate_data(coordinate_data(:,1)==pop_i, :); 
    coordinate_data_j = coordinate_data(coordinate_data(:,1)==pop_j, :);
    
   % le1=length(coordinate_data_i)
   % le2=length(coordinate_data_j)
    
    %split data into 3 data column vectors
    xcoord_i=coordinate_data_i(:,2);
    ycoord_i=coordinate_data_i(:,3);
    
    xcoord_j=coordinate_data_j(:,2);
    ycoord_j=coordinate_data_j(:,3);
        
    no_bins_onedir = 100;% no_rbins;

    %make an empty histogram matrix, in which a bin correspons to a subset of 
    %the simulated are (gcount in R)
    histogram_matrix_i = zeros(no_bins_onedir,no_bins_onedir);
    histogram_matrix_j = zeros(no_bins_onedir,no_bins_onedir);

    %populate the histogram matrix i. add the cells to bins
    for c = 1:length(xcoord_i)
        binx=ceil(xcoord_i(c)/bin_size); %get x location for bin
        biny=ceil(ycoord_i(c)/bin_size); %get y location for bin
        if(binx<no_bins_onedir && biny<no_bins_onedir && binx>0 && biny>0)
            histogram_matrix_i(binx,biny)=histogram_matrix_i(binx,biny)+1; %add +1 to that bin
        end      
    end 

       %populate j
    for c = 1:length(xcoord_j)
        binx=ceil(xcoord_j(c)/bin_size); %get x location for bin
        biny=ceil(ycoord_j(c)/bin_size); %get y location for bin
        if(binx<no_bins_onedir && biny<no_bins_onedir && binx>0 && biny>0)      
            histogram_matrix_j(binx,biny)=histogram_matrix_j(binx,biny)+1; %add +1 to that bin
        end
    end 
    
    histogram_matrix_i=histogram_matrix_i';
    histogram_matrix_j=histogram_matrix_j';
    %compute the number of agent in the simulated space
    no_agents_i=sum(histogram_matrix_i,[1 2]);
    no_agents_j=sum(histogram_matrix_j,[1 2]);
    % %Step 1: Fast fourier transform the histogram_matrix. F = fft(histogram_matrix)
    % %Step 2: Take the absoult value of F. F_a=abs(F).
    % %Step 3: Square F_abs element-wise. F_as = F_a.^2.
    % %Step 4: Invers fourier transform F_as. iF_as = ifft(F_as).
    % %Step 5: Take the real component of iF_as. RiF_as = real(ifft(F_as)).
    f=real(ifft2( fft2(histogram_matrix_i).* conj(fft2((histogram_matrix_j)))));


    %first half bins vector (fhbv) is a vector that goes from 0 to half of the bins
    %no_rbins=floor(sqrt(2*no_bins_onedir^2));
    separation_bins=0:1:floor((x_max_coord/2)/bin_size);
    %k1k2 = zeros(1,length(separation_bins));
    separation_bins_val=zeros(1,length(separation_bins));
    separation_bins_count=zeros(1,length(separation_bins)); %couns how many times values from a distance d contributes to sum in fhbv_val
    %mp=floor(no_bins_onedir/2);
    for ii = 1:length(separation_bins)
       for jj = 1:length(separation_bins)
            d = round(sqrt( (ii-1)^2+(jj-1)^2 )) ; %measures d in terms of bin distance
            if (d <= max(separation_bins) && d>=min(separation_bins) )
                separation_bins_val(d+1) = separation_bins_val(d+1) + f(ii,jj);%/(histogram_matrix(1,1));                
                separation_bins_count(d+1) = separation_bins_count(d+1) + 1;           
            end
       end
    end

    %round 2
    n=length(separation_bins)-2;
    for ii = 1:n
       for jj = no_bins_onedir-n+1:no_bins_onedir
            d = round(sqrt( (ii-1)^2+(jj-1-no_bins_onedir)^2 ));  %measures d in terms of bin distance
            if (d <= max(separation_bins) && d>=min(separation_bins) )
                separation_bins_val(d+1) = separation_bins_val(d+1) + f(ii,jj);%/(histogram_matrix(1,1));                
                separation_bins_count(d+1) = separation_bins_count(d+1) + 1;           
            end
       end
    end

    %round 3
    for ii = no_bins_onedir-n+1:no_bins_onedir
       for jj = 1:n
            d = round(sqrt( (ii-1-no_bins_onedir)^2+(jj-1)^2 ));  %measures d in terms of bin distance
            if (d <= max(separation_bins) && d>=min(separation_bins) )
                separation_bins_val(d+1) = separation_bins_val(d+1) + f(ii,jj);%/(histogram_matrix(1,1));                
                separation_bins_count(d+1) = separation_bins_count(d+1) + 1;           
            end
       end
    end

    %round 4
    for ii = no_bins_onedir-n+1:no_bins_onedir
       for jj = no_bins_onedir-n+1:no_bins_onedir
            d = round(sqrt( (ii-1-no_bins_onedir)^2+(jj-1-no_bins_onedir)^2 ));  %measures d in terms of bin distance
            if (d <= max(separation_bins) && d>=min(separation_bins) )
                separation_bins_val(d+1) = separation_bins_val(d+1) + f(ii,jj);%/(histogram_matrix(1,1));                
                separation_bins_count(d+1) = separation_bins_count(d+1) + 1;           
            end
       end
    end

    % %get average value of f as a function of (d)
    spm2=separation_bins_val./separation_bins_count;

        if pop_i==pop_j
            spm2(1)=spm2(1)-no_agents_i; %NECC IN HISTOGRAM
            %disp('i==j');
        end


    spm2=spm2/(x_max_coord^2);
    spm2=spm2/(bin_size^2);
    spm1_i= (no_agents_i/(x_max_coord^2));
    spm1_j= (no_agents_j/(x_max_coord^2));
    u2 = spm2 - spm1_i*spm1_j;
    
   % no_agents_i
   % no_agents_j

end

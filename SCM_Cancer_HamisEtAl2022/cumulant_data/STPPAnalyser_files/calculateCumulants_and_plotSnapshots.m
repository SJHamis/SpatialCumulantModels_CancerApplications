function [u1_data,u2_data] = calculateCumulants_and_plotSnapshots(...
    no_subpops, sp_combis, no_timepoints, u2_tps, bin_size, ...
    no_runs, no_rbins, x_max_coord, y_max_coord, input_folder_name)

    %Create a 3D matrix for first order cumulant data.
    %The first matrix element corresponds to the simulation run,
    %the second matrix element corresponds to the timepoint, 
    %the third matrix element corresponds to the subpopulation.
    u1_data = zeros(no_runs,no_timepoints, no_subpops);

    %Create a 4D matrix for second order cumulant data.
    %The first matrix element corresponds to the simulation run,
    %the second matrix element corresponds to the spatial distance bin, 
    %the third matrix element corresponds to the timepoint,
    %the fourth matrix element corresponds to the subpopulation.
    u2_data= zeros(no_runs, no_rbins, length(u2_tps), length(sp_combis));

   
    % Loop to load data and create snapshot-scatterplots:
    figure
    plotindex=1;
    for nr = 1:no_runs
        for tp = 1:no_timepoints
            %Load data:
            if(tp<10)
                data_temp = load(append(input_folder_name,int2str(nr),'/snap00000',int2str(tp)));
            elseif(tp<100)
                data_temp = load(append(input_folder_name,int2str(nr),'/snap0000',int2str(tp)));
            elseif(tp<1000)
                data_temp = load(append(input_folder_name,int2str(nr),'/snap000',int2str(tp)));
            end
            
            for sp = 1:no_subpops 
                mono_data_temp = data_temp(data_temp(:,1)==sp, :); % Clean temp data to include only one subpopulation
                u1_data(nr,tp,sp) = get_u1(mono_data_temp, x_max_coord, y_max_coord);%cellcount -> cellcount/area
            end

            %Create scatterplots at selected in silico runs and
            %time-points.
            if ismember(tp,u2_tps)
                
                for spc = 1:length(sp_combis)
                    time_index=find(u2_tps==tp);
                    u2_data(nr,:,time_index,spc) = get_u2(sp_combis(spc,1),sp_combis(spc,2),data_temp,x_max_coord,y_max_coord,bin_size,no_rbins,tp);
                end

                
                %Create scatterplots for the first, second and third simulation run. 
                if(nr<=3)
                    subplot(3,3,plotindex)            
                    sp1=data_temp(data_temp(:,1)==1,:);
                    sp2=data_temp(data_temp(:,1)==2,:);
                    sp3=data_temp(data_temp(:,1)==3,:); 
                    
                    %Plot subpopulation 1:
                    psize=10;
                    scatter(sp1(:,2),sp1(:,3),psize,[0.6350 0.0780 0.1840],'filled')
                    hold on
                    %Plot subpopulation 2:
                    if(~isempty(sp2))
                        scatter(sp2(:,2),sp2(:,3),psize,[0.4660 0.6740 0.1880],'filled')
                        hold on
                    end
                    %Plot subpopulation 3:
                    if(~isempty(sp3))
                        scatter(sp3(:,2),sp3(:,3),psize,[0 0.4470 0.7410],'filled')
                    end   
                    
                    legend('SP 1','SP 2','SP 3','Location','eastoutside');
                    
                    
                    xlabel('x_1')
                    ylabel('x_2')
                    titlestring = append('Time: ',int2str(tp-1),' \Deltat.' );%'. Run: ',int2str(nr),'.');
                    title(titlestring)    
                    daspect([1 1 1])
                    
                    plotindex=plotindex+1;
                end           
            end        
        end
    end
end
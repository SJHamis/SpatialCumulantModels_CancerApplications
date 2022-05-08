function summarise_and_write_CumulantData(...
    no_subpops, sp_combis, no_timepoints, u2_tps, bin_size, ...
    dist, u1_data, u2_data, output_folder_name)

  
    % Write single-track data
    writematrix(u1_data(:,:,1),append(output_folder_name,'u1_tracks_1.csv'))
    writematrix(u1_data(:,:,2),append(output_folder_name,'u1_tracks_2.csv'))
    writematrix(u2_data(:,:,3,1),append(output_folder_name,'u2_tracks_11.csv'))
    writematrix(u2_data(:,:,3,2),append(output_folder_name,'u2_tracks_12.csv'))
    writematrix(u2_data(:,:,3,3),append(output_folder_name,'u2_tracks_22.csv'))

    %Write and plot summarised data
    
    % Calculate and plot first order spatial cumulants (densities) from
    % point pattern data.
    
    % Set a focal run which data will be explicitely plotted 
    % (along with mean and standard deviation or min/max values).
    focal_run=1;
        

    figure
    t=0:1:no_timepoints-1;
    for sp = 1:no_subpops
        
        u1_mean=mean(u1_data(:,:,sp));
        u1_std=std(u1_data(:,:,sp));
        u1_min=min(u1_data(:,:,sp));
        u1_max=max(u1_data(:,:,sp));
        
        % Plot density dynamics 
        subplot(1,no_subpops,sp)
        set(gca, 'ColorOrder', [0.1 0.0 1.0; 0.1 0.6 0.1; 0.8 0 0; 0.7 0.2 1; 0.1 1 0.9; 0.9 0.5 0;0.1 0.0 1.0; 0.1 0.6 0.1; 0.8 0 0; 0.7 0.2 1; 0.1 1 0.9; 0.9 0.5 0],'NextPlot', 'replacechildren');   
        hold on
        plot(t,u1_mean,'LineWidth',1);
        hold on
        h=fill([t fliplr(t)],[u1_mean-u1_std fliplr(u1_mean+u1_std)],[0.1 0.0 1.0],'LineStyle','none');
        set(h,'facealpha',.3)
        hold on
        plot(t,u1_data(focal_run,:,sp),'k-.');
        xlabel('time (\Delta t)')
        ylabel(append('u^{(1)}_',num2str(sp),'(t)'))
        legend('mean','stdev','run 1')
        title(append('Density dynamics (subpopulation ',num2str(sp),')'))
        
        %Write density dynamics to files 
        temp = append(output_folder_name,'u1data_',int2str(sp),'_')
        filename_mean = append(temp,'mean.csv');
        filename_std = append(temp,'std.csv');  
        filename_min = append(temp,'min.csv');
        filename_max = append(temp,'max.csv');

        tempfile_mean = fopen(filename_mean,'w');
        tempfile_std = fopen(filename_std,'w');  
        tempfile_min = fopen(filename_min,'w');
        tempfile_max = fopen(filename_max,'w');

        for i=1:length(u1_mean)
            fprintf(tempfile_mean, '%d, %.20f \n', t(i), u1_mean(i) );
            fprintf(tempfile_std, '%d, %.20f \n', t(i), u1_std(i) );             
            fprintf(tempfile_min, '%d, %.20f \n', t(i), u1_min(i) );
            fprintf(tempfile_max, '%d, %.20f \n', t(i), u1_max(i) );
        end

        fclose(tempfile_mean);
        fclose(tempfile_std);          
        fclose(tempfile_min);
        fclose(tempfile_max);
    end

    
    % Calculate and plot second order spatial cumulants 
    % from point pattern data.
    
    figure  
    for spc = 1:length(sp_combis)
        
        for tp = 1:length(u2_tps)
            
            u2_mean=mean(u2_data(:,:,tp,spc));
            u2_std=std(u2_data(:,:,tp,spc));
            u2_min=min(u2_data(:,:,tp,spc));
            u2_max=max(u2_data(:,:,tp,spc));
            
            % Plot pair-density dynamics
            subplot(length(sp_combis), length(u2_tps),(spc-1)*length(u2_tps) + tp)
            
                set(gca, 'ColorOrder', [0.1 0.0 1.0; 0.1 0.6 0.1; 0.8 0 0; 0.7 0.2 1; 0.1 1 0.9; 0.9 0.5 0;0.1 0.0 1.0; 0.1 0.6 0.1; 0.8 0 0; 0.7 0.2 1; 0.1 1 0.9; 0.9 0.5 0],'NextPlot', 'replacechildren');   
                hold on
                plot(dist,u2_mean,'LineWidth',1);
                hold on
                h=fill([dist fliplr(dist)],[u2_mean-u2_std fliplr(u2_mean+u2_std)],[0.1 0.0 1.0],'LineStyle','none');
                set(h,'facealpha',.3)
                plot(dist,u2_data(1,:,tp,spc),'k');%plot also run 1
                hold on
                xlabel('distance (\Delta r)')
                ylabel(append('u^{(2)}_{',num2str(sp_combis(spc,1)),num2str(sp_combis(spc,2)),'}(t,\Delta r)'))
                xlim([dist(1) dist(end)])
                titlestring = append('Spatial covariance (',num2str(sp_combis(spc,1)),'-',num2str(sp_combis(spc,2)),') at time: ',int2str(u2_tps(tp)-1),'.');
                subtitle(titlestring)    
                legend('mean','stdev','run 1')

                %Write pair-density dynamics to files 
                temp = append(output_folder_name,'u2data_',int2str(sp_combis(spc,1)),int2str(sp_combis(spc,2)),'_');

                filename_mean = append(temp,'mean_time',int2str(u2_tps(tp)-1),'.csv');
                filename_std = append(temp,'std_time',int2str(u2_tps(tp)-1),'.csv');  
                filename_min = append(temp,'min_time',int2str(u2_tps(tp)-1),'.csv');
                filename_max = append(temp,'max_time',int2str(u2_tps(tp)-1),'.csv');

                tempfile_mean = fopen(filename_mean,'w');
                tempfile_std = fopen(filename_std,'w');  
                tempfile_min = fopen(filename_min,'w');
                tempfile_max = fopen(filename_max,'w');

                for i=1:length(u2_mean)
                    fprintf(tempfile_mean, '%d, %.20f \n', dist(i)*bin_size, u2_mean(i) );
                    fprintf(tempfile_std, '%d, %.20f \n', dist(i)*bin_size, u2_std(i) );
                    fprintf(tempfile_min, '%d, %.20f \n', dist(i)*bin_size, u2_min(i) );
                    fprintf(tempfile_max, '%d, %.20f \n', dist(i)*bin_size, u2_max(i) );
                end

                fclose(tempfile_mean);
                fclose(tempfile_std);          
                fclose(tempfile_min);
                fclose(tempfile_max);
        end
    end
end
clear
clc
config = Config();
for patient = 1:size(config.filename,2)
    if(config.conciencia(patient).type == 's')
      name =  strtrim(config.filename(patient).name);
      Channels = config.channels(patient).chans;
    %   if(exist([config.filepath '/' name '_bands.mat'],'file') == 0)
      if(0==0)
        eeglab;
        disp("Loading Data");
        EEG = LoadData(name, config.filepath);
        disp("Preprocesing Data");
        EEG = PreProc(config);
        disp("Generate EEG range filtere");
        EEGBANDS = GetBands();
        srate = EEG.srate;
        disp("Saving file");
        save([config.filepath '/' name '_' num2str(EEG.srate) '_bands.mat'],'-v6',"EEGBANDS", "config", "srate");
      else
        LoadedData = load([config.filepath '/' name '_bands.mat']); 
        EEGBANDS = LoadedData.EEGBANDS;
        EEG.srate = LoadedData.srate;
      end

      disp("Computing ARphidata delta");

      kTau = 50; 
      Frequencies = ["4 - 20Hz"];
      w_start = 1;
      w_size = 200; 
      step_size = 100; % 

      for tau= kTau %1:size(kTau,2)
        DATA=EEGBANDS(Channels,:,1);
        j=1;
        for(i=1:step_size:size(DATA,2)-w_size-1)
          phi_t = ARphidata(DATA(:,i:i+w_size),tau);
          phi_original(j) = phi_t.Phi;
          j=j+1;
        end

        % Normaliz phi.

        phi = norm_data(phi_original);

        control_window = [100:300] ;
        crisis_window = [1200:1400] ;

        % Calculate statistical differences.                                   ces.
        p(patient) = calc_ranksum(phi, control_window, crisis_window);

        % Generate output path.
        short_name = regexp(name,filesep,'split');
        file_name = strjoin([fileparts(pwd) '/Results/Nuria_channels/' string(short_name(2)) '_srate-' num2str(EEG.srate) '_step' num2str(step_size) '_tau-'  num2str(tau) '_wsize-' num2str(w_size)]);
        file_name = strrep(file_name, ' ','');

        % Apply moving average filter.
        smooth_phi = smooth(phi,10);

        % Calculate min value.
        crisis = mean(smooth_phi(crisis_window));
        max_crisis = max(smooth_phi(crisis_window));
        min_crisis = min(smooth_phi(crisis_window));
        baseval = mean(smooth_phi(control_window));

        % Calculate differences between baseline and minimum value.
        smooth_delta_phi(patient) = (- baseval + crisis) / baseval;
        smooth_delta_min_phi(patient) = (- baseval + min_crisis) / baseval ;
        smooth_delta_max_phi(patient) =  (- baseval + max_crisis) / baseval;
        smooth_ratio_phi(patient) = crisis / baseval;

        % Calculate statistical differences.
        smooth_p(patient) = calc_ranksum(smooth_phi, control_window, crisis_window);


        % Plot and save
        figure;plot(smooth_phi);hold on; 
        rectangle("position", [min(control_window), -0.1, size(control_window,2) ,1]); hold on;
        rectangle("position", [min(crisis_window), -0.1, size(crisis_window,2) ,1]);
        saveas(gcf, [file_name + '.jpg']);
        save([file_name + '_phi.mat'],'-v6', "phi", "config");


        % Calculate min valua and save.
        crisis = mean(phi(crisis_window));
        min_crisis = min(phi(crisis_window));
        max_crisis = max(phi(crisis_window));
        baseval = mean(phi(control_window));

        % Calculate differences between baseline and minimum value.
        %delta_phi(patient) = (-baseval + crisis) / baseval;
        %delta_min_phi(patient) =  (-baseval + min_crisis ) / baseval;
        %delta_max_phi(patient) =  (-baseval + max_crisis ) / baseval;
        %ratio_phi(patient) = crisis / baseval;

        % Plot and save.
        %figure;plot(phi);hold on;
        %rectangle("position", [control_window(1), -0.1, control_window(2)-control_window(1) ,1]); hold on;
        %rectangle("position", [crisis_window(1), -0.1, crisis_window(2)-crisis_window(1) ,1]);
        %saveas(gcf, [file_name + '_raw.jpg']);

        % Conciencia

        conciencia(patient) = config.conciencia(patient).value;

        clear phi;
        clear DATA;
      end
    %close;
    %clearvars -except config patient;
    disp(["Patient" num2str(patient) "Done"])

    else
        
        smooth_delta_phi(patient) = NaN;
        smooth_delta_min_phi(patient) = NaN;
        conciencia(patient) = NaN;
    
    end
end
close all;
smooth_delta_min_phi(isnan(smooth_delta_min_phi)) = [];
conciencia(isnan(conciencia)) = [];
%smooth_delta_min_phi(2)=[];
%conciencia(2)=[];
[correl p] = corr(smooth_delta_min_phi', conciencia')
figure; scatter(smooth_delta_min_phi, conciencia);
h = lsline();
xl = xlim;
yl = ylim;
xt = 0.05 * (xl(2)-xl(1)) + xl(1)
yt = 0.90 * (yl(2)-yl(1)) + yl(1)
p2 = polyfit(get(h,'xdata'),get(h,'ydata'),1);
caption = sprintf('y = %f * x + %f ; pval = %f', p2(1), p2(2), p);
text(xt, yt, caption, 'FontSize', 14, 'Color', 'r', 'FontWeight', 'bold');
title('Correlacion entre valor ARPhi y valor de alteracion de conciencia en sueno');
xlabel('ARPhi');
ylabel('CSS');
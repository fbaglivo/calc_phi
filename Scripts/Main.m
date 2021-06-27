clear
clc
config = Config();
for patient = 1:size(config.filename,2)
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
      j
      phi_t = ARphidata(DATA(:,i:i+w_size),tau);
      phi_original(j) = phi_t.Phi;
      j=j+1;
    end
    
    % Normaliz phi.
    
    phi = norm_data(phi_original);
    
    % Calculate statistical differences.                                   ces.
    p(patient) = calc_ranksum(phi, [1 201], [size(phi,2)/2 size(phi,2)/2+200]);
    
    % Generate output path.
    short_name = regexp(name,filesep,'split');
    file_name = strjoin([fileparts(pwd) '/Results/tau_sweep_zscore_withmin/' string(short_name(2)) '_srate-' num2str(EEG.srate) '_step' num2str(step_size) '_tau-'  num2str(tau) '_wsize-' num2str(w_size)]);
    file_name = strrep(file_name, ' ','');
    
    % Apply moving average filter.
    smooth_phi = smooth(phi,10);
    
    % Calculate min value.
    [val index] = min(smooth_phi);
    
    % Plot and save
    figure;plot(smooth_phi);hold on; plot(index, val-0.01, 'r.')
    saveas(gcf, [file_name + '.jpg']);
    save([file_name + '_phi.mat'],'-v6', "phi", "config");
    
    
    % Calculate min valua and save.
    [minval index] = min(phi(1000:1500));
    baseval = mean(phi([1:200]));
    
    % Calculate differences between baseline and minimum value.
    delta_phi(patient) = baseval - minval;
    ratio_phi(patient) = minval / baseval;
    
    % Plot and save.
    figure;plot(phi);hold on; plot(index+1000, minval-0.01, 'r.')
    saveas(gcf, [file_name + '_raw.jpg']);
   
    clear phi;
    clear DATA;
  end
%close;
%clearvars -except config patient;
disp(["Patient" num2str(patient) "Done"])

end


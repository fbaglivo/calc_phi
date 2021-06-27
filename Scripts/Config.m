% Configure all the constants 

% Seizure onset 10 min (1200000 muestras)

function [config] = Config()
  %% Add EEGLAB path.
  eeglab_path = [fileparts(pwd) '/eeglab4.5b'];
  old_path = path;
  path(eeglab_path, path);
  %% Add Barret-Seth scripts to path;
  eeglab_path = [fileparts(pwd) '/Barret-Seth'];
  old_path = path;
  path(eeglab_path, path);
  %% Add EEG filenames.
  config.filename(1).name = 'MA_1/HEC008_MA_crisis_1_Macro_Nuria';
  config.filename(2).name = 'MA_2/HEC008_MA_crisis_2_MacroHP07LP200_300sPost';
  config.filename(3).name = 'MA_4/HEC008_MA_crisis_4_MacroHP07LP200_300sPost';
  config.filename(4).name = 'RF_2/HEC005_RF_crisis_2_Macro_07a200EventosCorregidosNuria';
  config.filename(5).name = 'RF_7/HEC005_RF_crisis_7_Macro_07a200ValoresCorregidosNuria';
  config.filename(6).name = 'WL_8/HEC002_WL_crisis_8_Macro_Nuria_sin_ecg';
  config.filename(7).name = 'CG_38/HEC010_CG_crisis_38_MacroHP07LP200-Nuria';
  config.filename(8).name = 'CG_50/HEC010_CG_crisis_50_MacroHP07LP200-Nuria';
  config.channels(1).chans = [10 11 19   20   37   38]; 
  config.channels(2).chans = [10 11 19   20   37   38]; %[1    2   10   11   19   20   37   38]; 
  config.channels(3).chans = [10 11 19   20   37   38]; 
  config.channels(4).chans = [7    8    9   22   23   24];
  config.channels(5).chans = [7    8    9   22   23   24];
  config.channels(6).chans = [1    2    5    6   13   14];
  config.channels(7).chans = [1    2    10   15   16   17];
  config.channels(8).chans = [1    2    10   15   16   17];
  %% Add EEG folder path.
  fileparts(pwd);
  config.filepath = [fileparts(pwd) '/Registros/']
  %% Sampling Rate for Resampling.
  config.resamplingrate = 260
  
  end
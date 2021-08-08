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
  config.conciencia(1).value = 9;
  config.conciencia(1).type = 'v';
  config.filename(2).name = 'MA_3/HEC008_MA_crisis_3_Macro_Nuria';
  config.conciencia(2).value = 7;
  config.conciencia(2).type = '-'; % Removed
  config.filename(3).name = 'MA_4/HEC008_MA_crisis_4_MacroHP07LP200_300sPost';
  config.conciencia(3).value = 9;
  config.conciencia(3).type = 's';
  config.filename(4).name = 'CM_1/HEC006_CM_crisis_1_Macro_Nuria (1)';
  config.conciencia(4).value = 1;
  config.conciencia(4).type = 'v';
  config.filename(5).name = 'CM_7/HEC006_CM_crisis_7_Macro_Nuria (1)';
  config.conciencia(5).value = 6;
  config.conciencia(5).type = 'v';
  config.filename(6).name = 'CM_6/HEC006_CM_crisis_6_Macro_07a200-Nuria';
  config.conciencia(6).value = 6;
  config.conciencia(6).type = 's';
  config.filename(7).name = 'CM_8/HEC006_CM_crisis_8_Macro_07a200-Nuria';
  config.conciencia(7).value = 6;
  config.conciencia(7).type = 'v';
  config.filename(8).name = 'RF_2/HEC005_RF_crisis_2_Macro_07a200EventosCorregidosNuria';
  config.conciencia(8).value = 9;
  config.conciencia(8).type = 'v';
  config.filename(9).name = 'RF_3/HEC005_RF_crisis_3_Macro_07a200ValoresCorregidosNuria';
  config.conciencia(9).value = 9;
  config.conciencia(9).type = 'v';
  config.filename(10).name = 'WL_14/HEC002_WL_crisis_14_Macro_Nuria';
  config.conciencia(10).value = 0;
  config.conciencia(10).type = 'v';
  config.filename(11).name = 'WL_4/HEC002_WL_crisis_4_Macro_07a200_EventoModifNuria';
  config.conciencia(11).value = 5;
  config.conciencia(11).type = 'v';
  config.filename(12).name = 'WL_5/HEC002_WL_crisis_5_Macro_07a200_EventosCorregidoNuria';
  config.conciencia(12).value = 4;
  config.conciencia(12).type = 'v';
  config.filename(13).name = 'WL_6/HEC002_WL_crisis_6_Macro_Nuria';
  config.conciencia(13).value = 6;
  config.conciencia(13).type = 'v';
  config.filename(14).name = 'WL_7/HEC002_WL_crisis_7_Macro_Nuria_sin_ecg';
  config.conciencia(14).value = 2;
  config.conciencia(14).type = 'v';
  config.filename(15).name = 'WL_8/HEC002_WL_crisis_8_Macro_Nuria_sin_ecg';
  config.conciencia(15).value = 0;
  config.conciencia(15).type = 'v';
  config.filename(16).name ='CG_1/HEC010_CG_crisis_1_MacroHP07LP200_Nuria';
  config.conciencia(16).value = 4;
  config.conciencia(16).type = 's';
  config.filename(17).name ='CG_31/HEC010_CG_crisis_31_MacroHP0_7LP200_Nuria';
  config.conciencia(17).value = 5;
  config.conciencia(17).type = 's';
  config.filename(18).name ='CG_35/HEC010_CG_crisis_35_MacroHP07LP200_Nuria';
  config.conciencia(18).value = 5;
  config.conciencia(18).type = 's';
  config.filename(19).name ='CG_37/HEC010_CG_crisis_37_MacroHP07LP200-Nuria';
  config.conciencia(19).value = 5;
  config.conciencia(19).type = 's';
  config.filename(20).name = 'CG_38/HEC010_CG_crisis_38_MacroHP07LP200-Nuria';
  config.conciencia(20).value = 5;
  config.conciencia(20).type = 's';
  config.filename(21).name = 'CG_50/HEC010_CG_crisis_50_MacroHP07LP200-Nuria';
  config.conciencia(21).value = 5;
  config.conciencia(21).type = 'v';
  config.channels(1).chans = [9  18  27 45 53 54]; 
  config.channels(2).chans = [9  18  27 45 53 54];  
  config.channels(3).chans = [9  18  27 45 53 54]; 
  config.channels(4).chans = [8 9  26 27  53 54];
  config.channels(5).chans = [8 9  26 27  53 54];
  config.channels(6).chans = [8 9  26 27  53 54];
  config.channels(7).chans = [8 9  26 27  53 54];
  config.channels(8).chans = [10 11 12 36 43 44];
  config.channels(9).chans = [10 11 12 36 43 44];
  config.channels(10).chans = [9 10 18 21 31 44];
  config.channels(11).chans = [9 10 18 27 31 44];
  config.channels(12).chans = [9 10 18 27 31 44];
  config.channels(13).chans = [9 10 18 27 31 44];
  config.channels(14).chans = [9 10 18 27 31 44];
  config.channels(15).chans = [9 10 18 27 31 44];
  config.channels(16).chans = [8 15 22 26 33 35];
  config.channels(17).chans = [8 15 22 26 33 35];
  config.channels(18).chans = [8 15 22 26 33 35];
  config.channels(19).chans = [8 15 22 26 33 35];
  config.channels(20).chans = [8 15 22 26 33 35];
  config.channels(21).chans = [8 15 22 26 33 35];
  %% Add EEG folder path.
  fileparts(pwd);
  config.filepath = [fileparts(pwd) '/Registros/']
  %% Sampling Rate for Resampling.
  config.resamplingrate = 260
  
  end
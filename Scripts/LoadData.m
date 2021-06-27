
function EEG = LoadData(name, filepath)

  %% Load dataset
  [EEG] = pop_loadset( [name '.set'], filepath);
  [EEG] = eeg_checkset( EEG );
end
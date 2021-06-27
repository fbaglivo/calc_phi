
% Prepoc() - Run the preprocessing script:

function EEG = PreProc(config)
   global ALLEEG;
   global EEG;

   
   disp("**** MANUALLY RESAMPLING ****")
   tempData = EEG.data(:,1:10:end);
   clear EEG.data;
   EEG.data = tempData;
   EEG.srate = 200;
   EEG.pnts = size(EEG.data,2);
   EEG = eeg_checkset( EEG );
   
            %% Notch filter
   X = zscore(EEG.data')';
   w = 50 / EEG.srate;
   bw = w / 35;
   [b,a] = iirnotch(w, bw);
   EEG.data = filter(b,a,X);
   
   %disp("**** LOW PASS FILTER ****");
   EEG = pop_eegfilt(EEG, 4, 0, 0);
   EEG = eeg_checkset( EEG );
   
   
   %disp("**** HIGH PASS FILTER ****");
   EEG = pop_eegfilt(EEG, 0, 20, 0);
   EEG = eeg_checkset( EEG ); 
   
   
end

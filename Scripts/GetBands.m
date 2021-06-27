function [EEGFILTERED] = GetBands()
    global ALLEEG;
    global EEG;
    for i=1
        %% Generates new dataset.  
         %[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);
         %eeglab redraw;
        %% Filter.
        %EEG = pop_eegfilt(EEG, Frequencies(i,1), Frequencies(i,2), 0);
        EEGFILTERED(:,:,i) = EEG.data; 
%        spectopo(EEG.data(1,1:10000), 0, EEG.srate); 
        %% Retrieve original set.
         %EEG = eeg_retrieve(ALLEEG, 1); CURRENTSET = 1;
         %eeglab redraw;
    end  
%    EEGFILTERED(:,:,6) = EEG.data;
end

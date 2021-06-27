clear
clc
config = Config();

for patient = 1:size(config.filename,2)
   
   name =  strtrim(config.filename(patient).name);
   short_name = regexp(name,filesep,'split');
   file_name = strjoin([fileparts(pwd) '/Results/tau_sweep_zscore/' string(short_name(2)) '_srate-200_step100_tau-50_wsize-200_phi.mat']);
   file_name = strrep(file_name, ' ','');
   load(file_name);
   size(phi,2)
   figure;plot(phi)
   p(patient,1) = calc_ranksum(phi, [1 50], [size(phi,2)/2+1 size(phi,2)/2+50]);
   p(patient,2) = calc_ranksum(phi, [1 50], [201 250]);

clear phi 
end
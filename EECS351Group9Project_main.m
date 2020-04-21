% EECS 351 Project - monophonic .wav to midi converter
% David Frey, Jason Klass, Taha Shaukat, Pratham Dhanjal

[sn, ok]= listdlg('PromptString', 'Select a sample #:', 'SelectionMode', 'Single', 'ListString', strcat("Sample ", num2str((1:10)')));
if ok == 0
    disp('No sample # selected - using sample #1 as default')
    sn = 1;
else
    disp(sprintf('Sample %d selected', sn))
end
[yStereo, fs] = audioread(sprintf('audiosample%d.wav', sn));
yMono = s2m(yStereo); % calls s2m to convert imported stereo .wav file into a mono signal
% Calling the splitbynotes functions:
switch sn
    case 1
        BPM = 120; % Sample 1 tempo (Beats Per Minute)
        yByNotes = mrsplitbynotes(yMono, fs, BPM); % sample 1 is monorythymic
    case 2
        BPM = 90; % Sample 2 tempo (Beats Per Minute)
        yByNotes = prsplitbynotes(yMono, fs); % sample 2 is monorythymic
    otherwise
        yByNotes = prsplitbynotes(yMono, fs); % assume all other samples are polyrhythmic
end

% Calling function freqanalysis to return array of frequencies
yfreq = freqanalysis(yByNotes, fs);

% Calling function export2midi to finalize
export2midi(yfreq, fs);
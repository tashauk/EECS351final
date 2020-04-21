function playsampleaudio()
[sn, ok]= listdlg('PromptString', 'Select a sample #:', 'SelectionMode', 'Single', 'ListString', strcat("Sample ", num2str((1:10)')));
if ok == 0
    disp('No sample # selected - using sample #1 as default')
    sn = 1;
else
    disp(sprintf('Playing sample %d', sn))
end
[yStereo, fs] = audioread(sprintf('audiosample%d.wav', sn));
yMono = s2m(yStereo);
p = audioplayer(yMono, fs);
play(p, fs)
pause(length(yMono)/fs)
end
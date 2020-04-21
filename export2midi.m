function export2midi(x, fs)
% This function first converts the frequencies in x to their corresponding
% midi numbers utilizing the f2midinum function, and then converts the
% whole matrix to a midi message format

% Device selection pop-up window:
mdinfo = mididevinfo;
len = size(mdinfo.output, 2);
list = [];
for i = 1:len
    list = [list; string(mdinfo.output(i).Name)];
end
[sidx,OK] = listdlg('PromptString', 'Select a MIDI Device', 'SelectionMode', 'Single', 'ListString', list);
if OK == 0
    sidx = 1;
end
devicename = list(sidx);
disp(strcat("Selected device: ", devicename))
device = mididevice('Output', devicename);

numnotes = size(x, 2);
msg = [];

velocity = 64;
channel = 1;

timestamp = 0; % timestamp initialized to 0
for i = 1:numnotes % indexes each note after note 1
    xi = x(x(:,i)~=0, i);
    
    duration = length(xi)/fs;
    note = f2midinum(xi(1));
   
    msg = [msg; midimsg('Note', channel, note, velocity, duration, timestamp)];
    
    timestamp = timestamp + duration; % writing timestamp for next note
end

disp("Sending MIDI message to selected device...")
midisend(device, msg)
pause(timestamp)
end
function n = f2midinum(f)
% I think this function is finished
% Converts a frequency to the closest midi number
n = round(12*log2(f/440)+69);
end

% From online formula: f = 440*2^((n-69)/12)
% Credit: https://www.inspiredacoustics.com/en/MIDI_note_numbers_and_center_frequencies
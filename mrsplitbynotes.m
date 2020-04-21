function B = mrsplitbynotes(A, fs, BPM)
% Imported array B is a mono channel .wav array
% This function returns array B, which contains the same data except the
% data for each note is on its own column

% mr = monorythymic -> each note has the same length (& samples are made so
% that they are all quarter notes (one note per beat))
% Since the data is monorhythymic, we only need BPM to know where each note
% starts and ends

NPB = 1; % Notes per beat
SPN = fs/(BPM/60)/NPB; % samples per note
numnotes = floor(length(A)/SPN);
AClipped = A(1:SPN*numnotes); % Gets rid of dead samples at the end
B = zeros(SPN, numnotes);
for notenum = 1:numnotes
    startSamp = 1 + (notenum - 1)*SPN;
    endSamp = notenum*SPN;
    B(:,notenum) = A(startSamp:endSamp);
end
end
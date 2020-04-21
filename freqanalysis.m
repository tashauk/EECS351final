function xfreq = freqanalysis(x, fs)
% This function takes x, a matrix of a wav file where every column is a
% note, and the rows are signal of each note, and computes the fft of each note (column
% vector)
% Then, the function returns the frequency of the max fft peak (in Hz) for
% each note to every row belonging to the note's column

xfreq = zeros(size(x,1), size(x,2));
numnotes = size(x, 2); % returns number of columns

for i = 1:numnotes
    ROI = x(:,i)~=0; % Region of interest in note
    Y = abs(fft(x(ROI, i)));
    [maxV,maxI] = max(Y);
    f = fs/length(Y)*maxI;
    xfreq(ROI, i) = f;
end

end
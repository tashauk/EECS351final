function B = prsplitbynotes(A, fs)
% Imported array B is a mono channel .wav array
% This function returns array B, which contains the same data except the
% data for each note is on its own column

% pr = polyrythymic -> each note has the potential to be a different length
% Since the data is polyrythymic, we need to develop an algorithm that can
% detect time indexes where frequencies change
% If this function works, we won't even need mrsplitbynotes since this is a
% more generalized version

% METHOD:
% - Break signal into equal regions small enough to detect every time the
% signal changes pitch (region is smaller than samples per note)
% - Determine the main frequency of each region using fft (find the max
% peak)
% - Test main frequency of each region against previous region to determine
% if there is a change in pitch

RS = floor(length(A)/300); % Sample size of testing region

UpperfLim = 7500; % just above highest freq. on a piano in Hz
idxUpperfLim = ceil(UpperfLim*RS/fs+1);
LowerfLim = 15; % just below lowest freq. on a piano in Hz
idxLowerfLim = floor(LowerfLim*RS/fs+1);

n = floor(length(A)/RS); % Number of regions in the signal
f = fs/RS.*(1:RS-1); % frequency in region

% Initializing a matrix G to have n Regions of length RS:
G = zeros(RS, n);
% Making matrix G split column vectors of A by region:
for i = 0:(n-1)
    startSamp = RS*i + 1;
    endSamp = startSamp+RS-1;
    G(:,(i+1)) = A(startSamp:endSamp);
end

% Initializing Gfft to have ideal size:
Gfft = zeros(RS, n);
% Initiializing maxidx to have length n:
maxidx = zeros(1, n);
maxval = zeros(1, n);
% Assigning the fft of each column in G to the columns of Gfft:
for i = 1:n
    Q = abs(fft(G(:,i)));
    Gfft(:,i) = Q;
    [maxval(i), maxidx(i)] = max(Q(idxLowerfLim:idxUpperfLim), [], 1);
end

% Filtering out unwanted peaks that come from overtones in low gain
% signals:
thresh = mean(maxval)+0.05*std(maxval);
for i = 2:n
    if maxval(i)<thresh
        maxidx(i)=maxidx(i-1);
    end
end

figure()
subplot(2, 1, 1), hold on
plot(RS.*(1:n), f2midinum(f(maxidx)), '.r'), title({'prsplitbynotes.m Function:','Detecting changes in frequency'}),
xlabel('Sample'), ylabel('Unitless Pitch'), set(gca, 'Yticklabel', [])

% initializing the first index of pitch change to be 1:
pcidx(1) = 1; notenum = 1;

for i = 2:n
    if (maxidx(i)~=maxidx(i-1))
        xline(RS*i);
        notenum = notenum + 1;
        pcidx(notenum) = RS*i;
    end
end
hold off
subplot(2, 1, 2), hold on
plot(1:length(A), A), title('Original Signal in Time Domain'),
xlabel('Sample'), ylabel('Signal Strength'), set(gca, 'Yticklabel', [])
for i = 2:n
    if (maxidx(i)~=maxidx(i-1))
        xline(RS*i);
    end
end
hold off
% Initializing B
B = zeros(length(A), notenum);
for j = 1:(notenum-1)
B(1:(pcidx(j+1)-pcidx(j)+1),j) = A(pcidx(j):pcidx(j+1));
end
B(1:length(A(pcidx(notenum):end)),notenum) = A(pcidx(notenum):end);
end
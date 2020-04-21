function monodata = s2m(stereodata)
% I think this function is finished
% Converts stereo (2-channel) to mono (1-channel) so we only have to deal
% with a 1-column array
monodata = sum(stereodata, 2) / size(stereodata, 2);
end
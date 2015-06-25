function playwav( s, fs, varargin )
%PLAYWAV Summary of this function goes here
%   Detailed explanation goes here

%assert(max(abs(s))<=1, 'playwav: input samples larger than 1');

if (nargin < 3 || varargin{1} == 1)
    % normalise to rms -12dB
    rms=10*log10(sqrt(mean(s.^2)));
    gain=10+rms;
    s=s./(10^(gain/10));
    rms2=10*log10(sqrt(mean(s.^2)));
    fprintf('rms %gdB, normalised to %gdb\n',rms,rms2);
end

if (~strncmp(computer('arch'),'glnx',4)) %% test for GNU/Windows
    disp('Using built-in MATLAB sound() for playback - quality may be bad');
    sound(s,fs);
    return
end

cmd = ['"aplay"' ' -t raw -c 1 -r ' num2str(fs) ' -f S16_LE'];

for i=0:10
    try popenw(i,[]); catch end
end

p=popenw(cmd);

blksiz = 1024;

nrem = length(s);
base = 0;

fprintf('playwav: %d samples, fs=%d Hz\n',length(s),fs);
fprintf('               \n');
while nrem > 0
    thistime = min(nrem, blksiz);
    done = popenw(p,round(32767*s(base+(1:thistime))),'int16le');
    nrem = nrem - thistime;
    base = base + thistime;

    fprintf('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b');
    fprintf('playwav: %5.0f%%',base/length(s)*100);
end
fprintf('\n\n');


popenw(p,[]);
pause(1)
for i=0:10
    try popenw(10-i,[]); catch end
end
function demo(n)

if (nargin == 0) 
    n=1;
end

n=n-1;

if (0)
%% 1 just playback 'flute'
    loadwav source/flute.wav;
    samples = evalin('base','samples');
    fs = evalin('base','fs');
    playwav(samples,fs);
end

if(0)
%% 2 just playback 'news'
    loadwav source/news.wav;
    samples = evalin('base','samples');
    fs = evalin('base','fs');
    playwav(samples,fs);
end

if not(n)
%% 3 sampling: flute, downsampling by a factor of 3
    loadwav source/flute.wav;
    
    close;
    samples = evalin('base','samples');
    fs = evalin('base','fs');

    downsample(samples,fs,3)
end
n=n-1;

if not(n)
%% 4 sampling: news, downsampling by a factor of 3
    loadwav source/news.wav;

    close;
    samples = evalin('base','samples');
    fs = evalin('base','fs');

    downsample(samples,fs,3)
end
n=n-1;

if not(n)
%% 5 quantization: flute 16 bit (original)
    disp('# quantization: flute (16 bit, original)');
    loadwav source/flute.wav;

    samples = evalin('base','samples');
    fs = evalin('base','fs');

    playwav(requant(samples,16),fs);
end
n=n-1;

if not(n)
%% 6 quantization: flute 8 bit, 5 bit, 3 bit
    disp('# quantization: flute (8 bit, 5 bit, 3 bit)');
    loadwav source/flute.wav;

    samples = evalin('base','samples');
    fs = evalin('base','fs');

    close;
    playwav(requant(samples,16),fs);
    playwav(requant(samples,8),fs); hold all;
    playwav(requant(samples,5),fs); hold all;
    playwav(requant(samples,3),fs);
end
n=n-1;

if not(n)
%% 7 quantization: flute 16 bit (low volume, then amplified)
    disp('# quantization: flute (16 bit low volume, then amplified)');
    loadwav source/flute.wav;

    samples = evalin('base','samples');
    fs = evalin('base','fs');

    close;
    low_volume = requant(samples./1000,16);  % -30dB from original
    playwav(low_volume.*10,fs,0); hold all;   % playback a little louder
    playwav(requant(low_volume.*1000,16),fs);
end
n=n-1;

if not(n)
%% 8 quantization: news
    disp('# quantization: news (6 bit, then 4 bit)');
    loadwav source/news.wav;

    samples = evalin('base','samples');
    fs = evalin('base','fs');

    close;
    playwav(requant(samples,6),fs); hold all;
    playwav(requant(samples,4),fs); hold all;
end
n=n-1;
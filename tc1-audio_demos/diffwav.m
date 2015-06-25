function diffwav(orig,result)
%READWAV Summary of this function goes here
%   Detailed explanation goes here

t_s=30; % max wave duration
t_a=5;

if nargin < 2
    orig='orig.wav';
    result='result.wav';
end

[x.samples, fs] = wavread(result);
t_s = min(length(x.samples)/fs,t_s);
t_a = min(t_a,t_s);
clear x.samples;

x.samples = wavread(orig,t_s*fs);
x.analyze = wavread(orig,t_a*fs);
y.samples = wavread(result,t_s*fs);
y.analyze = wavread(result,t_a*fs);

channels = size(y.samples,2);

for chan = 1:channels;

    [ccf,lags]=xcorr(x.analyze(:,chan),y.analyze(:,chan),fs/4);

    ccf = ccf .^ 2;

    figure(1);
    subplot(channels,1,chan); stem(lags,ccf);

    peak=lags(find(ccf==max(ccf)))-0;

    if peak < 0
        out(:,chan) = y.samples(-peak+1:end,chan) - x.samples(1:end+peak,chan);
        show(:,chan) = y.analyze(-peak+1:end,chan) - x.analyze(1:end+peak,chan);
    else
        out(:,chan) = y.samples(:,chan) - x.samples(:,chan);
        show(:,chan) = y.analyze(:,chan) - x.analyze(:,chan);
    end

    disp([chan sum(show(:,chan).^2)./length(show(:,chan))]);

    l=length(show(:,chan));
    NFFT=l;
    Y=(abs(fft(show(:,chan),l))/l).^2;
    f = fs/2*linspace(0,1,NFFT/2);
   
    figure(2);
    %subplot(channels,2,(2*chan)-1);plot(sign(show).*10.*log10(abs(show.^2)));
    subplot(channels,2,(2*chan)-1);     plot(show(:,chan));
    axis([0 length(show)-1 -1 1])
    subplot(channels,2,2*chan);         semilogy(f,Y(1:round(l/2)));

    out(:,chan) = 1/2 .* out(:,chan) ./ max(out(:,chan));
end

return
wavwrite(out,fs,'diff.wav');
figure(3);
wavwrite(FMradio(x.samples,fs),fs,'radio.wav');
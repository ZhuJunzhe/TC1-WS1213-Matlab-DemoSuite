function [ y ] = requant( s, depth )
%REQUANT change bit depth of audio samples.
% pre normalisation to -3dB to avoid clipping

%clf;

NFFT=512;
ylimit=-92;

%requantised=round((s/2)*2^depth)/2^depth;
requantised=round(s.*(2^depth))./2^depth;

q=2/2^depth;

qnoise=10*log10(q^2/12/NFFT);

[pxx,pxxc,f]=psd(s,NFFT);
plot(f,10*log10(abs(pxx)),'black'); hold all;
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%[pxx,pxxc,f]=psd(requantised,NFFT);
%plot(f,10*log10(abs(pxx)));
psd(requantised,NFFT); hold off;
%plot(0:1/NFFT:1,qnoise); hold off;
ylim([min(ylimit,qnoise-1) 10]);
title(['Spectrum for ' num2str(depth) ' bit quantization'],'FontWeight','bold');
lines=findobj('Type','line');
set(lines,'LineWidth',1);
set(lines(1),'LineWidth',2.5);

pause(1);

y=requantised;
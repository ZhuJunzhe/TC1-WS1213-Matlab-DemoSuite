function downsample( s, fs, dsf )
%DOWNSAMPLE Summary of this function goes here
%   Detailed explanation goes here

clf;
set(gcf,'units','normalized','outerposition',[0 0 1 1]);

y=decimate(s,dsf);

NFFT=512;
ylimit=-90;

fs_target=round(fs/dsf);

switch dsf
    case 0
        return;
    case 1
        dsfs='no';
    case 2
        dsfs='every 2nd';
    case 3
        dsfs='every 3rd';
    otherwise
        dsfs=['every ' num2str(dsf) 'th'];
end

psd(s,NFFT,fs); hold all;
ylim([ylimit 10]);
title('Original spectrum','FontWeight','bold');
lines=findobj('Type','line');
set(lines,'LineWidth',1);
set(lines(1),'LineWidth',2.5);
pause(1);
playwav(s,fs);

zero_out = setdiff(1:length(s),1:dsf:length(s));
s(zero_out)=0;
psd(s,NFFT,fs);
ylim([ylimit 10]);
title(['Spectrum after keeping ' dsfs ' sample (set others to zero)'],'FontWeight','bold');
lines=findobj('Type','line');
set(lines,'LineWidth',1);
set(lines(1),'LineWidth',2.5);
pause(1);
playwav(s,fs);

psd(s(1:dsf:end),NFFT,fs_target);
ylim([ylimit 10]);
title(['Spectrum after downsampling ' dsfs ' sample'],'FontWeight','bold');
lines=findobj('Type','line');
set(lines,'LineWidth',1);
set(lines(1),'LineWidth',2.5);
pause(1);
playwav(s(1:dsf:end),fs_target);

psd(y,NFFT,fs_target); hold off;
ylim([ylimit 10]);
title(['Spectrum after low-pass pre-filtering and downsampling by a factor of ' num2str(dsf)],'FontWeight','bold');
lines=findobj('Type','line');
set(lines,'LineWidth',1);
set(lines(1),'LineWidth',2.5);
pause(1);
playwav(y,fs_target);
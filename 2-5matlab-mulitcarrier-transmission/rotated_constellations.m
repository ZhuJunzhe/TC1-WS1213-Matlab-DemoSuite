% Rotated Constellations
clear all

% We look at two QPSK signals with n symbols on two different carriers
% The two carriers experience Gaussian noise with snr1 and snr2 resp.
n = 1000;
snr1 = 15;
snr2 = 5;

% %--------------------------------------------------------------------------
% %for graph of BER
% %repeat measurements m times to smooth graph
% m = 10000;
% BER = zeros(100,3); %100 test values, keep snr1 constant, snr2 from 0 to 12, store BER for QAM and MRC
% for a = 1:m
% counter = 0;
% for snr2 = 12:-0.12:0.12
%     counter = counter+1;
%     BER(counter,1) = BER(counter,1) + snr2;
% %--------------------------------------------------------------------------

% 100 random sample values, each row is a symbol with [i,j] where i,j from
% {-1,1}
s1 = randi([0 1],n,2)*2-1;
s2 = randi([0 1],n,2)*2-1;
    
    % store reference signal to see if we can correctly decode in the end
    s1ref = s1;
    s2ref = s2;
    
    
%subplot(5,2,1)
%plot(s1(:,1),s1(:,2),'line','none','marker','.')
plot(s1(logical(ceil(double((int8(s1ref(:,1)~=1)+int8(s1ref(:,2)~=1)))/2)),1),s1(logical(ceil(double((int8(s1ref(:,1)~=1)+int8(s1ref(:,2)~=1)))/2)),2),s1(logical(floor(double((int8(s1ref(:,1)==1)+int8(s1ref(:,2)==1)))/2)),1),s1(logical(floor(double((int8(s1ref(:,1)==1)+int8(s1ref(:,2)==1)))/2)),2),'line','none','marker','.','MarkerSize', 30)
axis([-3 3 -3 3])
set(gca,'DataAspectRatio',[1 1 1])
saveas(gcf,'rc11.png')

%subplot(5,2,2)
%plot(s2(:,1),s2(:,2),'line','none','marker','.')
plot(s2(logical(ceil(double((int8(s2ref(:,1)~=1)+int8(s2ref(:,2)~=-1)))/2)),1),s2(logical(ceil(double((int8(s2ref(:,1)~=1)+int8(s2ref(:,2)~=-1)))/2)),2),s2(logical(floor(double((int8(s2ref(:,1)==1)+int8(s2ref(:,2)==-1)))/2)),1),s2(logical(floor(double((int8(s2ref(:,1)==1)+int8(s2ref(:,2)==-1)))/2)),2),'r','line','none','marker','.','MarkerSize', 30)
axis([-3 3 -3 3])
set(gca,'DataAspectRatio',[1 1 1])
saveas(gcf,'rc21.png')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the incoming signal enters the encoder

% rotate complex constellations by delta
delta = 29*2*pi/360;

c1 = s1(:,1) + s1(:,2)*1i; %form complex signal of two components
c1 = c1.*exp(1i*delta); %rotation
s1(:,1) = real(c1);
s1(:,2) = imag(c1); %distribute components on signal

c2 = s2(:,1) + s2(:,2)*1i;
c2 = c2.*exp(1i*delta);
s2(:,1) = real(c2);
s2(:,2) = imag(c2);


%subplot(5,2,3)
%plot(s1(:,1),s1(:,2),'line','none','marker','.')
plot(s1(logical(ceil(double((int8(s1ref(:,1)~=1)+int8(s1ref(:,2)~=1)))/2)),1),s1(logical(ceil(double((int8(s1ref(:,1)~=1)+int8(s1ref(:,2)~=1)))/2)),2),s1(logical(floor(double((int8(s1ref(:,1)==1)+int8(s1ref(:,2)==1)))/2)),1),s1(logical(floor(double((int8(s1ref(:,1)==1)+int8(s1ref(:,2)==1)))/2)),2),'line','none','marker','.','MarkerSize', 30)
axis([-3 3 -3 3])
set(gca,'DataAspectRatio',[1 1 1])
saveas(gcf,'rc12.png')

%subplot(5,2,4)
%plot(s2(:,1),s2(:,2),'line','none','marker','.')
plot(s2(logical(ceil(double((int8(s2ref(:,1)~=1)+int8(s2ref(:,2)~=-1)))/2)),1),s2(logical(ceil(double((int8(s2ref(:,1)~=1)+int8(s2ref(:,2)~=-1)))/2)),2),s2(logical(floor(double((int8(s2ref(:,1)==1)+int8(s2ref(:,2)==-1)))/2)),1),s2(logical(floor(double((int8(s2ref(:,1)==1)+int8(s2ref(:,2)==-1)))/2)),2),'r','line','none','marker','.','MarkerSize', 30)
axis([-3 3 -3 3])
set(gca,'DataAspectRatio',[1 1 1])
saveas(gcf,'rc22.png')

% mix two signals
temp = s1(:,2);
s1(:,2) = s2(:,2);
s2(:,2) = temp;

%subplot(5,2,5)
%plot(s1(:,1),s1(:,2),'line','none','marker','.')
plot(s1(logical(ceil(double((int8(s1ref(:,1)~=1)+int8(s1ref(:,2)~=1)+int8(s2ref(:,1)~=1)+int8(s2ref(:,2)~=-1)))/4)),1),s1(logical(ceil(double((int8(s1ref(:,1)~=1)+int8(s1ref(:,2)~=1)+int8(s2ref(:,1)~=1)+int8(s2ref(:,2)~=-1)))/4)),2),s1(logical(floor(double((int8(s1ref(:,1)==1)+int8(s1ref(:,2)==1)+int8(s2ref(:,1)==1)+int8(s2ref(:,2)==-1)))/4)),1),s1(logical(floor(double((int8(s1ref(:,1)==1)+int8(s1ref(:,2)==1)+int8(s2ref(:,1)==1)+int8(s2ref(:,2)==-1)))/4)),2),'line','none','marker','.','MarkerSize', 30)
axis([-3 3 -3 3])
set(gca,'DataAspectRatio',[1 1 1])
saveas(gcf,'rc13.png')

%subplot(5,2,6)
%plot(s2(:,1),s2(:,2),'line','none','marker','.')
plot(s2(logical(ceil(double((int8(s1ref(:,1)~=1)+int8(s1ref(:,2)~=1)+int8(s2ref(:,1)~=1)+int8(s2ref(:,2)~=-1)))/4)),1),s2(logical(ceil(double((int8(s1ref(:,1)~=1)+int8(s1ref(:,2)~=1)+int8(s2ref(:,1)~=1)+int8(s2ref(:,2)~=-1)))/4)),2),s2(logical(floor(double((int8(s1ref(:,1)==1)+int8(s1ref(:,2)==1)+int8(s2ref(:,1)==1)+int8(s2ref(:,2)==-1)))/4)),1),s2(logical(floor(double((int8(s1ref(:,1)==1)+int8(s1ref(:,2)==1)+int8(s2ref(:,1)==1)+int8(s2ref(:,2)==-1)))/4)),2),'r','line','none','marker','.','MarkerSize', 30)
axis([-3 3 -3 3])
set(gca,'DataAspectRatio',[1 1 1])
saveas(gcf,'rc23.png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% now we leave the encoder and continue on the channel

    % store reference signal for snr calculation
    s1ref2 = s1;
    s2ref2 = s2;

% add noise with different amplitudes:
%s1 = s1 + sigma1*randn(n,2);
%s2 = s2 + sigma2*randn(n,2);
%    snr1 = snrSig(s1ref2, s1);
%    snr2 = snrSig(s2ref2, s2);
s1 = awgn(s1,snr1,'measured');
s2 = awgn(s2,snr2,'measured');

%subplot(5,2,7)
%plot(s1(:,1),s1(:,2),'line','none','marker','.')
plot(s1(logical(ceil(double((int8(s1ref(:,1)~=1)+int8(s1ref(:,2)~=1)+int8(s2ref(:,1)~=1)+int8(s2ref(:,2)~=-1)))/4)),1),s1(logical(ceil(double((int8(s1ref(:,1)~=1)+int8(s1ref(:,2)~=1)+int8(s2ref(:,1)~=1)+int8(s2ref(:,2)~=-1)))/4)),2),s1(logical(floor(double((int8(s1ref(:,1)==1)+int8(s1ref(:,2)==1)+int8(s2ref(:,1)==1)+int8(s2ref(:,2)==-1)))/4)),1),s1(logical(floor(double((int8(s1ref(:,1)==1)+int8(s1ref(:,2)==1)+int8(s2ref(:,1)==1)+int8(s2ref(:,2)==-1)))/4)),2),'line','none','marker','.','MarkerSize', 15)
axis([-3 3 -3 3])
set(gca,'DataAspectRatio',[1 1 1])
saveas(gcf,'rc14.png')

%subplot(5,2,8)
%plot(s2(:,1),s2(:,2),'line','none','marker','.')
plot(s2(logical(ceil(double((int8(s1ref(:,1)~=1)+int8(s1ref(:,2)~=1)+int8(s2ref(:,1)~=1)+int8(s2ref(:,2)~=-1)))/4)),1),s2(logical(ceil(double((int8(s1ref(:,1)~=1)+int8(s1ref(:,2)~=1)+int8(s2ref(:,1)~=1)+int8(s2ref(:,2)~=-1)))/4)),2),s2(logical(floor(double((int8(s1ref(:,1)==1)+int8(s1ref(:,2)==1)+int8(s2ref(:,1)==1)+int8(s2ref(:,2)==-1)))/4)),1),s2(logical(floor(double((int8(s1ref(:,1)==1)+int8(s1ref(:,2)==1)+int8(s2ref(:,1)==1)+int8(s2ref(:,2)==-1)))/4)),2),'r','line','none','marker','.','MarkerSize', 15)
axis([-3 3 -3 3])
set(gca,'DataAspectRatio',[1 1 1])
saveas(gcf,'rc24.png')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the signal enters the decoder

% resort the signals
temp = s1(:,2);
s1(:,2) = s2(:,2);
s2(:,2) = temp;

%subplot(5,2,9)
%plot(s1(:,1),s1(:,2),'line','none','marker','.')
plot(s1(logical(ceil(double((int8(s1ref(:,1)~=1)+int8(s1ref(:,2)~=1)))/2)),1),s1(logical(ceil(double((int8(s1ref(:,1)~=1)+int8(s1ref(:,2)~=1)))/2)),2),s1(logical(floor(double((int8(s1ref(:,1)==1)+int8(s1ref(:,2)==1)))/2)),1),s1(logical(floor(double((int8(s1ref(:,1)==1)+int8(s1ref(:,2)==1)))/2)),2),'line','none','marker','.','MarkerSize', 15)
axis([-3 3 -3 3])
set(gca,'DataAspectRatio',[1 1 1])
saveas(gcf,'rc15.png')

%subplot(5,2,10)
%plot(s2(:,1),s2(:,2),'line','none','marker','.')
plot(s2(logical(ceil(double((int8(s2ref(:,1)~=1)+int8(s2ref(:,2)~=-1)))/2)),1),s2(logical(ceil(double((int8(s2ref(:,1)~=1)+int8(s2ref(:,2)~=-1)))/2)),2),s2(logical(floor(double((int8(s2ref(:,1)==1)+int8(s2ref(:,2)==-1)))/2)),1),s2(logical(floor(double((int8(s2ref(:,1)==1)+int8(s2ref(:,2)==-1)))/2)),2),'r','line','none','marker','.','MarkerSize', 15)
axis([-3 3 -3 3])
set(gca,'DataAspectRatio',[1 1 1])
saveas(gcf,'rc25.png')

% possibility 1: rotate backwards, decode QPSK (now d is decoded s)
delta = -delta;

c1 = s1(:,1) + s1(:,2)*1i; %form complex signal of two components
c1 = c1.*exp(1i*delta); %rotation
d1(:,1) = real(c1);
d1(:,2) = imag(c1); %distribute components on signal

c2 = s2(:,1) + s2(:,2)*1i;
c2 = c2.*exp(1i*delta);
d2(:,1) = real(c2);
d2(:,2) = imag(c2);

% move to closest QAM position 
for i=1:n
    if d1(i,1)>=0
        d1(i,1) = 1;
    else
        d1(i,1) = -1;
    end
    if d1(i,2)>=0
        d1(i,2) = 1;
    else
        d1(i,2) = -1;
    end
    if d2(i,1)>=0
        d2(i,1) = 1;
    else
        d2(i,1) = -1;
    end
    if d2(i,2)>=0
        d2(i,2) = 1;
    else
        d2(i,2) = -1;
    end
end

% %--------------------------------------------------------------------------
% % for graph of BER
% BER(counter,2) = BER(counter,2) + sum(sum(abs(s1ref-d1)./2))+sum(sum(abs(s2ref-d2)./2));
% %--------------------------------------------------------------------------

%snr1Dec1 = snrSig(s1ref,d1)
%snr2Dec1 = snrSig(s2ref,d2)

% possibility 2: MRC, rotate backwards, decode QPSK (now d is decoded s)
delta = -delta;
cRef = [1+1i, 1-1i, -1+1i, -1-1i]';
cRef = cRef.*exp(1i*delta);
ref(:,1) = real(cRef);
ref(:,2) = imag(cRef);

rat1 = snr1/(snr1 + snr2);
rat2 = snr2/(snr1 + snr2);

for i=1:n
    mostLikelyDistance = 99;
    mostLikely = 0;
    for j=1:4
        distanceReal = (abs(s1(i,1)-ref(j,1)));
        distanceImag = (abs(s1(i,2)-ref(j,2)));
        distance = (rat1*distanceReal + rat2*distanceImag);
        if  distance < mostLikelyDistance
            mostLikelyDistance = distance;
            mostLikely = j;
        end
    end
    d1(i,:) = ref(mostLikely,:);
end
for i=1:n
    mostLikelyDistance = 99;
    mostLikely = 0;
    for j=1:4
        distanceReal = (abs(s2(i,1)-ref(j,1)));
        distanceImag = (abs(s2(i,2)-ref(j,2)));
        distance = (rat2*distanceReal + rat1*distanceImag);
        if  distance < mostLikelyDistance
            mostLikelyDistance = distance;
            mostLikely = j;
        end
    end
    d2(i,:) = ref(mostLikely,:);
end

delta = -delta;
c1 = d1(:,1) + d1(:,2)*1i; %form complex signal of two components
c1 = c1.*exp(1i*delta); %rotation
d1(:,1) = int8(real(c1));
d1(:,2) = int8(imag(c1)); %distribute components on signal

c2 = d2(:,1) + d2(:,2)*1i;
c2 = c2.*exp(1i*delta);
d2(:,1) = int8(real(c2));
d2(:,2) = int8(imag(c2));


% %--------------------------------------------------------------------------
% % for graph of BER
% BER(counter,3) = BER(counter,3) + sum(sum(abs(s1ref-d1)./2))+sum(sum(abs(s2ref-d2)./2));
% end
% end
% %--------------------------------------------------------------------------
% 
% 
% %--------------------------------------------------------------------------
% % for graph of BER
% BER = BER./m;
% BER(:,2) = BER(:,2)./n*100;
% BER(:,3) = BER(:,3)./n*100;
% 
% figure
% semilogy(BER(:,1),BER(:,2),BER(:,1),BER(:,3))
% legend('QPSK','Rot.Const.')
% xlabel('SNR (dB)')
% ylabel('BER (%)')
% saveas(gcf,'rcdec.png')
% %--------------------------------------------------------------------------
        
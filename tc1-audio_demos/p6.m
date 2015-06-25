clear all
[data,fs]=wavread('flute.wav');
f=32;
data=interp(data,f);
dataQN=round(data*32)/32;
dataAWGN=awgn(data,40);
dataQN1=downsample(dataQN,f);
dataAWGN1=downsample(dataAWGN,f);
wavwrite(dataQNA,fs,'QN_1.wav');
wavwrite(dataAWGN1,fs,'AWGN_1.wav')


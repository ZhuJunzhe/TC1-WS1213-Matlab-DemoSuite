function [ output_args ] = plotmp3br( file, fs )
%PLOTMP3BR Summary of this function goes here
%   Detailed explanation goes here

framesize=1152;
frametime=framesize/fs;

frames=mp3frames(file);

x=(1:length(frames)).*frametime;

win=3;
b=ones(1,win)./win;
a=1;

kbps=double(frames./frametime*8/1000);

plot(x,filtfilt(b,a,kbps));
xlabel('seconds');
ylabel('kbps');
title('mp3 bitrate vs. time');
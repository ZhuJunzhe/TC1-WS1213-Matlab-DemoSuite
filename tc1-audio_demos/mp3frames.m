function [ y ] = mp3frames( file )
%MP3FRAMES Summary of this function goes here
%   Detailed explanation goes here

cmd = ['"./mp3gain"' ' -s s -x ' file];

for i=0:10
    try popenr(i,-1); catch end
end

p=popenr(cmd);

y=[];
bytes= popenr(p,1,'char');
while not(isempty(bytes))
    y=[y; bytes];
    bytes = popenr(p,1,'char');
end

C=textscan(char(y),'%d\n');

y=C{1};

popenr(p,-1);
pause(1)
for i=0:10
    try popenr(10-i,-1); catch end
end
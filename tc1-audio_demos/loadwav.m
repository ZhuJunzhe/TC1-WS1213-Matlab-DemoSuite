function loadwav( file, varargin)
%LOADWAV Summary of this function goes here
%   Detailed explanation goes here

if nargin == 0
    file='aa.wav';
end

[samples, fs] = wavread(file);

t_snip=length(samples)/fs;
if nargin == 2
    t_snip=min(str2double(varargin{1}),t_snip);
end

snip=round(t_snip*fs);

left=samples(1:snip,1);
left=left./max(left);
try right=samples(1:snip,2); catch right=[]; end

fprintf('loaded %g seconds of %s\n',t_snip,file);

assignin('base','samples',left);
assignin('base','samples_r',right);
assignin('base','fs',fs);
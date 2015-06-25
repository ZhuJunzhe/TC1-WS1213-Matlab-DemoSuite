clear all;

N = 11;                            % summation limit (use N odd)
wo = pi;                           % fundamental frequency (rad/s)
c0 = 0;                            % dc bias

t = -3:0.01:3;

% x = zeros(1,4001);
% for i=1:4001
%     if(mod(i,800)>200 && mod(i,800)<600)
%         x(i) = 1;
%     end
% end
% 
% plot(t,x);
% ylim([-0.2 1.2]);

rec = c0*ones(size(t));            % initialize yce to c0

% for n=-N:2:N
%     cn = 2/(1i*n*wo);                 % Fourier Series Coefficient
%     rec = rec + real(cn*exp(1i*n*wo*t)); % Fourier Series computation
% end
% subplot(2,1,1);
plot([-3 -2 -2 -1 -1  0 0 1  1  2 2 3],...    % plot original y(t)
     [-1 -1  1  1 -1 -1 1 1 -1 -1 1 1], ':');
hold;
ht = plot(t,rec);
ylim([-1.5 1.5]);
set(ht, 'YDataSource', 'rec');

%------------------------------------------------------------------------
% yt = c0*ones(size(t));             % initialize yt to c0
% 
% subplot(2,1,2)
% plot([-3 -2 -2 -1 -1  0 0 1  1  2 2 3],...    % plot original y(t)
%      [-1 -1  1  1 -1 -1 1 1 -1 -1 1 1], ':');
% hold;                               % plot truncated trigonometric FS
% ht2 = plot(t,yt);
% ylim([-1.5 1.5]);
% set(ht2, 'YDataSource', 'yt');


%-------------------------------------------------------------------------

for n=-N:2:N
    cn = 2/(1i*n*wo);                 % Fourier Series Coefficient
    rec = rec + real(cn*exp(1i*n*wo*t)); % Fourier Series computation
    
%     if(n>0)                     % loop over series index n (odd)
%         cn = 2/(1i*n*wo);                 % Fourier Series Coefficient
%         yt = yt + 2*abs(cn)*cos(n*wo*t+angle(cn));  % Fourier Series computation
%     end
    
    refreshdata
    drawnow
%     
%     if(n == -101 || n == -11 || n == -5 || n == -1 || n == 1 || n == 5 || n == 11 || n == 101)
%         saveas(ht, strcat('image', num2str(n), '.png'));
%     end

    
    pause(.3);
end
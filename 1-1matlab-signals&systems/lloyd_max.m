% implementation of the non-linear Lloyd-Max quantization according to

% The Lloyd-Max algorithm is as follows. Assume that the number M of quantizer levels
% and the pdf fU (u) are given.
% (a) Choose an arbitrary initial set of M levels a1 < a2 < · · · < aM .
% (b) For 1 ≤ j ≤ M −1, set bj = 1/2 (aj+1 + aj ).
% (c) For 1 ≤ j ≤ M , set aj equal to the conditional mean of U given U ∈ (bj−1 , bj ] (where
% b0 and bM are taken to be −∞ and +∞ respectively).
% (d) Repeat Steps (b) and (c) until further improvement in MSE is negligible, then stop.
%
% The MSE decreases (or remains the same) for each execution of Step (b) and Step (c).
% Since it is non-negative, it approaches some limit. Thus if the algorithm terminates when
% the MSE improvement is less than some given ε > 0, then the algorithm must terminate
% after a finite number of iterations.


function [partition, codebook] = lloyd_max(training_set,len)

% termination treshhold
epsilon = 0.05;

% (a) Choose an arbitrary initial set of M levels a1 < a2 < · · · < aM.
M = len;
minT = min(training_set);
maxT = max(training_set);
step = (maxT-minT)/len;

a = zeros(1,M);
for i=1:M
   a(i)=minT + i*step; 
end

MSE = 999999;
Delta_MSE = 9999999;
while(Delta_MSE > epsilon)

    % (b) For 1 ≤ j ≤ M −1, set bj = 1/2 (aj+1 + aj ).
    b = zeros(1,M-1);
    for j=1:M-1
        b(j) = 1/2 * (a(j+1) + a(j));
    end

    % (c) For 1 ≤ j ≤ M , set aj equal to the conditional mean of U given U ∈ (bj−1 , bj ] (where
    % b0 and bM are taken to be −∞ and +∞ respectively).
    for j=1:M
        subset = zeros(1);
        count = 1;
        for c=1:length(training_set);
            if(j==1 && c<=b(1))
                subset(count) = training_set(c);
                count = count+1;
            elseif(j==M && c>=b(M-1))
                subset(count) = training_set(c);
                count = count+1;
            elseif(j>1 && j<M && c>=b(j-1) && c<=b(j))
                subset(count) = training_set(c);
                count = count+1;
            end
        end
        meanT = mean(subset);
        a(j) = meanT;
    end

    % (d) Repeat Steps (b) and (c) until further improvement in MSE is negligible, then stop.
    x = training_set;
    xQ = x;
    partition = b;
    codebook = a;
    for i=1:length(x)
        if(x(i)<partition(1))
            xQ(i) = codebook(1);
        elseif(x(i)>partition(length(partition)))
            xQ(i) = codebook(length(codebook));
        else
            for j=2:length(partition)
                if(x(i)>partition(j-1) && x(i)<partition(j))
                    xQ(i) = codebook(j);
                end
            end
        end
    end

    MSEt = 0;
    for i = 1:length(x)
        MSEt = MSEt + (xQ(i)-x(i))*(xQ(i)-x(i))
        Delta_MSE = abs(MSE - MSEt)
    end
    MSE = MSEt;

end

function res = HMul(c, cprime, p)
% HMul calculates the combined encrypted value based on the inputs c, c_prime, and p
% Usage:
%   combinedCipher = HMul(c, c_prime, N)
%
% Inputs:
%   c        - The first encrypted value
%   cprime   - The second encrypted value
%   p        - The secret prime factor
%
% Output:
%   res - The combined encrypted value

    % Calculate the combined encrypted value
    res = mod(c * cprime, p);
end

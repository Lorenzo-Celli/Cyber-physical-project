function res = HMul(c, cprime, N)
% HMul calculates the combined encrypted value based on the inputs c, c_prime, and N
% Usage:
%   combinedCipher = HMul(c, c_prime, N)
%
% Inputs:
%   c        - The first encrypted value
%   cprime   - The second encrypted value
%   N        - The modulus value
%
% Output:
%   res - The combined encrypted value

    % Calculate the combined encrypted value
    res = mod(c * cprime, N);
end

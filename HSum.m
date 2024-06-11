function res = HSum(c, cprime, N)
% HSum calculates the combined encrypted value based on the inputs c, c_prime, and N
% Usage:
%   combinedCipher = HSum(c, c_prime, N)
%
% Inputs:
%   c        - The first encrypted value
%   cprime   - The second encrypted value
%   N        - The modulus value
%
% Output:
%   res - The combined encrypted value

    % Calculate the combined encrypted value
    res = mod(c + cprime, N);
end

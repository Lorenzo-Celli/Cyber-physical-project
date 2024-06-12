function res = HSum(c, cprime, p)
% HSum calculates the combined encrypted value based on the inputs c, c_prime, and N
% Usage:
%   combinedCipher = HSum(c, c_prime, p)
%
% Inputs:
%   c        - The first encrypted value
%   cprime   - The second encrypted value
%   p        - The secret prime factor
%
% Output:
%   res - The combined encrypted value

    % Calculate the combined encrypted value
    res = c + cprime;
end

function m = DecryptValue(c, p)
% DecryptValue calculates the decrypted value based on the input c and p
% Usage:
%   m = DecryptValue(c, p)
%
% Inputs:
%   c - The encrypted value
%   p - The parameter used in the decryption
%
% Output:
%   m - The decrypted value

    % Calculate the decrypted value
    m = mod(c, p);
end

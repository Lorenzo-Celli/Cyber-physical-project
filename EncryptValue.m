function c = EncryptValue(m, p, q)
% Enc calculates the encrypted value based on the input m, p, N, and q
% Usage:
%   c = Enc(m, p, q)
%
% Inputs:
%   m - The message to be encrypted
%   p - A parameter used in the encryption
%   q - The upper bound for the random selection of w (the set [1, q-1])
%
% Output:
%   c - The encrypted value

    % Randomly pick w from the set [1, q-1]
    w = randi([1, q-1]);

    % Calculate the encrypted value
    c = mod(m + w*p, p*q);
end

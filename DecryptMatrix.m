function originalMatrix = DecryptMatrix(encryptedMatrix, gamma, ximax, p)
% DecryptMatrix decrypts each element of the encrypted matrix and applies the inverse Gamma transformation
% Usage:
%   originalMatrix = DecryptMatrix(encryptedMatrix, ximax, p)
%
% Inputs:
%   encryptedMatrix - The encrypted matrix with values to be decrypted and transformed
%   gamma           - Gain value
%   ximax           - The maximum xi value for Gamma transformation
%   p               - Parameter for the DecryptValue function
%
% Output:
%   originalMatrix - The original matrix with decrypted and transformed values

    % Get the size of the encrypted matrix
    [rows, cols] = size(encryptedMatrix);

    % Initialize the output matrix
    originalMatrix = zeros(rows, cols);

    % Iterate over each element of the encrypted matrix
    for i = 1:rows
        for j = 1:cols
            % Get the current encrypted element
            encryptedValue = encryptedMatrix(i, j);

            % Store the original value in the output matrix
            originalMatrix(i, j) = InverseGamma(DecryptValue(encryptedValue, p), gamma, ximax);
        end
    end
end

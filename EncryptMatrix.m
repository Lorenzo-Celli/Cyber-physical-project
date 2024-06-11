function encryptedMatrix = EncryptMatrix(inputMatrix, gamma, ximax, p, q)
% processMatrix applies Gamma transformation and encryption to each element of the input matrix
% Usage:
%   EncryptMatrix = processMatrix(inputMatrix, ximax, p, q)
%
% Inputs:
%   inputMatrix - The input matrix with values to be transformed and encrypted
%   ximax       - The maximum xi value for Gamma transformation
%   p           - Parameter for the Enc function
%   q           - Upper bound for the random selection of w in Enc function
%
% Output:
%   encryptedMatrix - The matrix with transformed and encrypted values

    % Get the size of the input matrix
    [rows, cols] = size(inputMatrix);

    % Initialize the output matrix
    encryptedMatrix = zeros(rows, cols);

    % Iterate over each element of the input matrix
    for i = 1:rows
        for j = 1:cols
            % Get the current element
            xi = inputMatrix(i, j);

            % Apply Gamma transformation
            gammaValue = Gamma(xi, gamma, ximax);
            
            % Store the encrypted value in the output matrix
            encryptedMatrix(i, j) = EncryptValue(gammaValue, p, q);
        end
    end
end

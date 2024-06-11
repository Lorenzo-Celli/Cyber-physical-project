function mappedxi = Gamma(xi, gamma, ximax)
% Gamma calculates the value based on the input xi and ximax according to the given piecewise function
% Usage:
%   result = Gamma(xi, ximax)
%
% Inputs:
%   xi    - Input value
%   gamma - Gain value
%   ximax - Maximum xi value
%
% Output:
%   mappedxi - Calculated result based on the piecewise function

    % Check the condition for xi
    if xi >= 0
        % Case: xi >= 0
        mappedxi = round(xi * gamma);
    else
        % Case: xi < 0
        mappedxi = 2 * ximax + 1 + round(xi * gamma);
    end
end

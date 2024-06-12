function xi = InverseGamma(mappedxi, gamma, ximax)
% InverseGamma calculates the original xi based on the GammaValue and ximax
% Usage:
%   xi = InverseGamma(GammaValue, ximax)
%
% Inputs:
%   mappedxi - The value obtained from the Gamma function
%   gamma    - Gain value
%   ximax    - Maximum xi value used in the Gamma function
%
% Output:
%   xi - The original value of xi

    % Calculate the threshold for negative xi
    threshold = ximax + 1;

    % Check the condition for GammaValue
    if mappedxi < threshold
        % Case: mappedxi corresponds to xi >= 0
        xi = mappedxi / gamma;
    else
        % Case: mappedxi corresponds to xi < 0
        xi = (mappedxi - 2*ximax - 1) / gamma;
        %xi = (mappedxi - 2*ximax - 1) / gamma;
    end 
end

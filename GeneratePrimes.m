function [p, q] = generatePrimes(bitLength)
    % generatePrimes generates two prime numbers p and q of a specified bit length
    % Usage:
    %   [p, q] = generatePrimes(bitLength)
    %
    % Input:
    %   bitLength - The desired bit length for the prime numbers
    %
    % Outputs:
    %   p - The first prime number
    %   q - The second prime number

    % Compute the range
    lowerBound = 2^(bitLength - 1);
    upperBound = 2^bitLength - 1;

    % Generate the first prime number
    p = generatePrimeInRange(lowerBound, upperBound);
    
    % Generate the second prime number
    q = generatePrimeInRange(lowerBound, upperBound);
end

function primeNumber = generatePrimeInRange(lowerBound, upperBound)
    % generatePrimeInRange generates a prime number within the specified range
    %
    % Input:
    %   lowerBound - The lower bound of the range
    %   upperBound - The upper bound of the range
    %
    % Output:
    %   primeNumber - The generated prime number

    while true
        % Generate a random number within the range
        candidate = randi([lowerBound, upperBound]);
        
        % Check if the candidate is prime
        if isprime(candidate)
            primeNumber = candidate;
            return;
        end
    end
end

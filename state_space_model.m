function [x, y] = state_space_model(A, B, E_d, E_f, F_d, F_f, C, x0, u, d, f, num_steps)
    % Function to simulate the state space model
    %
    % Inputs:
    %   A, B, E_d, E_f, F_d, F_f, C: System matrices
    %   x0: Initial state vector
    %   u: Input vector (time series)
    %   d: Disturbance vector (time series)
    %   f: Fault vector (time series)
    %   num_steps: Number of time steps to simulate
    %
    % Outputs:
    %   x: State vector (time series)
    %   y: Output vector (time series)

    % Get the size of the state vector
    n = length(x0);
    p = size(C, 1);  % Output dimension

    % Initialize state and output vectors
    x = zeros(n, num_steps + 1);
    y = zeros(p, num_steps);

    % Set initial state
    x(:, 1) = x0;

    % Simulate the system over the specified number of time steps
    for k = 1:num_steps
        % Update state
        x(:, k + 1) = A * x(:, k) + B * u(:, k) + E_d * d(:, k) + E_f * f(:, k);

        % Compute output
        y(:, k) = C * x(:, k) + F_d * d(:, k) + F_f * f(:, k);
    end

    % Remove the last state as it's not used for output
    x = x(:, 1:num_steps);
end
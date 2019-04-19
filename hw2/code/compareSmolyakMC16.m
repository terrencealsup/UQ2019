clear all; close all;
addpath(genpath('ellip'));


% The dimension.
d = 16;

l = 2;  % Level for solving the PDE to find Q(u).

ops = load(['operatorsBlocks16_level', num2str(l), '.mat']);




% Test Smolyak.

% Need to change variables to integrate over [-1,1]^d.
changeQ = @(X) (1/2^d)*ellip2DAffine(4.5*X'+5.5, ops.ACell, ops.f, l)';


% Cannot use Matlab to compute a reference solution in higher dimensions.
% Compute the reference with Smolyak now that it's been tested.
Q_ref = smolyakdD(4, d, changeQ);


levelList = 1:3;
num_points = zeros(length(levelList),1);
error_Smol = zeros(length(levelList),1);

for i=1:length(levelList)
    level = levelList(i);
    Q_Smol = smolyakdD(level, d, changeQ);
    num_points(i) = numberSmolyakPoints(level, d);
    error_Smol(i) = abs(Q_Smol - Q_ref);
end



% Test MC.
error_MC = zeros(length(levelList),1);
for i=1:length(levelList)
    N = num_points(i); % Number of samples.
    
    % Repeat 100 times to estimate the RMSE.
    num_trials = 100;
    trials = zeros(num_trials,1);
    for j=1:num_trials
        xi = rand(N, d)*(10 - 1) + 1;
        Q_samples = ellip2DAffine(xi, ops.ACell, ops.f, l);
        Q_MC = mean(Q_samples);
        trials(j) = abs(Q_MC - Q_ref)^2;
    end
    error_MC(i) = sqrt(mean(trials));
end

smol_fit = polyfit(log(num_points), log(error_Smol), 1);

mc_fit = polyfit(log(num_points), log(error_MC), 1);


figure(1);
loglog(num_points, error_Smol, 'b-x');
hold on
loglog(num_points, error_MC, 'r-s');


loglog(num_points, exp(smol_fit(2))*num_points.^(smol_fit(1)), 'k--');
loglog(num_points, exp(mc_fit(2))*num_points.^(mc_fit(1)), 'k:');

title('Error vs. Number of Quadrature Points $N$ ($d=16$)', 'interpreter', 'latex');
xlabel('$N$', 'interpreter', 'latex');
ylabel('Error', 'interpreter', 'latex');

rate1str = sprintf('Smolyak Rate = %0.2f', -smol_fit(1));
rate2str = sprintf('Monte Carlo Rate = %0.2f', -mc_fit(1));

legend('Smolyak', 'Monte Carlo', rate1str, rate2str, 'interpreter', 'latex', 'Location', 'SouthWest');
hold off

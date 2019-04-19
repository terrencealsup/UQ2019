clear all; close all;
addpath(genpath('ellip'));


% The dimension.
d = 2;

l = 4;  % Level for solving the PDE to find Q(u).

ops = load(['operatorsBlocks2_level', num2str(l), '.mat']);


% The function we want to integrate w.r.t. the Joint distribution.
QoI = @(x, y) (1/81)*reshape(ellip2DAffineSerial([x(:), y(:)], ops.ACell, ops.f, l), size(x));

% Compute the reference with integral2.
Q_ref = integral2(QoI, 1, 10, 1, 10);




% Test Smolyak.

% Need to change variables to integrate over [-1,1]^d.
changeQ = @(X) (1/2^d)*ellip2DAffineSerial(4.5*X'+5.5, ops.ACell, ops.f, l)';

levelList = 1:5;
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
        Q_samples = ellip2DAffineSerial(xi, ops.ACell, ops.f, l);
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

title('Error vs. Number of Quadrature Points $N$ ($d=2$)', 'interpreter', 'latex');
xlabel('$N$', 'interpreter', 'latex');
ylabel('Error', 'interpreter', 'latex');

rate1str = sprintf('Smolyak Rate = %0.2f', -smol_fit(1));
rate2str = sprintf('Monte Carlo Rate = %0.2f', -mc_fit(1));

legend('Smolyak', 'Monte Carlo', rate1str, rate2str, 'interpreter', 'latex', 'Location', 'SouthWest');
hold off

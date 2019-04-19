clear all; close all;
addpath(genpath('ellip'));

M = 1000;
levelList = 2:6;

xi = rand(M, 16)*(10 - 1) + 1;
tt = [];
for levelIter=1:length(levelList)
    level = levelList(levelIter);
    disp(['level ', num2str(level)]);
    
    ops = load(['operatorsBlocks16_level', num2str(level), '.mat']);
    tic
    Q = ellip2DAffineSerial(xi, ops.ACell, ops.f, level);
    tt(end + 1) = toc/M;
end
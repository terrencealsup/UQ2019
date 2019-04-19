clear all; close all;
addpath(genpath('ellip'));

xi = rand(20, 2)*(10 - 1) + 1;
level = 5;

ops = load(['operatorsBlocks2_level', num2str(level), '.mat']);
% parallel
%Q = ellip2DAffine(xi, ops.ACell, ops.f, level);
% serial
Q = ellip2DAffineSerial(xi, ops.ACell, ops.f, level);
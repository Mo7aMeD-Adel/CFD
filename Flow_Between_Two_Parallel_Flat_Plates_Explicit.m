                     %% Created by Mo7aMeD Adel %%
                   %% Computional Fluid Dynamics %%
                         %% 23 / 2 / 2016 %%
%%
clc
clear all
close all
%% Problem

% It is required to solve the P.D.E. "Ut = v Uyy" which discribes the flow
% between two parallel flat plates with one is stationary.
% Also, it is required to solve using Explicit (FTCS) "Forward Time Centeral
% Space" scheme.

%% Givens
v = 2e-4;       % Dynamic Viscosity
U_max = 40;     % Upper Plate Velocity (m/s)
H = 0.04;       % Plates Spacing (m)
dt = 0.1;       % Time Step (sec.)
dy = 0.01;      % Distance Step (m)
t = 10;         % Required Solution Time (sec.)
Bu = [0 40];    % Boundary Conditions [U(0,t) U(H,t)]
Iu = [0 40];    % Initial Conditions [U(y,0) U(H,0)]

%% Solution
D = v*dt/dy^2;  % Diffusion Factor
if D >= 0.5
    disp('Unstable Solution')
    break
end
j_max = floor(t/dt+1); % Number of time nodes
i_max = floor(H/dy+1); % Number of space nodes

% Substituting with "Ux  = [U(i,j+1)-U(i,j)]/dt" for time     &
%                   "Uyy = [U(i+1,j)-2*U(i,j)+U(i-1,j)]/dy^2" for space
% Therfore, "U(i,j+1) = [1-2*D]*U(i,j)+D*[U(i+1,j)+U(i-1,j)]"

for j = 1:j_max
    for i = 1:i_max
        if j == 1
            if i == i_max
                U(i,j) = Iu(2);
            else
                U(i,j) = Iu(1);
            end
        else
            if i == i_max
                U(i,j) = Bu(2);
            elseif i == 1
                U(i,j) = Bu(1);
            else
                U(i,j) = (1-2*D)*U(i,j-1)+D*(U(i+1,j-1)+U(i-1,j-1)); 
            end
        end
    end
end

%% Plots
figure
hold on
grid on
for j = 1:j_max
plot(U(:,j),0:dy:dy*(i_max-1))
end
xlabel('Velocity "U" (m)')
ylabel('Hight "Y" (m)')
title('Flow Between Two Parallel Plates Prob.')
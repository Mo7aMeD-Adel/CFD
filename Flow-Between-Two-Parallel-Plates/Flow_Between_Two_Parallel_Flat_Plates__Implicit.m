            %% Created by Mo7aMeD Adel %%
          %% Computional Fluid Dynamics %%
                %% 5 / 3 / 2016 %%
%%
clc
clear all
close all
%% Problem

% It is required to solve the P.D.E. "Ut = v Uyy" which discribes the flow
% between two parallel flat plates with one is stationary.
% Also, it is required to solve using Implicit (BTCS) "Backward Time Centeral
% Space" scheme.

%% Givens
v = 2e-4;       % Dynamic Viscosity
U_max = 40;     % Upper Plate Velocity (m/s)
H = 0.04;       % Plates Spacing (m)
dt = 0.1;       % Time Step (sec.)
dy = 0.001;     % Distance Step (m)
T = 3;          % Required Solution Time (sec.)
Bu = [0 40];    % Boundary Conditions [U(0,t) U(H,t)]
Iu = [0 40];    % Initial Conditions [U(0,0) U(H,0)]

%% Solution
D = v*dt/dy^2;  % Diffusion Factor
j_max = floor(T/dt+1); % Number of time nodes
i_max = floor(H/dy+1); % Number of space nodes

% Substituting with "Ux  = [U(i,j+1)-U(i,j)]/dt" for time     &
%                   "Uyy = [U(i+1,j+1)-2*U(i,j+1)+U(i-1,j+1)]/dy^2" for space
% Therfore, "U(i,j+1) = U(i,j)+D*[U(i+1,j+1)-2*U(i,j+1)+U(i-1,j)]"

for t = 1:j_max
    for i = 1:i_max
       if t==1
          B = zeros(i_max,1);
          B(end) = Bu(2);
       else
          B = U{t-1};
       end
       A = zeros(i_max,i_max);
       for j = 1:i_max
           if j == 1
               A(j,j)=1;
           elseif j == i_max
               A(j,j)=1;
           else
               A(j,j-1) = -D;
               A(j,j) = 1+2*D;
               A(j,j+1) = -D;
           end
           
       end
       U{t} = inv(A)*B;
    end
end

%% Plots
figure
hold on
grid on
for j = 1:j_max
plot(U{j},0:dy:dy*(i_max-1))
end
xlabel('Velocity "U" (m)')
ylabel('Hight "Y" (m)')
title('Flow Between Two Parallel Plates Prob.(dt = 0.1, dy = 0.0001, D = 2000)')
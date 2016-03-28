function U = Backward11(a,h,B,x_interval,dx)

% This Function Solves First Order Single Variable PDE (in the form "a*Ux+h(x)=0") Using Forward
% Numerical Solution. 
% Inputs are:  a = A constant multiplied by Ux
%              h(x) = A handel function of x "@(x) h(x)"
%              B = Boundary/Initial Conditions [x L] "f(x) = L"
%              x_interval = Interval of Solution [x_initial x_end]
%              dx = Solving Step

x = x_interval(1):dx:x_interval(2);
i_max = (x_interval(2)-x_interval(1))/dx+1;

if B(1) == x_interval(1)
           U(1) = B(2);
        for i = 2:i_max
           U(i) = U(i-1)-dx*h(x(i))/a; 
        end
elseif B(1) == x_interval(2) 
           U(i_max) = B(2);
        for i = 1:i_max-1
           U(i_max-i) = U(i_max-i+1)-dx*h(x(i_max-i))/a; 
        end
else
     disp('Initial/Boundary Condition must be at the x_initial or x_end')
end
end

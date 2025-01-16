clc;
clear;
close all;

%constants
rhoObjects = 500; %kg/m^3
rhoLiquid = 1000; %kg/m^3
gravity = 9.81; %m/s^2
L = 1; %m
initialDisplacement = 0.1; %m
initialVelocity = 0; %m/s

omega = sqrt((rhoLiquid*gravity)/(rhoObjects*L));


%Question 1 Part a 
y = @(t) 0.1*cos(omega*t);
t1 = linspace(0,10,100);

figure(1)
plot(t1,y(t1));
ylabel('Position of Object, m')
xlabel('Time, s')
title('Analytical Solution')


%Question 2 Part a
tDelta = 0.1;
tInitial = 0;
tMax = 10;
tVal = tInitial:tDelta:tMax;

figure(2)
yEE = explicitEulerSecondOrder(-(omega^2), tDelta, initialDisplacement, initialVelocity, tInitial, tMax);
plot(tVal, yEE);
ylabel('Position of Object, m')
xlabel('Time, s')
title('Explicit Euler Solution')


%Question 2 Part b
figure(3)
yRK4 = RK4SecondOrder(-(omega^2), tDelta, initialDisplacement, initialVelocity, tInitial, tMax);
plot(tVal, yRK4);
ylabel('Position of Object, m')
xlabel('Time, s')
title('4th Order Runge-Kutta Solution')


%Question 2 Part c
figure(4)
odeSystem = @(t, y) [y(2); -(omega^2) * y(1)];
[tODE45, yODE45] = ode45(odeSystem, tVal, [initialDisplacement, initialVelocity]);
y45 = yODE45(:, 1)';
plot(tVal, y45)%plots displacment with respect to time
ylabel('Position of Object, m')
xlabel('Time, s')
title('ODE45 Solution')


%Question 2 Part d
figure(5)
tiledlayout(3,1)
nexttile
plot(tVal, y(tVal))
hold on 
plot(tVal, yEE)
ylabel('Position of Object, m')
xlabel('Time, s')
legend('Analytical Solution', 'Explicit Euler Solution', 'Location', 'southwest')

nexttile([2,1])
plot(tVal, y(tVal))
hold on
plot(tVal, yRK4)
plot(tVal, y45)
ylabel('Position of Object, m')
xlabel('Time, s')
legend('Analytical Solution', '4th Order Runge-Kutta', 'ODE45 Solution', 'Location', 'southwest')


%Question 3 Part a
figure(6)
tiledlayout(3,1)
nexttile
plot(tVal, abs(y(tVal) - yEE))
hold on 
ylabel('Absolute Error, m')
xlabel('Time, s')
title('Explicit Euler Error')
set(gca, 'YScale', 'log')

nexttile([2,1])
plot(tVal, abs(y(tVal) - yRK4))
hold on
plot(tVal, abs(y(tVal) - y45))
ylabel('Absolute Error, m')
xlabel('Time, s')
legend('4th Order Runge-Kutta', 'ODE45 Solution', 'Location', 'northwest')
title('Runge Kutta and ODE45 Error')


%Question 3 Part b
figure(7)
plot(0:0.001:2, y(0:0.001:2))
hold on
plot(0:0.5:2, explicitEulerSecondOrder(-(omega^2), 0.5, initialDisplacement, initialVelocity, 0, 2))
plot(0:0.05:2, explicitEulerSecondOrder(-(omega^2), 0.05, initialDisplacement, initialVelocity, 0, 2))
plot(0:0.005:2, explicitEulerSecondOrder(-(omega^2), 0.005, initialDisplacement, initialVelocity, 0, 2))
plot(0:0.0005:2, explicitEulerSecondOrder(-(omega^2), 0.0005, initialDisplacement, initialVelocity, 0, 2))
ylabel('Position of Object, m')
xlabel('Time, s')
legend('Analytic Solution','\Deltat = 0.5', '\Deltat = 0.05', '\Deltat = 0.005', '\Deltat = 0.0005', 'Location', 'southwest')
title('Explicit Euler with Different Mesh Sizes')

figure(8)
plot(0:0.5:10, abs(explicitEulerSecondOrder(-(omega^2), 0.5, initialDisplacement, initialVelocity, 0, 10) - y(0:0.5:10)))
hold on
plot(0:0.05:10, abs(explicitEulerSecondOrder(-(omega^2), 0.05, initialDisplacement, initialVelocity, 0, 10) - y(0:0.05:10)))
plot(0:0.005:10, abs(explicitEulerSecondOrder(-(omega^2), 0.005, initialDisplacement, initialVelocity, 0, 10) - y(0:0.005:10)))
plot(0:0.0005:10, abs(explicitEulerSecondOrder(-(omega^2), 0.0005, initialDisplacement, initialVelocity, 0, 10) - y(0:0.0005:10)))
ylabel('Absolute Error, m')
xlabel('Time, s')
legend('\Deltat = 0.5', '\Deltat = 0.05', '\Deltat = 0.005', '\Deltat = 0.0005', 'Location', 'southwest')
title('Absolute Error of Explicit Euler')
set(gca, 'YScale', 'log')


%Question 3 Part c
figure(9)
plot(0:0.001:2, y(0:0.001:2))
hold on
plot(0:0.5:10, RK4SecondOrder(-(omega^2), 0.5, initialDisplacement, initialVelocity, 0, 10))
plot(0:0.05:10, RK4SecondOrder(-(omega^2), 0.05, initialDisplacement, initialVelocity, 0, 10))
plot(0:0.005:10, RK4SecondOrder(-(omega^2), 0.005, initialDisplacement, initialVelocity, 0, 10))
plot(0:0.0005:10, RK4SecondOrder(-(omega^2), 0.0005, initialDisplacement, initialVelocity, 0, 10))
ylabel('Position of Object, m')
xlabel('Time, s')
legend('Analytic Solution','\Deltat = 0.5', '\Deltat = 0.05', '\Deltat = 0.005', '\Deltat = 0.0005', 'Location', 'southwest')
title('4th Order Runge-Kutta with Different Mesh Sizes')

figure(10)
plot(0:0.5:10, abs(RK4SecondOrder(-(omega^2), 0.5, initialDisplacement, initialVelocity, 0, 10) - y(0:0.5:10)))
hold on
plot(0:0.05:10, abs(RK4SecondOrder(-(omega^2), 0.05, initialDisplacement, initialVelocity, 0, 10) - y(0:0.05:10)))
plot(0:0.005:10, abs(RK4SecondOrder(-(omega^2), 0.005, initialDisplacement, initialVelocity, 0, 10) - y(0:0.005:10)))
plot(0:0.0005:10, abs(RK4SecondOrder(-(omega^2), 0.0005, initialDisplacement, initialVelocity, 0, 10) - y(0:0.0005:10)))
ylabel('Absolute Error, m')
xlabel('Time, s')
legend('\Deltat = 0.5', '\Deltat = 0.05', '\Deltat = 0.005', '\Deltat = 0.0005', 'Location', 'southwest')
title('Absolute Error of Explicit Euler')
set(gca, 'YScale', 'log')


%Question 3 Part d
figure(11)
plot(tVal, RK4SecondOrder(-(omega^2), tDelta, initialDisplacement, initialVelocity, tInitial, tMax))
hold on 
plot(tVal, RK4SecondOrder(-(omega^2), tDelta, 0.2, initialVelocity, tInitial, tMax))
plot(tVal, RK4SecondOrder(-(omega^2), tDelta, 0.5, initialVelocity, tInitial, tMax))
plot(tVal, RK4SecondOrder(-(omega^2), tDelta, 1, initialVelocity, tInitial, tMax))
plot(tVal, RK4SecondOrder(-(omega^2), tDelta, 2, initialVelocity, tInitial, tMax))
ylabel('Position of Object, m')
xlabel('Time, s')
legend('y_0 = 0', 'y_0 = 0.2', 'y_0 = 0.5', 'y_0 = 1', 'y_0 = 2')
title('Investigating Changes in Initial Displacement')

figure(12)
plot(tVal, RK4SecondOrder(-(omega^2), tDelta, initialDisplacement, -0.5, tInitial, tMax))
hold on 
plot(tVal, RK4SecondOrder(-(omega^2), tDelta, initialDisplacement, -0.1, tInitial, tMax))
plot(tVal, RK4SecondOrder(-(omega^2), tDelta, initialDisplacement, 0, tInitial, tMax))
plot(tVal, RK4SecondOrder(-(omega^2), tDelta, initialDisplacement, initialVelocity, tInitial, tMax))
plot(tVal, RK4SecondOrder(-(omega^2), tDelta, initialDisplacement, 0.5, tInitial, tMax))
ylabel('Position of Object, m')
xlabel('Time, s')
legend('y''_0 = -0.5', 'y''_0 = -0.1', 'y''_0 = 0', 'y''_0 = 0.1', 'y''_0 = 0.5')
title('Investigating Changes in Initial Velocity')


%Question 4 Part b, iii
c = 0.2;
yDampedRK4 = RK4Damped(omega, c, tDelta, initialDisplacement, initialVelocity, tInitial, tMax);

%Question 4 Part b, iii
figure(13)
plot(tVal, y(tVal))
hold on
plot(tVal, yRK4)
plot(tVal, yDampedRK4)
plot(tVal, RK4Damped(omega, 0.5, tDelta, initialDisplacement, initialVelocity, tInitial, tMax))
ylabel('Position of Object, m')
xlabel('Time, s')
legend('Undamped Analytical', 'Undamped RK4', 'RK4 c = 0.2', 'RK4 c = 0.5')
title('Investigating Damped System Solved with Runge-Kutta')
clc
clear
close all


figure(1)
tiledlayout(2,2)
%%Single Vessel No Drag Explicit Euler 
SVNDFEData3 = load("writeFiles\positionData-SV-ND.txt-1-FE-dt=0.010000.txt");
SVNDFEData4 = load("writeFiles\positionData-SV-ND.txt-1-FE-dt=0.005000.txt");
SVNDFEData5 = load("writeFiles\positionData-SV-ND.txt-1-FE-dt=0.001000.txt");%%converges at 0.001
SVNDFEData6 = load("writeFiles\positionData-SV-ND.txt-1-FE-dt=0.000500.txt");

nexttile
plot(SVNDFEData3(:,1), SVNDFEData3(:,2))
hold on
plot(SVNDFEData4(:,1), SVNDFEData4(:,2))
plot(SVNDFEData5(:,1), SVNDFEData5(:,2))
plot(SVNDFEData6(:,1), SVNDFEData6(:,2))
ylabel('Displacement, m')
xlabel('Time, s')
legend('\Deltat = 0.01', '\Deltat = 0.005', '\Deltat = 0.001', '\Deltat = 0.0005', 'Location', 'northwest')
title('Explicit Euler')

nexttile
plot(SVNDFEData3(:,1), SVNDFEData3(:,3))
hold on
plot(SVNDFEData4(:,1), SVNDFEData4(:,3))
plot(SVNDFEData5(:,1), SVNDFEData5(:,3))
plot(SVNDFEData6(:,1), SVNDFEData6(:,3))
ylabel('Velocity, m/s')
xlabel('Time, s')
legend('\Deltat = 0.01', '\Deltat = 0.005', '\Deltat = 0.001', '\Deltat = 0.0005', 'Location', 'northwest')
title('Explicit Euler')


%%Single Vessel No Drag Runge-Kutta
SVNDRKData3 = load("writeFiles\positionData-SV-ND.txt-1-RK4-dt=0.010000.txt");
SVNDRKData4 = load("writeFiles\positionData-SV-ND.txt-1-RK4-dt=0.005000.txt");

nexttile
plot(SVNDRKData3(:,1), SVNDRKData3(:,2))
hold on
plot(SVNDRKData4(:,1), SVNDRKData4(:,2))
ylabel('Displacement, m')
xlabel('Time, s')
legend('\Deltat = 0.01', '\Deltat = 0.005', 'Location', 'northwest')
title('4th Order Runge Kutta')

nexttile
plot(SVNDRKData3(:,1), SVNDRKData3(:,3))
hold on
plot(SVNDRKData4(:,1), SVNDRKData4(:,3))
ylabel('Velocity, m/s')
xlabel('Time, s')
legend('\Deltat = 0.01', '\Deltat = 0.005', 'Location', 'northwest')
title('4th Order Runge Kutta')

yBarSVND = 1/(1000*0.1);
figure(5)
plot(SVNDFEData5(:,1), SVNDFEData5(:,2) + yBarSVND)
hold on 
plot(SVNDRKData3(:,1), SVNDRKData3(:,2) + yBarSVND)
ylabel('Displacment, m')
xlabel('Time, s')
legend('Explicit Euler', 'Runge-Kutta', 'Location', 'northwest')
title('Displacment Relative to Bottom of Vessel')


figure(2)
tiledlayout(2,2)
%%Single Vessel Low Drag Explicit Euler
SVLDFEData3 = load("writeFiles\positionData-SV-LD.txt-1-FE-dt=0.010000.txt");
SVLDFEData4 = load("writeFiles\positionData-SV-LD.txt-1-FE-dt=0.005000.txt");
SVLDFEData5 = load("writeFiles\positionData-SV-LD.txt-1-FE-dt=0.001000.txt");
SVLDFEData6 = load("writeFiles\positionData-SV-LD.txt-1-FE-dt=0.000500.txt");

nexttile
plot(SVLDFEData3(:,1), SVLDFEData3(:,2))
hold on
plot(SVLDFEData4(:,1), SVLDFEData4(:,2))
plot(SVLDFEData5(:,1), SVLDFEData5(:,2))
plot(SVLDFEData6(:,1), SVLDFEData6(:,2))
ylabel('Displacement, m')
xlabel('Time, s')
legend('\Deltat = 0.01', '\Deltat = 0.005', '\Deltat = 0.001', '\Deltat = 0.0005', 'Location', 'northwest')
title('Explicit Euler')

nexttile
plot(SVLDFEData3(:,1), SVLDFEData3(:,3))
hold on
plot(SVLDFEData4(:,1), SVLDFEData4(:,3))
plot(SVLDFEData5(:,1), SVLDFEData5(:,3))
plot(SVLDFEData6(:,1), SVLDFEData6(:,3))
ylabel('Velocity, m/s')
xlabel('Time, s')
legend('\Deltat = 0.01', '\Deltat = 0.005', '\Deltat = 0.001', '\Deltat = 0.0005', 'Location', 'northwest')
title('Explicit Euler')



%%Single Vessel Low Drag Runge Kuta
SVLDRKData2 = load("writeFiles\positionData-SV-LD.txt-1-RK4-dt=0.050000.txt");
SVLDRKData3 = load("writeFiles\positionData-SV-LD.txt-1-RK4-dt=0.010000.txt");
SVLDRKData4 = load("writeFiles\positionData-SV-LD.txt-1-RK4-dt=0.005000.txt");

nexttile
plot(SVLDRKData2(:,1), SVLDRKData2(:,2))
hold on
plot(SVLDRKData3(:,1), SVLDRKData3(:,2))
plot(SVLDRKData4(:,1), SVLDRKData4(:,2))
ylabel('Displacement, m')
xlabel('Time, s')
legend('\Deltat = 0.1', '\Deltat = 0.05', '\Deltat = 0.01', '\Deltat = 0.005', 'Location', 'northwest')
title('4th Order Runge Kutta')

nexttile
plot(SVLDRKData2(:,1), SVLDRKData2(:,3))
hold on
plot(SVLDRKData3(:,1), SVLDRKData3(:,3))
plot(SVLDRKData4(:,1), SVLDRKData4(:,3))
ylabel('Velocity, m/s')
xlabel('Time, s')
legend('\Deltat = 0.1', '\Deltat = 0.05', '\Deltat = 0.01', '\Deltat = 0.005', 'Location', 'northwest')
title('4th Order Runge Kutta')

yBarSVLD = 5/(1000*0.5);
figure(6)
plot(SVLDRKData3(:,1), SVLDRKData3(:,2) + yBarSVLD)
hold on 
plot(SVLDFEData5(:,1), SVLDFEData5(:,2) + yBarSVLD)
ylabel('Displacment, m')
xlabel('Time, s')
legend('Explicit Euler', 'Runge-Kutta', 'Location', 'northwest')
title('Displacment Relative to Bottom of Vessel')

figure(3)
tiledlayout(2,3)
%%Sinking Vessel Explicit Euler
SinkingVesselFEData1 = load("writeFiles\positionData-SinkingVessel.txt-1-FE-dt=0.100000.txt");
SinkingVesselFEData2 = load("writeFiles\positionData-SinkingVessel.txt-1-FE-dt=0.050000.txt");
SinkingVesselFEData3 = load("writeFiles\positionData-SinkingVessel.txt-1-FE-dt=0.010000.txt");
SinkingVesselFEData4 = load("writeFiles\positionData-SinkingVessel.txt-1-FE-dt=0.005000.txt");

nexttile
plot(SinkingVesselFEData1(:,1), SinkingVesselFEData1(:,2))
hold on
plot(SinkingVesselFEData2(:,1), SinkingVesselFEData2(:,2))
plot(SinkingVesselFEData3(:,1), SinkingVesselFEData3(:,2))
plot(SinkingVesselFEData4(:,1), SinkingVesselFEData4(:,2))
ylabel('Displacement, m')
xlabel('Time, s')
legend('\Deltat = 0.1', '\Deltat = 0.05', '\Deltat = 0.01', '\Deltat = 0.005', '\Deltat = 0.001', '\Deltat = 0.0005', 'Location', 'northwest')
title('Explicit Euler')

nexttile
plot(SinkingVesselFEData1(:,1), SinkingVesselFEData1(:,3))
hold on
plot(SinkingVesselFEData2(:,1), SinkingVesselFEData2(:,3))
plot(SinkingVesselFEData3(:,1), SinkingVesselFEData3(:,3))
plot(SinkingVesselFEData4(:,1), SinkingVesselFEData4(:,3))
ylabel('Velocity, m/s')
xlabel('Time, s')
legend('\Deltat = 0.1', '\Deltat = 0.05', '\Deltat = 0.01', '\Deltat = 0.005', '\Deltat = 0.001', '\Deltat = 0.0005', 'Location', 'northwest')
title('Explicit Euler')

nexttile
plot(SinkingVesselFEData1(:,1), SinkingVesselFEData1(:,4))
hold on
plot(SinkingVesselFEData2(:,1), SinkingVesselFEData2(:,4))
plot(SinkingVesselFEData3(:,1), SinkingVesselFEData3(:,4))
plot(SinkingVesselFEData4(:,1), SinkingVesselFEData4(:,4))
ylabel('Height, m')
xlabel('Time, s')
legend('\Deltat = 0.1', '\Deltat = 0.05', '\Deltat = 0.01', '\Deltat = 0.005', '\Deltat = 0.001', '\Deltat = 0.0005', 'Location', 'northwest')
title('Explicit Euler')


%%Sinking Vessel Runge Kutta
SinkingVesselRKData1 = load("writeFiles\positionData-SinkingVessel.txt-1-RK4-dt=0.100000.txt");
SinkingVesselRKData2 = load("writeFiles\positionData-SinkingVessel.txt-1-RK4-dt=0.050000.txt");

nexttile
plot(SinkingVesselRKData1(:,1), SinkingVesselRKData1(:,2))
hold on
plot(SinkingVesselRKData2(:,1), SinkingVesselRKData2(:,2))
ylabel('Displacement, m')
xlabel('Time, s')
legend('\Deltat = 0.1', '\Deltat = 0.05', '\Deltat = 0.01', '\Deltat = 0.005', '\Deltat = 0.001', '\Deltat = 0.0005', 'Location', 'northwest')
title('Explicit Euler')

nexttile
plot(SinkingVesselRKData1(:,1), SinkingVesselRKData1(:,3))
hold on
plot(SinkingVesselRKData2(:,1), SinkingVesselRKData2(:,3))
ylabel('Velocity, m/s')
xlabel('Time, s')
legend('\Deltat = 0.1', '\Deltat = 0.05', '\Deltat = 0.01', '\Deltat = 0.005', '\Deltat = 0.001', '\Deltat = 0.0005', 'Location', 'northwest')
title('Explicit Euler')

nexttile
plot(SinkingVesselRKData1(:,1), SinkingVesselRKData1(:,4))
hold on
plot(SinkingVesselRKData2(:,1), SinkingVesselRKData2(:,4))
ylabel('Height, m')
xlabel('Time, s')
legend('\Deltat = 0.1', '\Deltat = 0.05', '\Deltat = 0.01', '\Deltat = 0.005', '\Deltat = 0.001', '\Deltat = 0.0005', 'Location', 'northwest')
title('Explicit Euler')

yBarSinkingVessel = 100/(1000*0.1);
figure(7)
plot(SinkingVesselFEData3(:,1), SinkingVesselFEData3(:,2) + yBarSinkingVessel)
hold on 
plot(SinkingVesselRKData2(:,1), SinkingVesselRKData2(:,2) + yBarSinkingVessel)
ylabel('Displacment, m')
xlabel('Time, s')
legend('Explicit Euler', 'Runge-Kutta', 'Location', 'northwest')
title('Displacment Relative to Bottom of Vessel')


figure(4)
tiledlayout(3,3)
%%Three Vesse; Runge Kutta
TVRKData1 = load("writeFiles/positionData-ThreeVessels.txt-3-RK4-dt=0.050000.txt");
TVRKData2 = load("writeFiles/positionData-ThreeVessels.txt-3-RK4-dt=0.010000.txt");
TVRKData3 = load("writeFiles/positionData-ThreeVessels.txt-3-RK4-dt=0.005000.txt");

nexttile
plot(TVRKData1(:,1), TVRKData1(:,2))
hold on
plot(TVRKData2(:,1), TVRKData2(:,2))
plot(TVRKData3(:,1), TVRKData3(:,2))
ylabel('Displacement, m')
xlabel('Time, s')
legend('\Deltat = 0.05', '\Deltat = 0.01', '\Deltat = 0.005', 'Location', 'northwest')
title('Vessel 1')

nexttile
plot(TVRKData1(:,1), TVRKData1(:,3))
hold on
plot(TVRKData2(:,1), TVRKData2(:,3))
plot(TVRKData3(:,1), TVRKData3(:,3))
ylabel('Velocity, m/s')
xlabel('Time, s')
legend('\Deltat = 0.05', '\Deltat = 0.01', '\Deltat = 0.005', 'Location', 'northwest')
title('Vessel 1')

nexttile
plot(TVRKData1(:,1), TVRKData1(:,4))
hold on
plot(TVRKData2(:,1), TVRKData2(:,4))
plot(TVRKData3(:,1), TVRKData3(:,4))
ylabel('Height, m')
xlabel('Time, s')
legend('\Deltat = 0.05', '\Deltat = 0.01', '\Deltat = 0.005', 'Location', 'northwest')
title('Vessel 1')

nexttile
plot(TVRKData1(:,1), TVRKData1(:,5))
hold on
plot(TVRKData2(:,1), TVRKData2(:,5))
plot(TVRKData3(:,1), TVRKData3(:,5))
ylabel('Displacement, m')
xlabel('Time, s')
legend('\Deltat = 0.05', '\Deltat = 0.01', '\Deltat = 0.005', 'Location', 'northwest')
title('Vessel 2')

nexttile
plot(TVRKData1(:,1), TVRKData1(:,6))
hold on
plot(TVRKData2(:,1), TVRKData2(:,6))
plot(TVRKData3(:,1), TVRKData3(:,6))
ylabel('Velocity, m/s')
xlabel('Time, s')
legend('\Deltat = 0.05', '\Deltat = 0.01', '\Deltat = 0.005', 'Location', 'northwest')
title('Vessel 2')

nexttile
plot(TVRKData1(:,1), TVRKData1(:,7))
hold on
plot(TVRKData2(:,1), TVRKData2(:,7))
plot(TVRKData3(:,1), TVRKData3(:,7))
ylabel('Height, m')
xlabel('Time, s')
legend('\Deltat = 0.05', '\Deltat = 0.01', '\Deltat = 0.005', 'Location', 'northwest')
title('Vessel 2')

nexttile
plot(TVRKData1(:,1), TVRKData1(:,8))
hold on
plot(TVRKData2(:,1), TVRKData2(:,8))
plot(TVRKData3(:,1), TVRKData3(:,8))
ylabel('Displacement, m')
xlabel('Time, s')
legend('\Deltat = 0.05', '\Deltat = 0.01', '\Deltat = 0.005', 'Location', 'northwest')
title('Vessel 3')

nexttile
plot(TVRKData1(:,1), TVRKData1(:,9))
hold on
plot(TVRKData2(:,1), TVRKData2(:,9))
plot(TVRKData3(:,1), TVRKData3(:,9))
ylabel('Velocity, m/s')
xlabel('Time, s')
legend('\Deltat = 0.05', '\Deltat = 0.01', '\Deltat = 0.005', 'Location', 'northwest')
title('Vessel 3')

nexttile
plot(TVRKData1(:,1), TVRKData1(:,10))
hold on
plot(TVRKData2(:,1), TVRKData2(:,10))
plot(TVRKData3(:,1), TVRKData3(:,10))
ylabel('Height, m')
xlabel('Time, s')
legend('\Deltat = 0.05', '\Deltat = 0.01', '\Deltat = 0.005', 'Location', 'northwest')
title('Vessel 3')


figure(9)
tiledlayout(3,3)
%%FE Three Vessels
TVFEData1 = load("writeFiles/positionData-ThreeVessels.txt-3-FE-dt=0.001000.txt");
TVFEData2 = load("writeFiles/positionData-ThreeVessels.txt-3-FE-dt=0.000500.txt");
TVFEData3 = load("writeFiles/positionData-ThreeVessels.txt-3-FE-dt=0.000100.txt");

nexttile
plot(TVFEData1(:,1), TVFEData1(:,2))
hold on
plot(TVFEData2(:,1), TVFEData2(:,2))
plot(TVFEData3(:,1), TVFEData3(:,2))
ylabel('Displacement, m')
xlabel('Time, s')
legend('\Deltat = 0.001', '\Deltat = 0.0005', '\Deltat = 0.0001', 'Location', 'northwest')
title('Vessel 1')

nexttile
plot(TVFEData1(:,1), TVFEData1(:,3))
hold on
plot(TVFEData2(:,1), TVFEData2(:,3))
plot(TVFEData3(:,1), TVFEData3(:,3))
ylabel('Velocity, m/s')
xlabel('Time, s')
legend('\Deltat = 0.001', '\Deltat = 0.0005', '\Deltat = 0.0001', 'Location', 'northwest')
title('Vessel 1')

nexttile
plot(TVFEData1(:,1), TVFEData1(:,4))
hold on
plot(TVFEData2(:,1), TVFEData2(:,4))
plot(TVFEData3(:,1), TVFEData3(:,4))
ylabel('Height, m')
xlabel('Time, s')
legend('\Deltat = 0.001', '\Deltat = 0.0005', '\Deltat = 0.0001', 'Location', 'northwest')
title('Vessel 1')

nexttile
plot(TVFEData1(:,1), TVFEData1(:,5))
hold on
plot(TVFEData2(:,1), TVFEData2(:,5))
plot(TVFEData3(:,1), TVFEData3(:,5))
ylabel('Displacement, m')
xlabel('Time, s')
legend('\Deltat = 0.001', '\Deltat = 0.0005', '\Deltat = 0.0001', 'Location', 'northwest')
title('Vessel 2')

nexttile
plot(TVFEData1(:,1), TVFEData1(:,6))
hold on
plot(TVFEData2(:,1), TVFEData2(:,6))
plot(TVFEData3(:,1), TVFEData3(:,6))
ylabel('Velocity, m/s')
xlabel('Time, s')
legend('\Deltat = 0.001', '\Deltat = 0.0005', '\Deltat = 0.0001', 'Location', 'northwest')
title('Vessel 2')

nexttile
plot(TVFEData1(:,1), TVFEData1(:,7))
hold on
plot(TVFEData2(:,1), TVFEData2(:,7))
plot(TVFEData3(:,1), TVFEData3(:,7))
ylabel('Height, m')
xlabel('Time, s')
legend('\Deltat = 0.001', '\Deltat = 0.0005', '\Deltat = 0.0001', 'Location', 'northwest')
title('Vessel 2')

nexttile
plot(TVFEData1(:,1), TVFEData1(:,8))
hold on
plot(TVFEData2(:,1), TVFEData2(:,8))
plot(TVFEData3(:,1), TVFEData3(:,8))
ylabel('Displacement, m')
xlabel('Time, s')
legend('\Deltat = 0.001', '\Deltat = 0.0005', '\Deltat = 0.0001', 'Location', 'northwest')
title('Vessel 3')

nexttile
plot(TVFEData1(:,1), TVFEData1(:,9))
hold on
plot(TVFEData2(:,1), TVFEData2(:,9))
plot(TVFEData3(:,1), TVFEData3(:,9))
ylabel('Velocity, m/s')
xlabel('Time, s')
legend('\Deltat = 0.001', '\Deltat = 0.0005', '\Deltat = 0.0001', 'Location', 'northwest')
title('Vessel 3')

nexttile
plot(TVFEData1(:,1), TVFEData1(:,10))
hold on
plot(TVFEData2(:,1), TVFEData2(:,10))
plot(TVFEData3(:,1), TVFEData3(:,10))
ylabel('Height, m')
xlabel('Time, s')
legend('\Deltat = 0.001', '\Deltat = 0.0005', '\Deltat = 0.0001', 'Location', 'northwest')
title('Vessel 3')




yBarThreeVessel1 = 1/(1000*0.1);
yBarThreeVessel2 = 10/(1000*0.5);
yBarThreeVessel3 = 50/(1000*10);
figure(8)
plot(TVFEData2(:,1), TVFEData2(:,2) + yBarThreeVessel1);
hold on
plot(TVFEData2(:,1), TVFEData2(:,5) + yBarThreeVessel2);
plot(TVFEData2(:,1), TVFEData2(:,8) + yBarThreeVessel3);
plot(TVRKData2(:,1), TVRKData2(:,2) + yBarThreeVessel1);
plot(TVRKData2(:,1), TVRKData2(:,5) + yBarThreeVessel2);
plot(TVRKData2(:,1), TVRKData2(:,8) + yBarThreeVessel3);
ylabel('Displacment, m')
xlabel('Time, s')
legend('Explicit Euler Vessel 1', 'Runge-Kutta Vessel 1', 'Explicit Euler Vessel 2', 'Runge-Kutta Vessel 2', 'Explicit Euler Vessel 3', 'Runge-Kutta Vessel 3', 'Location', 'northwest')
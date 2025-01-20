clc
clear
close all

data = load("writeFiles\positionData-freqAnalysis.txt-30-FE-dt=0.001000.txt");
s = size(data);

numberOfVessels = (s(2)-1)/3;
numberOfTimeSteps = s(1);
timeSteps = data(:, 1);
dt = 0.00100;
f = 1/dt;

i = 0;
while i < numberOfVessels
    position = data(:, 3*i + 2);
    detrendedPosition = detrend(position);

    fftResult = fft(detrendedPosition);
    frequenciesHz = (0:numberOfTimeSteps-1) * (f/numberOfTimeSteps); % Frequency axis

    % Consider only the first half of the spectrum
    magnitude = abs(fftResult(1:floor(numberOfTimeSteps/2)));
    frequenciesHz = frequenciesHz(1:floor(numberOfTimeSteps/2));

    % Find the frequency with the maximum magnitude
    [~, maxIdx] = max(magnitude);
    dominantFrequency = frequenciesHz(maxIdx);
    frequencies(i+1) = dominantFrequency;
    i = i + 1;
end

% Display the results
disp('Dominant Frequencies (Hz):');
disp(frequencies);
%System Conditions
%increasing gravity increases frequency, increasing density increases frequency 
%Everything else has no affect

%Vessel Conditions
%increasing mass decreases frequency, increasing area increases frequency,
%increasing starting height decreases frequency
%Everything else has no affect

freqDiffMass = frequencies(1:5);
Masses = 10:10:50;
freqDiffArea = frequencies(6:10);
Areas = 0.1:0.1:0.5;
freqDiffCoP = frequencies(11:15);
CoP = 0:0.1:0.4;
freqDiffy0 = frequencies(16:20);
y0 = 0.0:0.1:0.4;
freqDiffv0 = frequencies(21:25);
v0 = 0.0:0.1:0.4;
freqDiffh0 = frequencies(25:30);
h0 = 0:0.1:0.5;

figure(1)
tiledlayout(1,3)
nexttile
plot(Masses, freqDiffMass)
xlabel("Mass, m")
ylabel("Frequency")
nexttile
plot(Areas, freqDiffArea)
xlabel("Area, A")
ylabel("Frequency")
nexttile
plot(h0, freqDiffh0 )
xlabel("Starting Water Level, h_0")
ylabel("Frequency")



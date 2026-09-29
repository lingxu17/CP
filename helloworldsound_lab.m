% --- Sound Parameters ---
fs = 48000; %44100;           % Sampling rate (samples per second)
duration = 1.5;       % Duration in seconds
t = 0:1/fs:duration;  % Time vector

% --- Editable Variables for Kids ---
freq = 440;           % Pitch in Hertz (e.g., 262 = Middle C, 440 = A4, 1000 = High Tone)
amplitude = 0.5;      % Volume from 0.0 (silent) to 1.0 (max loudness)

% --- Generate Tone ---
wave = amplitude * sin(2 * pi * freq * t);

% --- Visual Demonstration ---
figure('Name', 'Sound Wave Visualizer', 'NumberTitle', 'off');

% Plot a small slice (first 10 milliseconds) so the kids can see individual waves
samplesToPlot = round(0.010 * fs); 
plot(t(1:samplesToPlot) * 1000, wave(1:samplesToPlot), 'LineWidth', 2, 'Color', [0 0.45 0.74]);

grid on;
ylim([-1.1, 1.1]);
xlabel('Time (milliseconds)');
ylabel('Wave Height (Amplitude)');
title(sprintf('Frequency: %d Hz | Amplitude: %.1f', freq, amplitude));

% --- Play Sound ---
sound(wave, fs);

clear;
close all;
clc;

%% Parameters
fs = 16000;                % Sampling frequency [Hz]
duration = 2;              % Signal duration [seconds]
fTone = 1000;              % Tone frequency [Hz]

t = 0:1/fs:duration-1/fs;

%% ============================================================
% 1. CREATE A CLEAN TONE
% ============================================================

tone = 0.3 * sin(2*pi*fTone*t);

figure;

subplot(3,1,1);
plot(t, tone);
xlim([0 0.02]);            % Show first 20 ms
ylim([-1 1]);
grid on;

title('1. Clean 1 kHz Tone');
xlabel('Time [s]');
ylabel('Amplitude');

disp('Playing clean tone...');
soundsc(tone, fs);
pause(duration + 1);


%% ============================================================
% 2. ADD NOISE
% ============================================================

noise = 0.4 * randn(size(tone));

noisySignal = tone + noise;

subplot(3,1,2);
plot(t, noisySignal);
xlim([0 0.02]);
ylim([-1 1]);
grid on;

title('2. Tone + White Noise');
xlabel('Time [s]');
ylabel('Amplitude');

disp('Playing noisy signal...');
soundsc(noisySignal, fs);
pause(duration + 1);


%% ============================================================
% 3. SIMPLE NOISE REDUCTION
% ============================================================

% Keep frequencies around the 1 kHz tone
lowCutoff  = 800;
highCutoff = 1200;

% Design 6th-order Butterworth band-pass filter
[b, a] = butter(3, ...
    [lowCutoff highCutoff] / (fs/2), ...
    'bandpass');

% Apply filter
filteredSignal = filter(b, a, noisySignal);

subplot(3,1,3);
plot(t, filteredSignal);
xlim([0 0.02]);
ylim([-1 1]);
grid on;

title('3. After Noise Reduction');
xlabel('Time [s]');
ylabel('Amplitude');

disp('Playing filtered signal...');
soundsc(filteredSignal, fs);


%% Make figure easier to read
sgtitle('Simple Noise Reduction Demonstration');
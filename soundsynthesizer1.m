% --- MINI SOUND SYNTHESIZER ---
clear; clc;

Fs = 8000;          % Sampling frequency (8000 samples per second)
dur = 0.3;          % Duration of each note in seconds
t = 0:1/Fs:dur;     % Time vector array

% Define musical notes (frequencies in Hz)
% C4, D4, E4, F4, G4, A4, B4, C5
noteFreqs = [261.63, 293.66, 329.63, 349.23, 392.00, 440.00, 493.88, 523.25];

% Let's play a mini song sequence (indices of the notes above)
songIndices = [1, 3, 5, 6, 5, 3, 1, 5, 5, 3, 1];

disp('Playing Smooth Sine Wave Melody...');
melodyVector = [];

for i = 1:length(songIndices)
    freq = noteFreqs(songIndices(i));

    % 1. Smooth Sine Wave (like a flute or pure tone)
    noteWave = sin(2 * pi * freq * t);

    % Append note + a tiny silence pause (zeros) to separate notes
    melodyVector = [melodyVector, noteWave, zeros(1, 400)];
end

% Play the song!
sound(melodyVector, Fs);
pause(4); % Wait for song to finish

disp('Playing Retro 8-Bit Arcade Wave (Square Wave)...');
retroVector = [];

for i = 1:length(songIndices)
    freq = noteFreqs(songIndices(i));

    % 2. Retro Square Wave (like an old Nintendo NES game)
    noteWave = sign(sin(2 * pi * freq * t)); 

    retroVector = [retroVector, noteWave, zeros(1, 400)];
end

% Play the retro version!
sound(retroVector, Fs);
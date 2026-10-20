%%%Phase 3  "Sci-Fi Sound Effects & Laser Guns"

% --- RETRO LASER GUN SYNTHESIZER ---
fs = 44100;
t = 0:1/fs:0.3; % Short 0.3 second blast

% Frequency sweeps rapidly from 1200 Hz down to 200 Hz
f_start = 1200;
f_end = 200;
freq_sweep = linspace(f_start, f_end, length(t));

% Generate laser signal
laser = sin(2*pi.*freq_sweep.*t);

% Add a little noise for a "crunchy" blast effect
laser_noisy = laser + 0.1 * randn(size(t));

% Play it!
sound(laser_noisy, fs);


% Simple musical notes dictionary (Hz)
C = 261.63; D = 293.66; E = 329.63; F = 349.23; G = 392.00; A = 440.00;

% Duration of each note (0.3 seconds)
t_note = 0:1/fs:0.3;

% Create individual note signals
noteC = sin(2*pi*C*t_note);
noteE = sin(2*pi*E*t_note);
noteG = sin(2*pi*G*t_note);

% Chain them together to make a tune!
song = [noteC, noteE, noteG, noteC*2]; % C-E-G-HighC
sound(song, fs);
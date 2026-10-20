% --- 8-Bit Super Mario Jump Generator ---
fs = 8000;                      

% 1. Frequency sweep (150 Hz up to 1200 Hz, then hold)
t1 = 0:1/fs:0.08;
freq1 = linspace(150, 1200, length(t1)); 
t2 = 0.08:1/fs:0.2;
freq2 = 1200 * ones(1, length(t2));

t = [t1, t2];
freq = [freq1, freq2];

% 2. Generate NES Square Wave & Volume Fade
mario_jump = square(2 * pi * freq .* t);
envelope = linspace(1, 0, length(mario_jump));
mario_jump = mario_jump .* envelope;

% 3. Play sound!
sound(mario_jump, fs);
pause(0.5);
% --- 3D Directional Audio Demo ---
fs = 8000;
t = 0:1/fs:0.3;
sound_effect = chirp(t, 2000, 0.3, 100); % Our laser sound

% 1. Left Ear: Plays immediately and clearly
left_channel = sound_effect;

% 2. Right Ear: Delayed by 0.0005 seconds (500 microseconds) and muffled
delay_samples = round(0.0005 * fs);
right_channel = [zeros(1, delay_samples), sound_effect(1:end-delay_samples)];

% Muffle high frequencies on the right channel using a moving average filter
b = [0.25 0.25 0.25 0.25];
right_channel = filter(b, 1, right_channel);

% Combine into a Stereo Vector [Left, Right]
stereo_sound = [left_channel', right_channel'];

% Play through headphones!
sound(stereo_sound, fs);
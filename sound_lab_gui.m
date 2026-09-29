function sound_lab_gui()
% --- Main Window Setup ---
fig = uifigure('Name', 'Kids Sound & Wave Lab', 'Position', [100 100 650 500]);

% Sampling parameters
fs = 44100;

% --- Create Axes Plot ---
ax = uiaxes(fig, 'Position', [50 200 550 250]);
grid(ax, 'on');
ylim(ax, [-1.1 1.1]);
xlabel(ax, 'Time (milliseconds)');
ylabel(ax, 'Amplitude (Wave Height)');

% --- Frequency Control (Slider + Label) ---
uilabel(fig, 'Position', [50 140 150 22], 'Text', 'Pitch (Frequency - Hz):', 'FontWeight', 'bold');
freqSlider = uislider(fig, 'Position', [200 150 300 3], ...
    'Limits', [100 2000], 'Value', 440, ...
    'ValueChangedFcn', @(src, event) updatePlot());
freqLabel = uilabel(fig, 'Position', [515 140 80 22], 'Text', '440 Hz');

% --- Volume Control (Slider + Label) ---
uilabel(fig, 'Position', [50 80 150 22], 'Text', 'Volume (Amplitude):', 'FontWeight', 'bold');
ampSlider = uislider(fig, 'Position', [200 90 300 3], ...
    'Limits', [0.1 1.0], 'Value', 0.5, ...
    'ValueChangedFcn', @(src, event) updatePlot());
ampLabel = uilabel(fig, 'Position', [515 80 80 22], 'Text', '0.5');

% --- Play Sound Button ---
playBtn = uibutton(fig, 'push', 'Position', [250 25 150 40], ...
    'Text', '🔊 Play Sound', 'FontSize', 14, ...
    'ButtonPushedFcn', @(src, event) playSound());

% Initial plot render
updatePlot();

% --- Nested Functions ---
    function [t_slice, wave_slice] = getCurrentWave()
        freq = freqSlider.Value;
        amp = ampSlider.Value;

        % Plot 10 ms window
        t_slice = 0 : 1/fs : 0.010;
        wave_slice = amp * sin(2 * pi * freq * t_slice);
    end

    function updatePlot()
        freq = round(freqSlider.Value);
        amp = round(ampSlider.Value, 2);

        freqLabel.Text = sprintf('%d Hz', freq);
        ampLabel.Text = sprintf('%.2f', amp);

        [t_slice, wave_slice] = getCurrentWave();

        % Plot wave on axes
        plot(ax, t_slice * 1000, wave_slice, 'LineWidth', 2.5, 'Color', [0.85 0.32 0.1]);
        title(ax, sprintf('Frequency: %d Hz | Amplitude: %.2f', freq, amp));
        ylim(ax, [-1.1 1.1]);
        grid(ax, 'on');
    end

    function playSound()
        freq = freqSlider.Value;
        amp = ampSlider.Value;
        duration = 1.0; % Play for 1 second

        t = 0 : 1/fs : duration;
        full_wave = amp * sin(2 * pi * freq * t);

        sound(full_wave, fs);
    end
end
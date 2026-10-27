import time

import matplotlib.pyplot as plt
import numpy as np
import sounddevice as sd
from scipy.signal import butter, lfilter


# ============================================================
# Parameters
# ============================================================
fs = 16000                 # Sampling frequency [Hz]
duration = 2.0             # Duration of each sound [seconds]
f_tone = 1000              # Tone frequency [Hz]
update_interval = 0.02      # Graph update interval [seconds]

# Time axis
t = np.arange(0, duration, 1 / fs)

# Use the same random noise each time the program runs.
# Remove this line if you want different noise on every run.
np.random.seed(7)


# ============================================================
# Create the three signals
# ============================================================

# 1. Clean 1 kHz tone
tone = 0.3 * np.sin(2 * np.pi * f_tone * t)

# 2. Tone plus white noise
noise = 0.4 * np.random.randn(len(tone))
noisy_signal = tone + noise

# 3. Band-pass noise reduction around the known 1 kHz tone
low_cutoff = 800
high_cutoff = 1200

b, a = butter(
    3,
    [low_cutoff, high_cutoff],
    btype="bandpass",
    fs=fs,
)

filtered_signal = lfilter(b, a, noisy_signal)


# ============================================================
# Function: play one signal and draw it progressively
# ============================================================
def play_and_draw(axis, signal, title, color, y_limit):
    """Play a signal while drawing its waveform from left to right."""

    axis.set_xlim(0, duration)
    axis.set_ylim(-y_limit, y_limit)
    axis.grid(True)
    axis.set_title(title)
    axis.set_xlabel("Time [s]")
    axis.set_ylabel("Amplitude")

    # Initially create an empty line
    line, = axis.plot([], [], color=color, linewidth=1)

    # Force the new graph to appear before sound playback starts
    figure.canvas.draw()
    figure.canvas.flush_events()
    plt.pause(0.1)

    print(f"Playing: {title}")
    sd.play(signal, fs)

    start_time = time.perf_counter()

    while True:
        elapsed = time.perf_counter() - start_time

        # Calculate how many samples should be visible now
        last_sample = min(int(elapsed * fs), len(signal))

        line.set_data(t[:last_sample], signal[:last_sample])
        figure.canvas.draw_idle()
        figure.canvas.flush_events()

        if last_sample >= len(signal):
            break

        plt.pause(update_interval)

    sd.wait()

    # Ensure the complete waveform is visible
    line.set_data(t, signal)
    figure.canvas.draw_idle()
    figure.canvas.flush_events()
    plt.pause(0.4)


# ============================================================
# Display and play the signals one by one
# ============================================================
plt.ion()  # Interactive mode: display graphs without blocking the program

figure, axes = plt.subplots(3, 1, figsize=(11, 8))
figure.suptitle("Simple Noise Reduction Demonstration", fontsize=15)
figure.tight_layout(rect=[0, 0, 1, 0.96])

# Hide all plots initially. Each one becomes visible at its stage.
for axis in axes:
    axis.set_visible(False)

plt.show(block=False)

# Stage 1: reveal, hear, and draw the clean signal
axes[0].set_visible(True)
play_and_draw(
    axes[0],
    tone,
    "1. Clean 1 kHz Tone",
    "tab:blue",
    1.0,
)

# Stage 2: reveal, hear, and draw the noisy signal
axes[1].set_visible(True)
play_and_draw(
    axes[1],
    noisy_signal,
    "2. Tone + White Noise",
    "tab:orange",
    1.5,
)

# Stage 3: reveal, hear, and draw the filtered signal
axes[2].set_visible(True)
play_and_draw(
    axes[2],
    filtered_signal,
    "3. After Band-pass Noise Reduction",
    "tab:green",
    1.0,
)

print("Demonstration finished. Close the graph window to exit.")

# Turn off interactive mode and keep the completed figure open
plt.ioff()
plt.show()

import numpy as np
import sounddevice as sd
from scipy.signal import butter, filtfilt
import time

fs = 44100
t = np.arange(0, 1, 1 / fs)
freq = 440
amp = 0.5

# Sinussignal
wave = amp * np.sin(2 * np.pi * freq * t)

# Tilføj støj
noise = 0.3 * np.random.randn(len(t))
noisy_wave = wave + noise

# 4. ordens Butterworth low-pass filter
b, a = butter(4, 600 / (fs / 2), btype="low")

# Filtrer støjen
clean_wave = filtfilt(b, a, noisy_wave)

# Afspil signal med støj
sd.play(noisy_wave, fs)
sd.wait()

# Pause
time.sleep(0.5)

# Afspil det filtrerede signal
sd.play(clean_wave, fs)
sd.wait()
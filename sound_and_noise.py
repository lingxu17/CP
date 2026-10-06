import numpy as np
import matplotlib.pyplot as plt
import sounddevice as sd

fs = 44100
t = np.arange(0, 1, 1 / fs)
freq = 440
amp = 0.5

wave = amp * np.sin(2 * np.pi * freq * t)

sd.play(wave, fs)
sd.wait()


plt.figure()
plt.plot(t[:1000], wave[:1000], linewidth=2)
plt.title("Original Signal")
plt.xlabel("Time")
plt.ylabel("Amplitude")
plt.grid(True)
plt.show()

noise = 0.3 * np.random.randn(len(t))

noisy_wave = wave + noise
sd.play(noisy_wave, fs)
sd.wait()

plt.figure()
plt.plot(t[:1000], noisy_wave[:1000])
plt.title("Signal Contaminated by Noise")
plt.xlabel("Time")
plt.ylabel("Amplitude")
plt.grid(True)
plt.show()

# Respiratory Rate Estimation from PPG Signals

![PPG Signal Example](https://via.placeholder.com/800x400?text=PPG+Respiratory+Rate+Estimation)

## Table of Contents

1. [Overview](#overview)
2. [Objective](#objective)
3. [Methodology](#methodology)
4. [Dataset Source](#dataset-source)
5. [Preprocessing & Signal Analysis](#preprocessing--signal-analysis)
6. [Reference Paper](#reference-paper)
7. [How to Run](#how-to-run)
8. [Results](#results)
9. [Contributors](#contributors)

---

## Overview

This project implements a **robust algorithm** to estimate **respiratory rate (RR)** from **Photoplethysmogram (PPG)** signals. The technique leverages a **digital resonator filter** followed by **frequency-domain analysis (FFT)** to extract the dominant respiratory frequency.

---

## Objective

Estimate the **respiratory rate (breaths per minute)** from PPG signals using:

* Bandpass filtering to isolate respiratory frequency
* A **digital resonator** for signal enhancement
* **Fast Fourier Transform (FFT)** for frequency extraction

---

## Methodology

### Workflow:

1. Load raw PPG data (sampled at 100 Hz)
2. Apply a **bandpass filter** between 0.1–0.4 Hz
3. Design and apply a **digital resonator** centered at 0.25 Hz
4. Perform **FFT** on the enhanced signal
5. Detect the **dominant frequency** in the respiratory band
6. Convert the peak frequency from Hz to **breaths per minute (BPM)**

---

## Dataset Source

* **Source**: Publicly available or simulated PPG datasets (e.g., PhysioNet)
* **Format**: `.mat` or `.csv`
* **Sampling Rate**: 100 Hz used in this implementation (can be adjusted)

---

## Preprocessing & Signal Analysis

### Signal Processing Details:

* **Bandpass Filter**: 0.1–0.4 Hz (covers typical respiration frequencies)
* **Digital Resonator**:

  * Designed with center frequency = 0.25 Hz
  * Form: `y[n] = 2 * cos(w0) * y[n-1] - y[n-2] + x[n] - 2 * cos(w0) * x[n-1] + x[n-2]`
* **FFT**:

  * Applied to resonated signal
  * Extract dominant peak in frequency range

### Code Snippet (Simplified):

```python
# Design digital resonator
w0 = 2 * np.pi * 0.25 / sampling_rate
a = [1, -2 * np.cos(w0), 1]
b = [1, -2 * np.cos(w0), 1]
resonated_signal = signal.lfilter(b, a, bandpassed_signal)

# Apply FFT and extract respiratory rate
spectrum = np.fft.fft(resonated_signal)
freqs = np.fft.fftfreq(len(spectrum), d=1/sampling_rate)
resp_band = (freqs > 0.1) & (freqs < 0.4)
peak_freq = freqs[resp_band][np.argmax(np.abs(spectrum[resp_band]))]
respiratory_rate = peak_freq * 60
```

---

## Reference Paper

Based on:

**"An Automated Algorithm for Estimating Respiration Rate from PPG Signals"**
*Authors*: K. Manojkumar, S. Boppu, M. Sabarimalai Manikandan
*Published in*: IEEE Sensors Journal
*DOI*: *\[Add here if available]*

The paper proposes a low-complexity digital resonator combined with spectral analysis for efficient RR estimation from wearable sensors.

---

## How to Run

### Requirements:

* Python 3.8+
* Required packages: `numpy`, `scipy`, `matplotlib`, `pandas`

### Running the Code:

```bash
python estimate_rr.py
```

Or via Jupyter Notebook:

```bash
jupyter notebook Respiratory_Rate_Estimation.ipynb
```

---

## Results

The implemented method consistently estimates the respiratory rate with high accuracy, even in the presence of mild noise and signal variation.

### Sample Output (Console):

```
Peak frequency in Hz: 0.28
Estimated Respiratory Rate: 16.8 BPM
```

### Spectrum Plot:

* A plotted FFT spectrum highlights the dominant frequency peak in the 0.1–0.4 Hz range.
* You may visualize intermediate and final signals for analysis.

---

## Contributors

* **kvsh2050** – Code implementation, optimization, and documentation
* Inspired by the algorithm presented by Manojkumar et al. in IEEE Sensors Journal


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

This project presents an **automated and efficient algorithm** to estimate **respiratory rate (RR)** using **Photoplethysmogram (PPG)** signals. The approach is based on frequency domain analysis, inspired by methods detailed in research literature.

---

## Objective

To estimate the **respiration rate** (in breaths per minute) from raw PPG signals using:

* Preprocessing and filtering techniques
* A **digital resonator** to enhance respiratory components
* **Fourier Transform** to extract the dominant respiratory frequency

---

## Methodology

### Steps Followed:

1. **Download PPG signal data** from a publicly available repository (PhysioNet).
2. **Preprocess** the signal to remove noise and trends.
3. Apply a **digital resonator filter** to isolate the respiratory frequency band.
4. Perform **Fast Fourier Transform (FFT)** on the filtered signal to obtain its frequency spectrum.
5. Identify the **peak frequency** in the respiratory band.
6. Multiply the peak frequency by `60` to convert from Hz to **breaths per minute (BPM)**.

---

## Dataset Source

* **Source**: [PhysioNet ATM](https://physionet.org)
* **Type**: Clinical-grade PPG signals
* **Format**: `.mat` or `.csv`, depending on dataset
* **Sampling Rate**: Typically 100–125 Hz (adjusted during preprocessing)

---

## Preprocessing & Signal Analysis

### Techniques Used:

* **Bandpass filtering** (typically 0.1–0.4 Hz) to isolate respiratory range
* **Digital Resonator**: A band-enhancing filter to boost weak respiratory patterns
* **Fourier Transform**: Converts time-domain signal to frequency domain for spectral analysis
* **Peak Detection**: Finds the frequency with the highest energy (respiratory rate)

### Code Snippet (Core Logic):

```python
# Perform FFT on filtered signal
spectrum = np.fft.fft(filtered_signal)
freqs = np.fft.fftfreq(len(spectrum), d=1/sampling_rate)

# Focus on respiratory range (e.g., 0.1 to 0.4 Hz)
resp_band = (freqs > 0.1) & (freqs < 0.4)
peak_freq = freqs[resp_band][np.argmax(np.abs(spectrum[resp_band]))]

# Convert to breaths per minute
respiratory_rate = peak_freq * 60
```

---

## Reference Paper

This implementation is based on the algorithm described in the research paper:

**"An Automated Algorithm for Estimating Respiration Rate from PPG Signals"**

* *Authors*: K. Manojkumar, S. Boppu, and M. Sabarimalai Manikandan
* *Journal*: IEEE Sensors Journal
* *DOI*: \[Add if available]

The paper presents a frequency-domain method optimized for real-time and resource-efficient estimation of RR in wearable devices and remote health monitoring applications.

---

## How to Run

### Dependencies:

* Python 3.8+
* `numpy`, `scipy`, `matplotlib`, `pandas`

### Run the Script:

```bash
python estimate_rr.py
```

Or run via Jupyter Notebook:

```bash
jupyter notebook Respiratory_Rate_Estimation.ipynb
```

---

## Results

The estimated respiratory rate aligns well with ground truth values across various subjects. The method demonstrates robustness against motion artifacts and signal noise.

### Example Output:

```
Peak Frequency: 0.28 Hz
Estimated Respiratory Rate: 16.8 BPM
```

---

## Contributors

* **kvsh2050** – Implementation, adaptation, and documentation
* Inspired by the authors of the referenced IEEE paper


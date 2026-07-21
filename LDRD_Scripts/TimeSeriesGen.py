# In[]
#Importing Libraries
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import os
# %%
#Setting initial variables to define time and magnitude
mag = 5.5E3
Time = 180
seed = 0

# %%
#Function for generating random data
def gen_series(mag, n, tol, s, alpha=0.3):
    rng = np.random.default_rng(seed=s)

    values = [mag]
    for _ in range(n - 1):
        step = rng.uniform(-tol, tol)
        raw_next = values[-1] + step
        smoothed_next = alpha * raw_next + (1 - alpha) * values[-1]
        next_val = np.clip(smoothed_next, -mag, mag)
        values.append(next_val)

    values = np.array(values)
    plt.plot(values)
    return values
# %%
pumpSeries = gen_series(20, 1800, 0.5, 42)
pumpStatic = gen_series(20, 1800, 0, 42)
# %%
topvalveSeries = gen_series(1, 1800, 0.1, 108)
topvalveStatic = gen_series(1, 1800, 0, 42)
# %%
botvalveSeries = gen_series(1, 1800, 0.1, 42)
botvalveStatic = gen_series(1, 1800, 0, 42)

# %%
heaterSeries = gen_series(5.5E3, 1800, 50, 93)
heaterStatic = topValveStatic = gen_series(3.5E3, 1800, 0, 42)
# %%
#Function for generating .csv file
def gen_data(file_name, values, t=1800, dt=0.1):
    """
    Writes a Modelica CombiTimeTable text file.

    file_name: full path (without extension) - also used as table name
    values: 1D array of data values (time column is generated automatically)
    t: total duration in seconds (used only if you want dt derived from n instead - see note below)
    dt: time step between samples (seconds)
    """

    n = len(values)
    time = np.arange(n) * dt

    # Table name must match the CombiTimeTable component name in Modelica,
    # and cannot contain spaces or path separators.
    table_name = os.path.basename(file_name)

    with open(f'{file_name}.txt', 'w') as f:
        f.write('#1\n')
        f.write(f'double {table_name}({n},2)\n')
        for ti, vi in zip(time, values):
            f.write(f'{ti:.6f}\t{vi}\n')

    return table_name

# %%
Pump_Speed = gen_data(r'C:\INL LDRD Project Files\NCFL\DataSeries\pump', pumpSeries)
Pump_SpeedS = gen_data(r'C:\INL LDRD Project Files\NCFL\DataSeries\pump_static', pumpStatic)
TopValve_Opening = gen_data(r'C:\INL LDRD Project Files\NCFL\DataSeries\topValve', topvalveSeries)
TopValve_OpeningS = gen_data(r'C:\INL LDRD Project Files\NCFL\DataSeries\topValve_static', topvalveStatic)
BotValve_Opening = gen_data(r'C:\INL LDRD Project Files\NCFL\DataSeries\botValve', botvalveSeries)
BotValve_OpeningS = gen_data(r'C:\INL LDRD Project Files\NCFL\DataSeries\botValve_static', botvalveStatic)
Heater_Power = gen_data(r'C:\INL LDRD Project Files\NCFL\DataSeries\Heater', heaterSeries)
Heater_PowerS = gen_data(r'C:\INL LDRD Project Files\NCFL\DataSeries\Heater_static', heaterStatic)
# %%

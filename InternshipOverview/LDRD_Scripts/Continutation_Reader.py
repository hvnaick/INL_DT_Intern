# In[]
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# In[]
file_path = r"C:\INL LDRD Project Files\NCFL\continuation.csv"
continuation = pd.read_csv(file_path, delimiter=";")

# In[]
continuation.columns

# In[]
continuation['ncfl.Distance2Heaters.port_b.p'][0]
# %%
def detect_anomalies(file_path, threshold_pct=20):
    df = pd.read_csv(file_path, sep=';')

    anomalies = []
    for col in df.columns:
        if col == 'lambda':
            continue
        pct_change = df[col].pct_change() * 100 
        for idx in pct_change.index[1:]:
            diff = pct_change[idx]
            if pd.notna(diff) and abs(diff) >= threshold_pct:
                anomalies.append([col, f"{idx-1} to {idx}", round(diff, 1)])

    return anomalies
# %%
detect_anomalies(file_path, 30)

# %%
continuation
# %%

# In[]
#importing libraries
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
# %%
fivehr = pd.read_csv(r"NCFL_Modular 3.csv")
# %%
fivehr
# %%
#Temp difference plot
plt.figure()
plt.plot(fivehr["Time"], fivehr["ncfl.T_diff_CL.y"], label="Cold Leg")
plt.plot(fivehr["Time"], fivehr["ncfl.T_diff_HL.y"], label="Hot Leg")
plt.ylabel("ΔT(K)")
plt.xlabel("Time(s)")
plt.title("Temperature Difference (NCFL)")
plt.legend()
plt.grid(True)
# %%
#Volume Flow plot
plt.figure()
plt.plot(fivehr["Time"], fivehr["ncfl.V_top.V_flow"], label="Top Valve")
plt.plot(fivehr["Time"], fivehr["ncfl.V_bot.V_flow"], label="Bottom Valve")
plt.ylabel("m^3/s")
plt.xlabel("Time(s)")
plt.title("Volume Flow Difference (NCFL)")
plt.legend()
plt.grid(True)
# %%

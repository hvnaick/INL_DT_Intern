#!/usr/bin/env python
# coding: utf-8

# In[46]:
#Clearing any Dymola processes running

import subprocess
subprocess.run(["taskkill", "/f", "/im", "Dymola.exe"], capture_output=True)

print("Clean slate ready")

# ====================================

# In[47]:


#Importing Dymola interface
import sys
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
sys.path.insert(0, r"C:\Program Files\Dymola 2023x\Modelica\Library\python_interface\dymola.egg")

from dymola.dymola_interface import DymolaInterface

dymola = DymolaInterface()

# ====================================


# In[49]:
#Loading TRANSFORM and NHES libraries into Dymola instance

TRANSFORM = dymola.openModel(r"C:\INL LDRD Project Files\Dymola_Packages\TRANSFORM-Library\TRANSFORM\package.mo", mustRead=True, changeDirectory=False) # TRANSFORM
NHES = dymola.openModel(r"C:\INL LDRD Project Files\AR_DT\Linyu\AR_DigitalTwin\AR_DigitalTwin\modeling\Physics-Based\Dymola\HYBRID\Models\NHES\package.mo", mustRead=True, changeDirectory=False) # NHES
NCFL = dymola.openModel(r"C:\INL LDRD Project Files\NCFL\INL_DT.mo", mustRead=True, changeDirectory=False) # INL_DT

# ====================================

# In[51]:
#Are the libraries loaded?

if TRANSFORM:
    print("TRANSFORM Loaded")
else:
    print("TRANSFORM failed to load")


if NHES:
    print("HYBRID Loaded")
else:
    print("HYBRID failed to load")

if NCFL:
    print("NCFL Loaded")
else:
    print("NCFL failed to load")

# ====================================



# In[53]:
#Get Dymola error log for debugging and set model path, change path to alternate CS structure

dymola.getLastErrorLog()
#model_path = "INL_DT.Tests.NCFL_Modular"
model_path = 'INL_DT.Tests.NCFL_Modular(ncfl(redeclare INL_DT.ControlSystems.Dynamic_CS CS))'
CS_path = 'INL_DT.ControlSystems.Dynamic_CS'
# ====================================

# In[]
#Include any modifications to the simulation in the following line 
#dymola.ExecuteCommand('ncfl.data.Heater_Power = 3.5E3;2.5E3')
dymola.ExecuteCommand('INL_DT.ControlSystems.Dynamic_CS.HeaterPower.fileName = "C:/INL LDRD Project Files/NCFL/DataSeries/Heater_static.txt"')
dymola.ExecuteCommand('INL_DT.ControlSystems.Dynamic_CS.HeaterPower.tableName = "Heater_static"')
# ====================================

# In[ ]:
#Translate Dymola simulation for NCFL model

#model_path = "INL_DT.Tests.NCFL_Modular(redeclare INL_DT.ControlSystems.TVC_CS CS)"
result = dymola.translateModel(model_path)

log, n_errors, n_warnings, n_info = dymola.getLastError()
print(log)
print("errors:", n_errors)
if result:
    print("NCFL_Modular translated successfully")
else:
    print("Translation failed")
    print(dymola.getLastErrorLog())

# ====================================



# In[]
#Run simulation and store results in "NCFL_Total_PyResults" or "NCFL_Modular_PyResults," potentially make changes to model here as well:
result = dymola.simulateModel(
    model_path,
    startTime=0.0,
    stopTime=180.0,
    outputInterval=0.1,
    resultFile="NCFL_Modular_PyResults"
)
if result:
    print("Simulation succeeded")
else:
    print("Simulation failed")
    print(dymola.getLastErrorLog()) 

# ====================================


# In[]
# Function to automatically read dymola .mat given file and component reading
def plot_dymola(file, comps, labels=None, xlabel="Time [s]", ylabel=None,
                 title=None, save_path=None, show=True):

    if isinstance(comps, str):
        comps = [comps]

    if labels is not None and len(labels) != len(comps):
        raise ValueError("labels must be the same length as comps")

    fig, ax = plt.subplots()

    for i, comp in enumerate(comps):
        try:
            n_samples = dymola.readTrajectorySize(file)
            raw = dymola.readTrajectory(file, ["Time", comp], n_samples)
        except Exception as e:
            print(f"Warning: failed to read '{comp}' from {file}: {e}")
            continue

        data = np.array(raw)

        if data.shape[0] < 2:
            print(f"Warning: unexpected data shape for '{comp}': {data.shape}")
            continue

        time = data[0]
        values = data[1]

        label = labels[i] if labels is not None else comp
        ax.plot(time, values, label=label)

    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel if ylabel is not None else "Value")
    if title:
        ax.set_title(title)
    if len(comps) > 1 or labels:
        ax.legend()
    ax.grid(True, alpha=0.3)

    fig.tight_layout()

    out_path = save_path if save_path is not None else "Output.png"
    fig.savefig(out_path, dpi=150)

    if show:
        plt.show()

    return fig, ax
# ====================================

# In[]
#Run the plotting function for specified data streams

result_file = "NCFL_Modular_PyResults.mat"

plot_dymola(result_file, "ncfl.CS.HeaterPower.y[1]",
            ylabel="Temperature Difference [K]",
            title="Cold Leg Temperature Difference")


plot_dymola(result_file,
            ["ncfl.T_diff_CL.y", "ncfl.T_diff_HL.y"],
            labels=["Cold Leg", "Hot Leg"],
            ylabel="Temperature Difference [K]",
            title="Loop Temperature Differences",
            save_path="TempDiff_Comparison.png")

# ====================================



# In[]
#Run if need to get working directory for project
cwd = dymola.ExecuteCommand("Modelica.Utilities.System.getWorkDirectory()")
print(cwd)

# ====================================


# In[55]:
#Close Dymola after work is complete

dymola.close()

# ====================================

# %%

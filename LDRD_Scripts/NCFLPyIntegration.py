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

# In[54]:
#Additional checks to see if Dymola interface is loaded
print("\nDymola version:")
print(dymola.ExecuteCommand("DymolaVersion()"))

print("\nSimple test:")
print(dymola.ExecuteCommand("true"))

# ====================================

# In[49]:
#Loading TRANSFORM and NHES libraries into Dymola instance

TRANSFORM = dymola.openModel(r"C:\INL LDRD Project Files\Dymola_Packages\TRANSFORM-Library\TRANSFORM\package.mo", mustRead=True, changeDirectory=False) # TRANSFORM
NHES = dymola.openModel(r"C:\INL LDRD Project Files\AR_DT\Linyu\AR_DigitalTwin\AR_DigitalTwin\modeling\Physics-Based\Dymola\HYBRID\Models\NHES\package.mo", mustRead=True, changeDirectory=False) # NHES
NCFL = dymola.openModel(r"C:\INL LDRD Project Files\NCFL\INL_DT.mo", mustRead=True, changeDirectory=False) # INL_DT

# ====================================

# In[51]:
#Is TRANSFORM loaded?

if TRANSFORM:
    print("TRANSFORM Loaded")
else:
    print("TRANSFORM failed to load")

# ====================================

# In[52]:
#Is NHES loaded?

if NHES:
    print("HYBRID Loaded")
else:
    print("HYBRID failed to load")

# ====================================

# In[56]:
#Is the NCFL loaded?

if NCFL:
    print("NCFL Loaded")
else:
    print("NCFL failed to load")

# ====================================

# In[53]:
#Get Dymola error log for debugging

dymola.getLastErrorLog()

# ====================================

# In[ ]:
#Translate Dymola simulation for NCFL model
model_path = "INL_DT.Tests.NCFL_Total"
result = dymola.translateModel(model_path)
if result:
    print("NCFL_Total translated successfully")
else:
    print("Translation failed")
    print(dymola.getLastErrorLog())

# ====================================

# In[]
#Include any modifications to the simulation in the following line
dymola.ExecuteCommand('data.Heater_Power = 3.5E3')

# ====================================

# In[]
#Run simulation and store results in "NCFL_Total_PyResults," potentially make changes to model here as well:
result = dymola.simulateModel(
    model_path,
    startTime=0.0,
    stopTime=180.0,
    outputInterval=0.1,
    resultFile="NCFL_Total_PyResults"
)
if result:
    print("Simulation succeeded")
else:
    print("Simulation failed")
    print(dymola.getLastErrorLog())

# ====================================

# In[]
# Example of how to read .mat files using the Dymola interface
result_file = "NCFL_Total_PyResults.mat"
all_vars = dymola.readTrajectoryNames(result_file)
n_samples = dymola.readTrajectorySize(result_file)

# ====================================

# In[]
# Function to automatically read dymola .mat given file and component reading
def plot_dymola(file, comp):
    n_samples = dymola.readTrajectorySize(file)
    data = dymola.readTrajectory(file, ["Time", comp], n_samples)
    data = np.array(data)

    plt.plot(data[0], data[1])
    plt.savefig("Output.png")
# ====================================

# In[]
#plot_dymola(result_file, "T_diff.y")
plot_dymola(result_file, "data.Heater_Power")

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

# In[ ]:





# In[ ]:





# In[ ]:
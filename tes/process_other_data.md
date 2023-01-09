```python
import os
import shutil

from modelica_builder.model import Model
from geojson_modelica_translator.modelica.modelica_runner import ModelicaRunner
from pathlib import Path

# list env settings
print(os.environ['MODELICAPATH'])

import matplotlib.pyplot as plt

from buildingspy.io.outputfile import Reader

# configure output directory
WORKDIR = Path().resolve()
OUTPUT_ROOT = WORKDIR / 'output' 

print(f"WORKDIR: {WORKDIR}")
print(f"OUTPUT_ROOT: {OUTPUT_ROOT}")

if not OUTPUT_ROOT.exists():
    OUTPUT_ROOT.mkdir(exist_ok=True, parents=True)
    
OUTPUT_WORKDIR = OUTPUT_ROOT / 'bouncing_ball'
print(f"OUTPUT_WORKDIR: {OUTPUT_WORKDIR}")
if not OUTPUT_WORKDIR.exists():
    OUTPUT_WORKDIR.mkdir(exist_ok=True, parents=True)

```

## Process single result


```python
# grab the results of the baseline simulation
baseline_results = WORKDIR / 'other_data_to_test' / 'BouncingBall_results' / 'BouncingBall_result.mat'
print(baseline_results)
# print(baseline_results)

mat = Reader(baseline_results, 'dymola')

# List off all the variables
# for var in mat.varNames():
    # print(var)

# print(mat.values("h"))
(time1, height) = mat.values("h")
# (_time1, t_mid) = mat.values("TMid.T")
# (_time1, t_top) = mat.values("TTop.T")
plt.style.use('seaborn-whitegrid')

fig = plt.figure(figsize=(20, 30))
ax = fig.add_subplot(211)
ax.plot(time1, height, 'b', label='$T_{bot}$')
# ax.plot(time1 / 3600, t_mid - 273.15, 'g', label='$T_{mid}$')
# ax.plot(time1 / 3600, t_top - 273.15, 'r', label='$T_{top}$')
ax.set_xlabel('time [s]')
ax.set_ylabel(r'height [m]')
# Simulation is only for 168 hours?
ax.set_xlim([0, 2])
ax.legend()
ax.grid(True)
fig.savefig(OUTPUT_WORKDIR / 'bouncing_ball_example.png')
```

```python

```

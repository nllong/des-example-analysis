```python
import os
import shutil

from modelica_builder.model import Model
from geojson_modelica_translator.modelica.modelica_runner import ModelicaRunner
from pathlib import Path

# Set your MODELICAPATH env var correctly to point to your local copy of the MBL.

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
    
OUTPUT_WORKDIR = OUTPUT_ROOT / 'tes'
print(f"OUTPUT_WORKDIR: {OUTPUT_WORKDIR}")
if not OUTPUT_WORKDIR.exists():
    OUTPUT_WORKDIR.mkdir(exist_ok=True, parents=True)

```

# Use GMT's ModelicaRunner to compile the example model

```python
model_path = WORKDIR / 'models' / 'tes'
model_path = model_path.resolve()
model_file = model_path / 'StratifiedUnloadAtMinimumTemperature.mo'

mr = ModelicaRunner()
print(f"running in {model_path}")
# This model should compile without issue using JModelica, which is the default within the ModelicaRunner library.
# DON'T expect this command to work (yet) for complicated models. A new docker container with OpenModelica is 
# being created to support this workflow.
success = mr.compile_in_docker(model_file, save_path=model_path)
print(f"FMU build success is {success}")
#success, results_path = mr.run_in_docker(model_path, run_path=model_path.parent)
base_fmu = model_path / 'StratifiedUnloadAtMinimumTemperature.fmu'
```

## Copy the model to a baseline directory and run

```python
baseline_path = model_path / 'baseline'
baseline_path.mkdir(parents=True, exist_ok=True)
baseline_file = baseline_path / model_file.name
shutil.copyfile(model_file, baseline_file )

# Run no longer works--this is a WIP and will be fixed shortly.
# success, _ = mr.run_in_docker(baseline_file, run_path=baseline_path)
# print(f"Build and run success is {success}")
```

## Create some perturbations


```python
perturb_values = [ 0.5, 0.75, 1.0, 1.25, ]

for index, perturb_value in enumerate(perturb_values):
    new_perturb_path = model_path / f'sim_{index}'
    new_perturb_path.mkdir(parents=True, exist_ok=True)

    mofile = Model(model_file)

    # remove the nSeg component/constant so that we can just set it 
    # in the component opject.
    mofile.remove_component('Integer', 'nSeg')

    # Second update the segment in the stratified component
    mofile.update_component_modifications(
        'Buildings.Fluid.Storage.Stratified',
        'tan',
        {
            'nSeg': 5,
            'dIns': perturb_value,
        }
    )

    new_perturb_file = new_perturb_path / model_file.name
    mofile.save_as(new_perturb_file)
```

```python
# run the perturbations, in series for now
for index, perturb_value in enumerate(perturb_values):
    file_to_run = model_path / f'sim_{index}' / model_file.name
    print(f"File to run is {file_to_run}")
    # Run no longer works--this is a WIP and will be fixed shortly.
    # success, _ = mr.run_in_docker(new_perturb_file, run_path=new_perturb_path)
    # print(f"Build and run success is {success}")
    
```

## Process single result


```python
# grab the results of the baseline simulation
baseline_results = baseline_path / f"{baseline_file.stem}_results" / f"{baseline_file.stem}_result.mat"
# print(baseline_results)

mat = Reader(baseline_results, 'dymola')

# List off all the variables
# for var in mat.varNames():
    # print(var)

(time1, t_bottom) = mat.values("TBot.T")
(_time1, t_mid) = mat.values("TMid.T")
(_time1, t_top) = mat.values("TTop.T")
plt.style.use('seaborn-whitegrid')

fig = plt.figure(figsize=(20, 30))
ax = fig.add_subplot(211)
ax.plot(time1 / 3600, t_bottom - 273.15, 'b', label='$T_{bot}$')
ax.plot(time1 / 3600, t_mid - 273.15, 'g', label='$T_{mid}$')
ax.plot(time1 / 3600, t_top - 273.15, 'r', label='$T_{top}$')
ax.set_xlabel('time [h]')
ax.set_ylabel(r'temperature [$^\circ$C]')
# Simulation is only for 168 hours?
ax.set_xlim([0, 6])
ax.legend()
ax.grid(True)
fig.savefig(OUTPUT_WORKDIR / 'indoor_temp_example.png')
```

## Process two results

```python
# calculate the difference between the two top temperatures
sim_1_results = new_perturb_path / f"{baseline_file.stem}_results" / f"{baseline_file.stem}_result.mat"
print(sim_1_results)
mat_sim_1 = Reader(sim_1_results, 'dymola')

(time2, t_bottom_2) = mat_sim_1.values("TBot.T")
(_time2, t_mid_2) = mat_sim_1.values("TMid.T")
(_time2, t_top_2) = mat_sim_1.values("TTop.T")

delta = t_top_2 - t_top
display(delta)
# max(delta)
# min(delta)

```

```python

# List off all the variables
# for var in mat.varNames():
    # print(var)


fig = plt.figure(figsize=(16, 8))
ax = fig.add_subplot(211)
ax.plot(time1 / 3600, t_top - 273.15, 'g', label='$T_{top,baseline}$')
ax.plot(time2 / 3600, t_top_2 - 273.15, 'b', label='$T_{top,1}$')
ax.set_xlabel('time [h]')
ax.set_ylabel(r'temperature [$^\circ$C]')
# Simulation is only for 168 hours?
ax.set_xlim([0, 6])
ax.legend()
ax.grid(True)
fig.savefig(OUTPUT_WORKDIR / 'indoor_temp_example.png')


```

```python

```

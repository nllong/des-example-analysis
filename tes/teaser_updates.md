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
```

```python
from modelica_builder.selector import ElementListSelector, NthChildSelector, Selector
from modelica_builder.selector import (
    ComponentDeclarationSelector,
    ParentSelector
)
from modelica_builder.transformation import (
    SimpleTransformation
)
from modelica_builder.edit import Edit

model_path = Path('.') / 'models' / 'teaser'
model_path = model_path.resolve()
model_file = model_path / 'ICT.mo'

mofile = Model(model_file)

# Fix the thermalZone medium model 
mofile.update_component_modifications(
    "Buildings.ThermalZones.ReducedOrder.RC.FourElements",
    "thermalZoneFourElements",
    {"VAir": 99898989898.99999}
)

type_ = "Buildings.ThermalZones.ReducedOrder.RC.FourElements"
identifier = "thermalZoneFourElements"

# selector = (ComponentDeclarationSelector(type_, identifier)
#                     .chain(
#             NthChildSelector(10)))
selector = ComponentDeclarationSelector(type_, identifier).chain(NthChildSelector(0))
transformer = SimpleTransformation(selector, Edit.make_replace("Medium = a new value"))
mofile.add(transformer)

mofile.overwrite_component_redeclaration(type_, identifier, 'Medium = a NeW VaLuE')

mofile.save_as(model_file.parent / 'ICT_updated.mo')
```

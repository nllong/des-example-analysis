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

from modelica_builder.selector import ElementListSelector, NthChildSelector, Selector
from modelica_builder.selector import (
    ComponentDeclarationSelector,
    ParentSelector
)
from modelica_builder.transformation import (
    SimpleTransformation
)
from modelica_builder.edit import Edit
```

```python
model_path = Path('.')
model_path = model_path.resolve()
model_file = model_path / 'Envelop.mo'

model = Model(model_file)
```

```python
model

# before
model.update_component_modification(
    'IDEAS.Buildings.Components.Window',
    'Window',
    'shaType',
    'redeclare IDEAS.Buildings.Components.Shading.Screen shaType'
)

# after
# model.overwrite_component_redeclaration(
#     'IDEAS.Buildings.Components.Window',
#     'MMM_Fixed_3000_x_2000mm_3__WinRoom0BoQ',
#     'IDEAS.Buildings.Components.Shading.None',
#     'redeclare IDEAS.Buildings.Components.Shading.Screen shaType'
# )


model.overwrite_component_redeclaration(
            'IDEAS.Buildings.Components.Window',
            'MMM_Fixed_3000_x_2000mm_3__WinRoom0BoQ',
            'IDEAS.Buildings.Components.Shading.None')
# remove_component_argument
```

```python
model.save_as(model_file.parent / 'Envelop_updated.mo')
```

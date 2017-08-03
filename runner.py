# -*- coding: utf-8 -*-
from mlshim import Matlab

import os

run_dir = os.environ.get("WORKSPACE", os.path.curdir);

mlab = Matlab(version="R2016b", run_dir=run_dir);

paths = [os.path.join(run_dir, "junit-xml-ml"),
         os.path.join(run_dir, "junit-xml-ml", "Examples")]

mlab.run(scripts=['runall'], paths=paths)
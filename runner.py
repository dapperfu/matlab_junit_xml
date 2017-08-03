# -*- coding: utf-8 -*-
import os

from mlshim import Matlab

run_dir = os.environ.get("WORKSPACE", os.curdir);
run_dir = os.path.abspath(run_dir)

mlab = Matlab(version="R2016b", run_dir=run_dir);

paths = [os.path.join(run_dir),
         os.path.join(run_dir, "Examples")]

scripts = ['runall']

mlab.run(scripts=scripts, paths=paths)
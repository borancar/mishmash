# Python example using PDM

This example project demonstrates PDM, a python package manager with [PEP
582](https://github.com/pdm-project/pdm) support - Python local packages
directory.

## Requirements

1. https://github.com/pdm-project/pdm - can use the installation script, though
   I prefer using `pip install --user pdm` and adding it to the PYTHONPATH
   with:

```
if [ -n "$PYTHONPATH" ]; then
    export PYTHONPATH='/home/boran/.local/lib/python3.10/site-packages/pdm/pep582':$PYTHONPATH
else
    export PYTHONPATH='/home/boran/.local/lib/python3.10/site-packages/pdm/pep582'
fi
```

## Running

When inside the directory, just run `pdm install` and you're ready to run the
app with `python app.py`.

## Bazel

If you want to build a Python zip file with all dependencies, run:

```
bazel build //python_pdm_example:app --output_groups=python_zip_file
```

or just

```
bazel build //python_pdm_example:app_zip
```

You can run the resulting file as:
```
python bazel-bin/python_pdm_example/app.zip
```

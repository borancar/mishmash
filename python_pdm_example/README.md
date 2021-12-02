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
    export PYTHONPATH='/home/boran/.local/share/pdm/venv/lib64/python3.9/site-packages/pdm/pep582':$PYTHONPATH
else
    export PYTHONPATH='/home/boran/.local/share/pdm/venv/lib64/python3.9/site-packages/pdm/pep582'
fi
```

## Running

When inside the directory, just run `pdm install` and you're ready to run the
app with `python app.py`.

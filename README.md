# AVR-VMC-Sandbox-Module

The Sandbox module is where student autonomy code lives. This repo is merely
a template. For students to use, they should
[fork](https://github.com/bellflight/AVR-VMC-Sandbox-Module/fork) the repo,
and then clone their version on the VMC:

```bash
ssh drone@10.42.0.1
cd AVR-VMC/modules
git clone https://github.com/yourusername/AVR-VMC-Sandbox-Module sandbox
```

It also recommended to delete the `.github` folder from your fork.

## Development

It's assumed you have a version of Python installed from
[python.org](https://python.org) that is the same or newer as
defined in the [`Dockerfile`](Dockerfile).

First, install [Poetry](https://python-poetry.org/) and
[VS Code Task Runner](https://pypi.org/project/vscode-task-runner/):

```bash
python -m pip install pipx --upgrade
pipx ensurepath
pipx install poetry
pipx install vscode-task-runner
# (Optionally) Add pre-commit plugin
poetry self add poetry-pre-commit-plugin
```

Now, you can clone the repo and install dependencies:

```bash
git clone https://github.com/bellflight/AVR-VMC-Sandbox-Module
cd AVR-VMC-Sandbox-Module
vtr install
```

Run

```bash
poetry shell
```

to activate the virtual environment.

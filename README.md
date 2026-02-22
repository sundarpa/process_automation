# qgeniehw_cli_standalone

Minimal Windows-first wrapper around `deepagents_cli` that uses the Qualcomm QGenie endpoint.

## Prerequisites
- Python 3.11+
- Network access to `https://qgenie-api.qualcomm.com/v1`
- QGenie API key

## Install
```powershell
pip install -r requirements.txt
```

## Run
Set the API key (PowerShell):
```powershell
$env:QGENIE_API_KEY = "<your_key_here>"
```

Optional (override base URL):
```powershell
$env:QGENIE_BASE_URL = "https://qgenie-api.qualcomm.com/v1"
```

Start CLI:
```powershell
python .\qgeniehw_cli.py
```

Help:
```powershell
python .\qgeniehw_cli.py help
```

## Notes
- This repo intentionally does **not** commit any virtualenv or local DeepAgents state (see `.gitignore`).
- `deepagents_cli` uses the `help` subcommand; `--help` is not supported by its parser.

import os
import sys

import deepagents_cli

# Patch deepagents_cli create_model to use QGenie endpoint + env var
def _create_model(model: str = "anthropic::claude-3-7-sonnet"):
    api_key = os.environ.get("QGENIE_API_KEY")
    if not api_key:
        raise RuntimeError(
            "QGENIE_API_KEY is not set. In PowerShell: $env:QGENIE_API_KEY = '<your_key>'"
        )

    base_url = os.environ.get("QGENIE_BASE_URL", "https://qgenie-api.qualcomm.com/v1")

    from dragonai.openai import ChatOpenAI

    if not model:
        model = "anthropic::claude-3-7-sonnet"

    return ChatOpenAI(model=model, max_tokens=64000, base_url=base_url, api_key=api_key)


# Install the override
deepagents_cli.main.create_model = _create_model


if __name__ == "__main__":
    # deepagents_cli uses subcommands (e.g. `help`). `--help` is not supported by its parser.
    # Examples:
    #   python qgeniehw_cli.py help
    #   python qgeniehw_cli.py --auto-approve
    deepagents_cli.cli_main()

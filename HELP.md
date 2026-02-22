# CLI Help / Options

This file captures the output of:

```powershell
$env:PYTHONUTF8=1
$env:PYTHONIOENCODING='utf-8'
python .\qgeniehw_cli.py help
```

(Generated via redirecting output to `help_output.txt`.)

## deepagents_cli help output (v0.0.13)

```text
Usage:
  deepagents [OPTIONS]                           Start interactive session
  deepagents list                                List all available agents
  deepagents reset --agent AGENT                 Reset agent to default prompt
  deepagents reset --agent AGENT --target SOURCE Reset agent to copy of another agent
  deepagents help                                Show this help message
  deepagents --version                           Show deepagents version

Options:
  --agent NAME                  Agent identifier (default: agent)
  --model MODEL                 Model to use (e.g., claude-sonnet-4-5-20250929, gpt-4o)
  --auto-approve                Auto-approve tool usage without prompting
  --sandbox TYPE                Remote sandbox for execution (modal, runloop, daytona)
  --sandbox-id ID               Reuse existing sandbox (skips creation/cleanup)
  -r, --resume [ID]             Resume thread: -r for most recent, -r <ID> for specific

Examples:
  deepagents                              # Start with default agent
  deepagents --agent mybot                # Start with agent named 'mybot'
  deepagents --model gpt-4o               # Use specific model (auto-detects provider)
  deepagents -r                           # Resume most recent session
  deepagents -r abc123                    # Resume specific thread
  deepagents --auto-approve               # Start with auto-approve enabled
  deepagents --sandbox runloop            # Execute code in Runloop sandbox

Thread Management:
  deepagents threads list                 # List all sessions
  deepagents threads delete <ID>          # Delete a session

Interactive Features:
  Enter           Submit your message
  Ctrl+J          Insert newline
  Shift+Tab       Toggle auto-approve mode
  @filename       Auto-complete files and inject content
  /command        Slash commands (/help, /clear, /quit)
  !command        Run bash commands directly
```

## Notes
- The raw banner output may look garbled in redirected files on Windows due to Rich/terminal encoding. The actual options text above is what matters for documentation.
- `--help` is not supported by this CLI; use the `help` subcommand.

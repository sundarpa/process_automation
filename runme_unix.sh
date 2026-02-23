#!/usr/bin/env bash
# ============================================================
#  QGENIE HW CLI Agent - Launcher (Unix/Linux/macOS)
#  API key is encrypted with Python Fernet (machine+user bound).
#  Stored in: ~/.tscript
#  Run setup_key.sh once to encrypt and store your API key.
# ============================================================

set -euo pipefail

KEYFILE="$HOME/.tscript"

if [[ ! -f "$KEYFILE" ]]; then
    echo "ERROR: API key not found at $KEYFILE"
    echo "Please run setup_key.sh first:"
    echo "  chmod +x setup_key.sh && ./setup_key.sh"
    exit 1
fi

# Decrypt the key using Python Fernet (machine+user bound)
export QGENIE_API_KEY
QGENIE_API_KEY=$(python3 - <<'EOF'
import os, hashlib, base64, socket

try:
    from cryptography.fernet import Fernet
except ImportError:
    import sys
    print("ERROR: 'cryptography' package not found. Run: pip install cryptography", file=sys.stderr)
    sys.exit(1)

if os.path.exists('/etc/machine-id'):
    with open('/etc/machine-id') as f:
        machine_id = f.read().strip()
elif os.path.exists('/var/lib/dbus/machine-id'):
    with open('/var/lib/dbus/machine-id') as f:
        machine_id = f.read().strip()
else:
    machine_id = socket.gethostname()

user = os.environ.get('USER', os.environ.get('USERNAME', 'user'))
seed = (machine_id + user).encode()
fernet_key = base64.urlsafe_b64encode(hashlib.sha256(seed).digest())

f = Fernet(fernet_key)
keyfile = os.path.expanduser('~/.tscript')
with open(keyfile) as fp:
    encrypted = fp.read().strip()

print(f.decrypt(encrypted.encode()).decode(), end='')
EOF
)

if [[ -z "$QGENIE_API_KEY" ]]; then
    echo "ERROR: Failed to decrypt API key. Try running setup_key.sh again."
    exit 1
fi

cd "$(dirname "$0")"
python3 ./qgeniehw_cli.py

#!/usr/bin/env bash
# ============================================================
#  QGENIE API Key Setup - Unix/Linux/macOS
#  Encrypts the API key using Python Fernet (machine+user bound).
#  Key stored in: ~/.tscript
#  (Never committed to git - stored outside the repo)
# ============================================================

set -euo pipefail

read -r -s -p "Enter your QGENIE_API_KEY: " API_KEY
echo

python3 - "$API_KEY" <<'EOF'
import sys, os, hashlib, base64, socket

try:
    from cryptography.fernet import Fernet
except ImportError:
    print("ERROR: 'cryptography' package not found. Run: pip install cryptography")
    sys.exit(1)

api_key = sys.argv[1]

# Derive a machine+user specific encryption key
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
encrypted = f.encrypt(api_key.encode()).decode()

keyfile = os.path.expanduser('~/.tscript')
with open(keyfile, 'w') as fp:
    fp.write(encrypted)

print(f"SUCCESS: Encrypted key saved to {keyfile}")
print("You can now run runme_unix.sh to launch the agent.")
EOF

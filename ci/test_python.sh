#!/usr/bin/env bash

. tools/activate_python.sh

set -euo pipefail

modules="SVS utils setup.py egs/*/*/local"

# black
if ! black --check --line-length 79 ${modules}; then
    printf 'Please apply:\n    $ black %s\n' "${modules}"
    exit 1
fi

# flake8
"$(dirname $0)"/test_flake8.sh
# pycodestyle
pycodestyle -r ${modules} --show-source --show-pep8

LD_LIBRARY_PATH="${LD_LIBRARY_PATH:-}:$(pwd)/tools/chainer_ctc/ext/warp-ctc/build" pytest -q
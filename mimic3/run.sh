#!/bin/bash
cd mimic3
source ./.venv/bin/activate
mimic3-server --cache-dir /share/snapfifo/mimic3

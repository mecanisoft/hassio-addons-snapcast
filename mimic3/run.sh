#!/bin/bash
cd mimic3
source ./.venv/bin/activate

mimic3-download fr_FR/siwis_low

file="/root/.local/share/mycroft/mimic3/voices/fr_FR/siwis_low/config.json"
searchrate='"sample_rate": 22050'
replacerate='"sample_rate": 44100'
sed -i "s/$searchrate/$replacerate/" $file

file="/root/.local/share/mycroft/mimic3/voices/fr_FR/siwis_low/config.json"
searchchan='"channels": 1'
replacechan='"channels": 2'
sed -i "s/$searchchan/$replacechan/" $file

mimic3-server

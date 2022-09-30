#!/bin/bash
cd mimic3

file="/mimic3/mimic3_tts/config.py"
searchrate="sample_rate: int = 22050"
replacerate="sample_rate: int = 44100"
sed -i "s/$searchrate/$replacerate/" $file
searchchan="channels: int = 1"
replacechan="channels: int = 2"
sed -i "s/$searchchan/$replacechan/" $file

source ./.venv/bin/activate
mimic3-server

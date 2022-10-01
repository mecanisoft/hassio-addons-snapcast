#!/bin/bash

file1="/mimic3/opentts_abc/__init__.py"
file2="/mimic3/mimic3_http/synthesis.py"

searchrate="wav_file.setframerate(22050)"
replacerate="wav_file.setframerate(44100)"
sed -i "s/$searchrate/$replacerate/" $file1
sed -i "s/$searchrate/$replacerate/" $file2

searchchan="wav_file.setnchannels(1)"
replacechan="wav_file.setnchannels(2)"
sed -i "s/$searchchan/$replacechan/" $file1
sed -i "s/$searchrate/$replacerate/" $file2

cd mimic3
source ./.venv/bin/activate
mimic3-server

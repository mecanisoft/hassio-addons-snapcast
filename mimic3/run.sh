#!/bin/bash

file="/mimic3/opentts_abc/__init__.py"
searchrate="wav_file.setframerate(22050)"
replacerate="wav_file.setframerate(44100)"
sed -i "s/$searchrate/$replacerate/" $file

searchchan="wav_file.setnchannels(1)"
replacechan="wav_file.setnchannels(2)"
sed -i "s/$searchchan/$replacechan/" $file

cd mimic3
source ./.venv/bin/activate
mimic3-server

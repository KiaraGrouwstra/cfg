#!/usr/bin/env -S nix shell nixpkgs#ffmpeg nixpkgs#findutils nixpkgs#gnused nixpkgs#openai-whisper-cpp --command sh
# run speech recognition on input audio file
# usage: listen.sh "sample.mp3"
# set -xe
INPUT_AUDIO_FILE="${1}"
# lang=en
model=ggml-tiny.en-q8_0.bin
ffmpeg -nostdin -threads 0 -i $INPUT_AUDIO_FILE -f wav -ac 1 -acodec pcm_s16le -ar 16000 - 2>/dev/null | whisper-cpp -m $XDG_CONFIG_HOME/whisper/models/$model -f - 2>/dev/null | sed -E 's/^.*?\]\s+//g' | xargs

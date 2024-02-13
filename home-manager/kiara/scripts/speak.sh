#!/usr/bin/env sh
# lang=en
model=en-us-amy-low
echo "$1" | piper --model ~/.config/piper/voice-$model/$model.onnx --config ~/.config/piper/voice-$model/$model.onnx.json --output-raw | aplay -r 17000 -f S16_LE -t raw -

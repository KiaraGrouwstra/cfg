#!/usr/bin/env sh
# run TTS on input text
# usage: speak.sh "hi"
# set -xe
model=en/en_US/libritts/high/en_US-libritts-high
msg=$(echo $1 | sed 's/"/\\"/g')
port=8080
curl http://localhost:${port}/tts -H "Content-Type: application/json" -d "{
  \"backend\": \"piper\",
  \"model\":\"${model}.onnx\",
  \"input\": \"${msg}\"
}" 2>/dev/null | aplay -r 23000 -f S16_LE -t raw - 2>/dev/null

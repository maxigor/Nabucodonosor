nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits | while read line; do echo "GPU: $line°C"; done

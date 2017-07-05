#!/bin/bash

# Configure extra credentials via env var
if ! [[ -z "${password}" ]]; then
  if [[ -z "${username}" ]]; then
    export username='user'
  fi
  
  echo "${username}:${password}" >> /etc/nginx/.htpasswd
fi

# Disable authentication in server blocks if no password found
if ! grep "^[^#]" /etc/nginx/.htpasswd; then
  find /etc/nginx/sites-enabled -type f -exec sed -i 's/auth_basic/#&/g' {} \;
fi

# Configure video output via env var
if ! [[ -z "${width}" || -z "${height}" ]]; then
  v4l2-ctl --set-fmt-video=width=${width},height=${height},pixelformat=4
fi

./webrtc-streamer -H 127.0.0.1:8000

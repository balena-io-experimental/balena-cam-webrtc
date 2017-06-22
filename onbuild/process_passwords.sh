#!/bin/bash

# Disable authentication in server blocks if no password found.
if ! grep "^[^#]" /etc/nginx/.htpasswd; then
  find /etc/nginx/sites-enabled -type f -exec sed -i 's/auth_basic/#&/g' {} \;
fi

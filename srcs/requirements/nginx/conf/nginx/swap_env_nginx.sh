#/bin/sh

# This command take the pre nginx config file
# and return the same version with the local env variable swapped
/bin/sh -c " envsubst < /etc/nginx/pre_nginx.conf > /etc/nginx/nginx.conf"

# Delete the old config file
rm -rf /etc/nginx/pre_nginx.conf
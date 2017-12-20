if [ ! -f "/etc/nginx/conf/$NGINX_CONF" ]; then
   cat /etc/nginx/nginx.conf > /etc/nginx/conf/$NGINX_CONF
fi

nginx -c /etc/nginx/conf/$NGINX_CONF -g 'daemon off;'

workworker_processes  auto;

events {
    worker_connections  2408;
    multi_accept on;
    use epoll;
}

http {
    default_type  application/json;

    sendfile        on;

    gzip  on;
	server_tokens off; #关闭nginx版本号
    tcp_nopush on; #在一个数据包里发送所有头文件，而不一个接一个的发送
    tcp_nodelay on; #nginx不要缓存数据，而是一段一段的发送--当需要及时发送数据时，就应该给应用设置这个属性，这样发送一小块数据信息时就不能立即得到返回值。
    access_log off; #设置nginx是否将存储访问日志。关闭这个选项可以让读取磁盘IO操作更快(aka,YOLO)
    error_log /var/log/nginx/error.log crit; #告诉nginx只能记录严重的错误
    keepalive_timeout 10; #给客户端分配keep-alive链接超时时间。服务器将在这个超时时间过后关闭链接
    client_header_timeout 10; #设置请求头超时时间，建议低
    client_body_timeout 10; #请求体(各自)的超时时间
    reset_timedout_connection on; #关闭不响应的客户端连接。这将会释放那个客户端所占有的内存空间
    send_timeout 10; #指定客户端的响应超时时间
    limit_conn_zone $binary_remote_addr zone=addr:5m; #设置用于保存各种key（比如当前连接数）的共享内存的参数。5m就是5兆字节，这个值应该被设置的足够大以存储（32K*5）32byte状态或者（16K*5）64byte状态。
    limit_conn addr 100; #给定的key设置最大连接数。这里key是addr，我们设置的值是100，也就是说我们允许每一个IP地址最多同时打开有100个连接。
    include /etc/nginx/mime.types; #只是一个在当前文件中包含另一个文件内容的指令。
    charset UTF-8; #头默认的字符集
    gzip_disable "MSIE [1-6]\."; #低版本兼容
    gzip_proxied any; #允许或者禁止压缩基于请求和响应的响应流。我们设置为any，意味着将会压缩所有的请求
    gzip_static on; #告诉nginx在压缩资源之前，先查找是否有预先gzip处理过的资源
    gzip_min_length 10000; #设置对数据启用压缩的最少字节数
    gzip_comp_level 6; #压缩级别,1-9越高越消耗CPU，但是压缩越好
    gzip_types text/html text/css application/javascript text/plain application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript; #设置需要压缩的数据格式
    gzip_vary on; #表示是否添加"Vary: Accept-Encoding"响应头
    gzip_buffers 4 8k; #设置系统获取几个单位的缓存用于存储gzip的压缩结果数据流
    open_file_cache max=100000 inactive=20s; #打开缓存的同时也指定了缓存最大数目，以及缓存的时间
    open_file_cache_valid 30s; #在open_file_cache中指定检测正确信息的间隔时间
    open_file_cache_min_uses 2; #定义了open_file_cache中指令参数不活动时间期间里最小的文件数
    open_file_cache_errors on; #指定了当搜索一个文件时是否缓存错误信息，也包括再次给配置中添加文件
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                               '$status $body_bytes_sent "$http_referer" '
                               '"$http_user_agent" "$http_x_forwarded_for"';	
	
    server { 
		listen   80;
		add_header 'Access-Control-Allow-Origin' '*' always;		
		add_header 'access-Control-Allow-Headers' 'content-type' always;
		add_header 'Access-Control-Max-Age' '1800' always;
		add_header 'Access-Control-Allow-Methods' 'GET, POST, PATCH, DELETE, PUT, OPTIONS' always;
		add_header 'Expires' '0' always;
		add_header 'Cache-Control' 'no-cache, no-store, max-age=0, must-revalidate' always;
		add_header 'X-XSS-Protection' '1 always; mode=block' always;
		add_header 'Pragma' 'no-cache' always;
		add_header 'X-Frame-Options' 'DENY' always;
		add_header 'Vary' 'Origin' always;
		add_header 'Vary' 'Access-Control-Request-Method' always;
		rewrite ^/(eva)/(.*) /$2 last;
		client_max_body_size 10M;
			
			location /eva-power-app/ { 
				proxy_pass      http://eva-power-rc:8080;
				proxy_redirect  off; 
				proxy_set_header   Host  $host; 
				proxy_set_header   X-Real-IP   $remote_addr; 
				proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
			} 
			location /eva-estate-app/ { 
				proxy_pass      http://eva-estate-rc:8080; 
				proxy_redirect  off; 
				proxy_set_header   Host  $host; 
				proxy_set_header   X-Real-IP   $remote_addr; 
				proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for; 
				proxy_hide_header 'Access-Control-Allow-Origin';
			} 
			location /eva-session-app/ {
				proxy_pass      http://eva-session-rc:8080; 
				proxy_redirect  off; 
				proxy_set_header   Host  $host; 
				proxy_set_header   X-Real-IP   $remote_addr; 
				proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for; 
			} 
			location /eva-message-app/ {
				proxy_pass      http://eva-message-rc:8080; 
				proxy_redirect  off; 
				proxy_set_header   Host  $host; 
				proxy_set_header   X-Real-IP   $remote_addr; 
				proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for; 
			}
			location /eva-job-app/ {
				proxy_pass      http://eva-job-rc:8080; 
				proxy_redirect  off; 
				proxy_set_header   Host  $host; 
				proxy_set_header   X-Real-IP   $remote_addr; 
				proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for; 
			}
			location /eva-bill-app/ {
				proxy_pass      http://eva-bill-rc:8080; 
				proxy_redirect  off; 
				proxy_set_header   Host  $host; 
				proxy_set_header   X-Real-IP   $remote_addr; 
				proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for; 
			}			
			location /frontend/admin/ {
				proxy_pass      http://eva-frontend-admin; 
				proxy_redirect  off; 
				proxy_set_header   Host  $host; 
				proxy_set_header   X-Real-IP   $remote_addr; 
				proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for; 
			} 
			location /frontend/h5/ {
				proxy_pass      http://eva-frontend-h5-rc; 
				proxy_redirect  off; 
				proxy_set_header   Host  $host; 
				proxy_set_header   X-Real-IP   $remote_addr; 
				proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for; 
			} 
   } 
}   
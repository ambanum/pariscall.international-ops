server {
	listen 80 default_server;
	server_name {{ base_url }};
	# return 302 https://$server_name$request_uri;
# }
#
# server {
	# listen 443 ssl http2;
	# server_name {{ base_url }};
	# ssl on;
	# ssl_certificate /etc/letsencrypt/live/pariscall.international/fullchain.pem;
	# ssl_certificate_key /etc/letsencrypt/live/pariscall.international/privkey.pem;
	# ssl_session_timeout 1d;
	# ssl_protocols TLSv1.2;
	# ssl_ciphers 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256';
	# ssl_prefer_server_ciphers on;
	# ssl_session_cache shared:SSL:50m;
	# # HSTS (ngx_http_headers_module is required) (15768000 seconds = 6 months)
	# add_header Strict-Transport-Security max-age=15768000;
	# # OCSP Stapling ---
	# # fetch OCSP records from URL in ssl_certificate and cache them
	# ssl_stapling on;
	# ssl_stapling_verify on;

	root /var/www/html;

	# Add index.php to the list if you are using PHP
	index index.html index.htm index.nginx-debian.html;

	location /api/ {
		proxy_pass http://127.0.0.1:3030/;
	}

	location /ParisCall {
		proxy_pass https://ambanum.github.io/pariscall.international/;
	}

	location / {
		proxy_pass https://ambanum.github.io/pariscall.international/;
	}
}

mkdir -p srcs/nginx/certs

openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout srcs/nginx/certs/sokaraku.42.fr.key \
  -out srcs/nginx/certs/sokaraku.42.fr.crt \
  -subj "/C=FR/ST=IDF/L=Paris/O=42/CN=sokaraku.42.fr"
  
mkdir -p srcs/nginx/www

cat > srcs/nginx/www/index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome to sokaraku.42.fr!</title>
</head>
<body>
    <h1>It works!</h1>
    <p>This is the default index.html served by Nginx.</p>
</body>
</html>
EOF

  #move to make
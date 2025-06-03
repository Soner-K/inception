#!/bin/sh
mkdir -p /var/www/wordpress

cat > /var/www/wordpress/index.html <<EOF
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

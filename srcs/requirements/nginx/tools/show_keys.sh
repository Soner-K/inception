#!/bin/sh

echo -e "=== SSL Certificate Information ===\n"
openssl x509 -in /etc/nginx/ssl/inception.crt -text -noout

echo -e "\n=== SSL Certificate Key (full content) ===\n"
cat /etc/nginx/ssl/inception.key

echo -e "\n=== Certificate Fingerprint ===\n"
openssl x509 -in /etc/nginx/ssl/inception.crt -noout -fingerprint

echo -e "\n=== Certificate Validity Dates ===\n"
openssl x509 -in /etc/nginx/ssl/inception.crt -noout -dates
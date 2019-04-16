# DevOps Scripts
A set of scripts to set up some often needed services of mine.
<br><br>

**certs.sh**

Get a certbot image and issue sertificates for `CERTBOT_DOMAIN`.<br>
Save certificates to `letsencrypt` Docker volume.<br>
Convert sertificates into format for `jwilder/nginx-proxy` and store them in `proxy-certs`.
Run the proxy server.

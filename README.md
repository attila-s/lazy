# random set of scripts and tricks and one liners

## Forward traffic via socat to another port
socat is a weapon. Read: https://www.redhat.com/sysadmin/getting-started-socat

- terminal 1: start the proxy process. It will TCP traffic on a port and forward it to another
```
socat -d -d tcp-listen:8081,reuseaddr,fork tcp:localhost:8082
2022/10/05 23:24:02 socat[486] N listening on AF=2 0.0.0.0:8081
2022/10/05 23:24:38 socat[486] N accepting connection from AF=2 127.0.0.1:35780 on AF=2 127.0.0.1:8081
2022/10/05 23:24:38 socat[486] N forked off child process 929
2022/10/05 23:24:38 socat[486] N listening on AF=2 0.0.0.0:8081
2022/10/05 23:24:38 socat[929] N opening connection to AF=2 127.0.0.1:8082
2022/10/05 23:24:38 socat[929] N successfully connected from local address AF=2 127.0.0.1:57500
2022/10/05 23:24:38 socat[929] N starting data transfer loop with FDs [6,6] and [5,5]
```
- terminal 2: simple netcat server with good communication skills (listening)
```
nc -l localhost 8082
a
b
c
d
e
```
- terminal 3: interactive activity; connect to socat's listen port and send over traffic
```
netcat localhost 8081
a
b
c
d
e
```

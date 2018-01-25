Server debug
```
Start server with 
-agentlib:jdwp=transport=dt_socket,server=y,address=5005,suspend=y
```

Connect
```
sudo /usr/java/default/bin/jdb -attach localhost:5005
> suspend
> stop in org.apache.oozie.service.HadoopAccessorService.validateNameNode
> resume
```

Class loading
```
-verbose:class
```

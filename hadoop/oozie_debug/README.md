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

YARN applications don't start due to resource limitations: review + modify checks & limits in `yarn-site.xml`
```
       <property>
                <name>yarn.nodemanager.vmem-check-enabled</name>
                <value>false</value>
        </property>
        <property>
                <name>yarn.nodemanager.resource.memory-mb</name>
                <value>100000</value>
        </property>
         <property>
                 <name>yarn.nodemanager.resource.cpu-vcores</name>
                <value>20</value>
        </property>
```

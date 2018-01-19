Pass parameter to beeline JVM (hive)
--
```
export HADOOP_VERSION=x.y.z
export HADOOP_CLIENT_OPTS="-verbose:class"
beeline -u jdbc:hive2://localhost:10000 -n hive -e 'show tables'
```

For more insights
--
```
export SHELLOPTS
bash -x beeline -u jdbc:hive2://localhost:10000 -n hive -e 'show tables' 2>&1 | tee beeline.out
```

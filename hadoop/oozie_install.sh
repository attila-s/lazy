#!/bin/bash

wget http://www.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
tar xf apache-maven-3.3.9-bin.tar.gz
ln -s /apache-maven-3.3.9/bin/mvn /bin/mvn
yum install -y git
git clone https://github.com/apache/oozie.git
. /etc/environment 
cd oozie
./bin/mkdistro.sh -Puber -DskipTests -Dhadoop.version=2.6.0
cd /oozie/distro/target/oozie-4.4.0-SNAPSHOT-distro/oozie-4.4.0-SNAPSHOT
tar xf oozie-examples.tar.gz
tar xf oozie-sharelib-4.4.0-SNAPSHOT.tar.gz
yes | cp /hadoop-2.6.0/etc/hadoop/core-site.xml conf/hadoop-conf/
bin/oozie-setup.sh sharelib create -fs hdfs://localhost:9000 -locallib share -concurrency 4
/hadoop-2.6.0/bin/hdfs dfs -put examples/
bin/oozied.sh start
JOB_ID=$(bin/oozie job -oozie http://localhost:11000/oozie -config examples/apps/shell/job.properties -run -DnameNode=hdfs://localhost:9000 -DjobTracker=localhost:8032)


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

cat >conf/hadoop-conf/core-site.xml<<ENDL
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<!--
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. See accompanying LICENSE file.
-->
<!-- Put site-specific property overrides in this file. -->
<configuration>
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://localhost:9000</value>
  </property>
  <property>
    <name>hadoop.proxyuser.root.hosts</name>
    <value>*</value>
  </property>
  <property>
    <name>hadoop.proxyuser.root.groups</name>
    <value>*</value>
  </property>

    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
ENDL

tar xf oozie-examples.tar.gz
tar xf oozie-sharelib-4.4.0-SNAPSHOT.tar.gz
yes | cp /hadoop-2.6.0/etc/hadoop/core-site.xml conf/hadoop-conf/
bin/oozie-setup.sh sharelib create -fs hdfs://localhost:9000 -locallib share -concurrency 4
/hadoop-2.6.0/bin/hdfs dfs -put examples/

mkdir libext
curl http://archive.cloudera.com/gplextras/misc/ext-2.2.zip -o libext/ext-2.2.zip

bin/oozied.sh start
JOB_ID=$(bin/oozie job -oozie http://localhost:11000/oozie -config examples/apps/shell/job.properties \
-run -DnameNode=hdfs://localhost:9000 -DjobTracker=localhost:8032 | cut -d" " -f2)


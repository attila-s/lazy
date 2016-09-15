#!/usr/local/bin/bash
# Prerequisites 
# java installed, JAVA_HOME set 
echo export JAVA_HOME=/usr/lib/jvm/java-8-oracle >>/etc/environment 

# Downloads Hadoop 2.4.0 and configures to  run it on a single-node in a pseudo-distributed mode 

wget https://archive.apache.org/dist/hadoop/core/hadoop-2.4.0/hadoop-2.4.0.tar.gz
tar xf hadoop-2.4.0.tar.gz
cd hadoop-2.4.0

cat >etc/hadoop/hdfs-site.xml <<ENDL
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
<name>dfs.replication</name>
<value>1</value>
</property>
</configuration>
ENDL

cat >etc/hadoop/core-site.xml <<ENDL
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
<name>hadoop.proxyuser.vagrant.hosts</name>
<value>*</value>
</property>
<property>
<name>hadoop.proxyuser.vagrant.groups</name>
<value>*</value>
</property>

</configuration>
ENDL

cat >etc/hadoop/mapred-site.xml <<ENDL
<?xml version="1.0"?>
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
<name>mapreduce.framework.name</name>
<value>yarn</value>
</property>
</configuration>
ENDL

cat >etc/hadoop/yarn-stie.xml<<ENDL
<?xml version="1.0"?>
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

<!-- Site specific YARN configuration properties -->
<configuration>
<property>
<name>yarn.nodemanager.aux-services</name>
<value>mapreduce_shuffle</value>
</property>
</configuration>
ENDL

bin/hdfs namenode -format
sbin/start-dfs.sh


bin/hdfs dfs -mkdir /user
bin/hdfs dfs -mkdir /user/asasvari

bin/hdfs dfs -put etc/hadoop input
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.4.0.jar grep input output 'dfs[a-z.]+'
bin/hdfs dfs -cat output/*

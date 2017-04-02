#!/bin/bash

wget http://www.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
tar xf apache-maven-3.3.9-bin.tar.gz
ln -s /apache-maven-3.3.9/bin/mvn /bin/mvn
yum install -y git
git clone https://github.com/apache/oozie.git
. /etc/environment 
cd oozie
./bin/mkdistro.sh -Puber -DskipTests -Dhadoop.version=2.6.0

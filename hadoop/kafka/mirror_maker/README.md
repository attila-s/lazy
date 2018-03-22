Create config for the second zookeeper cluster

```
cat >config/zookeeper-2.properties << ENDL
dataDir=/tmp/zookeeper-2
# the port at which the clients will connect
clientPort=2182
# disable the per-ip limit on the number of connections since this is a non-production config
maxClientCnxns=0
ENDL
```

Start Zookeeper servers
```
nohup bin/zookeeper-server-start.sh ./config/zookeeper.properties&
nohup bin/zookeeper-server-start.sh ./config/zookeeper-2.properties&
```

Start Kafka brokers
```
nohup bin/kafka-server-start.sh config/server-1.properties&
nohup bin/kafka-server-start.sh config/server-2.properties&
```

Create topics
```
./bin/kafka-topics.sh --create \                                                                                                    
          --zookeeper localhost:2181 \
          --replication-factor 1 \
          --partitions 1 \
          --topic test1 

./bin/kafka-topics.sh --create \                                                                                                    
          --zookeeper localhost:2181 \
          --replication-factor 1 \
          --partitions 1 \
          --topic test2 
```

Create Mirror Maker consumer config
```
cat >config/mm_consumer.properties << END_MM_CONSUMER_CFG 
bootstrap.servers=localhost:9092
exclude.internal.topics=true
group.id=1
client.id=mirror_maker_consumer
END_MM_CONSUMER_CFG
```

Create Mirror Maker producer config
```
cat >config/mm_producer.properties << END_MM_PRODUCER_CFG 
bootstrap.servers=localhost:9093
acks=1
batch.size=100
client.id=mirror_maker_producer
END_MM_PRODUCER_CFG
```

Start mirror maker
```
bin/kafka-run-class.sh kafka.tools.MirrorMaker --consumer.config config/mm_consumer.properties --num.streams 2 --producer.config config/mm_producer.properties --whitelist="test.*"
```

Produce some messages
```
echo 12222 | ./bin/kafka-console-producer.sh --broker-list localhost:9092 --request-required-acks=1 --topic test1
echo 12222 | ./bin/kafka-console-producer.sh --broker-list localhost:9092 --request-required-acks=1 --topic test2
```

Verify 
```
ls /tmp/kafka-logs-2 
cleaner-offset-checkpoint        meta.properties                  replication-offset-checkpoint    test2-0
log-start-offset-checkpoint      recovery-point-offset-checkpoint test1-0
```

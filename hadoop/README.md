## Pull centos docker image
```docker pull centos:7```

## Start docker container
```docker run  -td 98d35105a391```

## Attach to container
```docker exec -it 477176370b244e3c81080d4ccdc4404ab5c739d3598bbd05fb7cf7a8437e5c0c  bash```

### Provision container - look at pseudo_hadoop260.sh and provision

## Build your own docker
Download Dockerfile and pseudo_hadoop260.sh into some directory

```
$ docker build -t mypseudo .
$ docker run  -td e22039eea8ee
$ docker exec -it 8009  bash
[root@8009bb905236 /]# nohup /usr/sbin/sshd -D&  #give some time to let sshd start
[root@8009bb905236 /]# . /etc/environment
[root@8009bb905236 /]# /hadoop-2.6.0/sbin/start-all.sh 
[root@8009bb905236 /]# /hadoop-2.6.0/bin/hadoop jar /hadoop-2.6.0/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.6.0.jar grep input output2 'dfs[a-z.]+'
[root@8009bb905236 /]# nohup /hadoop-2.6.0/bin/mapred historyserver start&
```

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
$ docker run  -td e22039eea8ee    # with docker images you can see actual image id 
$ docker exec -it 8009  bash
[root@8009bb905236 /]# nohup /usr/sbin/sshd -D&  #give some time to let sshd start
[root@8009bb905236 /]# . /etc/environment
[root@8009bb905236 /]# /hadoop-2.6.0/sbin/start-all.sh 
[root@8009bb905236 /]# nohup /hadoop-2.6.0/bin/mapred historyserver start&
[root@8009bb905236 /]# /hadoop-2.6.0/bin/hadoop jar /hadoop-2.6.0/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.6.0.jar grep input output2 'dfs[a-z.]+'
```

### Exposing ports to host OS
After you did some work in the container (e.g. installed extra packages), you may want to keep your changes and create a separate docker image. Docker commit help in this. With commit you can also expose additional ports that can be useful for debugging.
   
```
$ docker commit -c "EXPOSE 80" -c "EXPOSE 5005" e22039eea8ee
$ docker tag 3863a  my_pseudo_wip
$ docker run --security-opt seccomp:unconfined -p 15005:5005 -v "/Users/asasvari/workspace/apache/oozie_dup:/data" -v "/Users/asasvari/.git:/root/.git" -td my_pseudo_wip
```
Some explanation:
The last command will run container exposing 5005 as 15005 (so that you can attach to your stuff with your debugger) and mount some volumes (directories) from the host. 
* ``--security-opt seccomp:unconfined`` is good if you want to do some low level system call investigation (and you see strace: test_ptrace_setoptions_for_all: PTRACE_TRACEME doesn't work: Operation not permitted).
 
### Misc
* Copying files from container to host
``docker cp 9b48dfe09893:/data/distro/target/oozie-4.4.0-SNAPSHOT-distro/oozie-4.4.0-SNAPSHOT/traf.pcap .``
* You may want to install net-tools.x86_64, strace, tcpdump as part of building the image.

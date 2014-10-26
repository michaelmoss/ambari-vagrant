# Ambari on Vagrant

This project helps to set up a 1 node (up to 10) Ambari cluster on Vagrant.
Started from the Apache Ambari [Quick Start Guide](https://cwiki.apache.org/confluence/display/AMBARI/Quick+Start+Guide) and modified.

vagrant box add centos65-x86_64-20140116 https://github.com/2creatives/vagrant-centos/releases/download/v6.5.3/centos65-x86_64-20140116.box

Using this will produce 1 node:

- **c6401** : ambar-server + ambari-agent connecting to himself

## Requirements

You need [VirtualBox](https://www.virtualbox.org/) and [Vagrant](http://www.vagrantup.com/)

## start 3 nodes

Starts up 3 nodes, provosioning nodes with ambari agents connecting to the master **c6401**
```
git clonegit@github.com:michaelmoss/ambari-vagrant.git
cd ambari-vagrant
vagrant up
```

## deploy cluster with ambari

Since Ambari 1.5 there is a new way to declaratively specify your cluseter, called
[Blueprints](https://cwiki.apache.org/confluence/display/AMBARI/Blueprints)

```
./blueprint-1-node.sh
```

## Once you very that ambari is up and running
```
vagrant ssh
./post_install.sh
```

# When things go wrong
AMBARI_URL=192.168.64.101:8080
curl -H "X-Requested-By: ambari" -X DELETE -u admin:admin http://$AMBARI_URL/api/v1/blueprints/single-node-hdfs-yarn
curl -H "X-Requested-By: ambari" -X DELETE -u admin:admin http://$AMBARI_URL/api/v1/clusters/MySingleNodeCluster
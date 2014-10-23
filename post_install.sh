echo "With Hadoop running, finalizing Accumulo install"
sudo su hdfs
hadoop fs -mkdir /accumulo
hadoop fs -chown vagrant:vagrant /accumulo

hadoop fs -mkdir /user/vagrant
hadoop fs -chown vagrant:vagrant /user/vagrant
exit

/usr/lib/accumulo/bin/accumulo init --clear-instance-name <<EOF
accumulo
dev
dev
EOF